import 'dart:async';
import 'dart:io';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:app_settings/app_settings.dart';
import 'package:synchronized/synchronized.dart';

import '../generated/data.pbenum.dart';
import '../generated/error.pbenum.dart';
import '../generated/l10n.dart';
import '../impl/grpc_client.dart';
import '../impl/logger.dart';
import '../impl/media_manager.dart';
import '../impl/setting_impl.dart';
import '../model/asset.dart';

// TODO(xieyz): ios need add permison info to plist.info file
class BackupPage extends StatefulWidget {
  const BackupPage({super.key});

  @override
  State<BackupPage> createState() => _BackupPageState();
}

class _BackupPageState extends State<BackupPage> {
  bool _isLoading = true;
  bool _autoBackup = false;
  bool _backgroundBackup = false;
  int _selectedTabIndex = 0;
  PermissionStatus? _permissionStatus;
  final Map<String, double> _uploadProgress = {};
  final Set<String> _uploadingAssets = {};
  final List<Asset> _pendingAssets = [];
  final List<Asset> _failedAssets = [];
  static const int maxConcurrentUploads = 5;
  final _lock = Lock();

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    try {
      final status = await getGalleryPermissionStatus();
      if (status.isDenied) {
        final newStatus = await requestGalleryPermission();
        setState(() {
          _permissionStatus = newStatus;
          _isLoading = false;
        });
        if (!newStatus.isGranted) {
          return;
        }
      } else {
        setState(() {
          _permissionStatus = status;
          _isLoading = false;
        });
      }
      if (_permissionStatus?.isGranted == true) {
        await _loadBackupData();
      }
    } catch (e) {
      Logger.error('Error checking permissions', e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadBackupData() async {
    try {
      _pendingAssets.clear();
      _pendingAssets.addAll(await getAllUniqueAssets());
      setState(() {}); // Refresh UI with pending assets
      _startUploads();
    } catch (e) {
      Logger.error('Error loading backup data', e);
    }
  }

  Future<void> _startUploads() async {
    if (_uploadingAssets.length >= maxConcurrentUploads) return;

    while (_pendingAssets.isNotEmpty &&
        _uploadingAssets.length < maxConcurrentUploads) {
      final asset = _pendingAssets.removeAt(0);
      unawaited(_uploadAsset(asset)); // Allow concurrent execution
    }
  }

  Future<void> _uploadAsset(Asset asset) async {
    // Synchronized block to protect shared state
    final shouldUpload = await _lock.synchronized(() {
      if (_uploadingAssets.contains(asset.localId)) return false;
      _uploadingAssets.add(asset.localId!);
      _uploadProgress[asset.localId!] = 0;
      return true;
    });

    if (!shouldUpload) return;
    setState(() {}); // Update UI after lock released

    try {
      final file = await asset.local?.file;
      if (file == null) return;

      const chunkSize = 4 * 1024 * 1024; // 4MB chunks
      final fileSize = await file.length();
      final totalChunks = (fileSize / chunkSize).ceil();
      final raf = await file.open();

      // Calculate SHA256 hash
      final digest = AccumulatorSink<Digest>();
      final hasher = sha256.startChunkedConversion(digest);
      var bytesRead = 0;

      while (bytesRead < fileSize) {
        final chunk = await raf.read(
          bytesRead + chunkSize > fileSize ? fileSize - bytesRead : chunkSize,
        );
        hasher.add(chunk);
        bytesRead += chunk.length;
      }

      hasher.close();
      final fileHash = digest.events.single.toString();
      await raf.setPosition(0); // Reset file position

      for (var i = 0; i < totalChunks; i++) {
        final start = i * chunkSize;
        final end = (i + 1) * chunkSize;
        raf.setPositionSync(start);
        final chunk = await raf.read(
          end > fileSize ? fileSize - start : chunkSize,
        );

        await for (final response in GrpcClient.instance.uploadFile(
          src: asset.fileName,
          dst: '',
          repoUuid: SettingImpl.instance.serverRepoUuids.first,
          content: chunk,
          fileType: FileType.Regular,
          partitionNum: i,
          partitionSize: chunkSize,
          fileSize: chunk.length,
          repoType: RepoType.RT_Ocean,
          fileHash: fileHash,
        )) {
          if (response.errCode == ErrCode.Success) {
            debugPrint(
                'uploaded chunk ${i + 1}/$totalChunks for ${asset.fileName}');
          } else {
            Logger.error(
                'chunk ${i + 1}/$totalChunks for ${asset.fileName} failed');
          }
          if (mounted) {
            setState(() {
              _uploadProgress[asset.localId!] = (i + 1) / totalChunks;
            });
          }
        }
      }
      await raf.close();
      // Upload completed
      if (mounted) {
        setState(() {
          _uploadingAssets.remove(asset.localId);
          _uploadProgress.remove(asset.localId);
        });
      }
    } catch (e, s) {
      Logger.error('Error uploading asset: ${asset.fileName}\n'
          'Error: $e\n'
          'Stack trace:\n$s');
      if (mounted) {
        setState(() {
          _uploadingAssets.remove(asset.localId);
          _uploadProgress.remove(asset.localId);
          _failedAssets.add(asset); // Add to failed list
        });
      }
    } finally {
      if (mounted) {
        Future.microtask(() => _startUploads());
      }
    }
  }

  Future<List<Asset>> getAllUniqueAssets() async {
    final selectedAlbumIds = SettingImpl.instance.selectedAlbums;
    if (selectedAlbumIds.isEmpty) {
      return [];
    }

    final Set<String> processedAssetIds = {};
    final List<Asset> uniqueAssets = [];

    for (final albumId in selectedAlbumIds) {
      final assets = await MediaManager.instance.getAlbumAssets(albumId);

      for (final asset in assets) {
        if (!processedAssetIds.contains(asset.localId)) {
          processedAssetIds.add(asset.localId!);
          uniqueAssets.add(asset);
        }
      }
    }

    return uniqueAssets;
  }

  /// Requests the gallery permission
  Future<PermissionStatus> requestGalleryPermission() async {
    PermissionStatus result;
    // Android 32 and below uses Permission.storage
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        // Android 32 and below need storage
        final permission = await Permission.storage.request();
        result = permission;
      } else {
        // Android 33 need photo & video
        final photos = await Permission.photos.request();
        if (!photos.isGranted) {
          // Don't ask twice for the same permission
          return photos;
        }
        final videos = await Permission.videos.request();

        // Return the joint result of those two permissions
        final PermissionStatus status;
        if ((photos.isGranted && videos.isGranted) ||
            (photos.isLimited && videos.isLimited)) {
          status = PermissionStatus.granted;
        } else if (photos.isDenied || videos.isDenied) {
          status = PermissionStatus.denied;
        } else if (photos.isPermanentlyDenied || videos.isPermanentlyDenied) {
          status = PermissionStatus.permanentlyDenied;
        } else {
          status = PermissionStatus.denied;
        }

        result = status;
      }
      if (result == PermissionStatus.granted &&
          androidInfo.version.sdkInt >= 29) {
        result = await Permission.accessMediaLocation.request();
      }
    } else {
      // iOS can use photos
      final photos = await Permission.photos.request();
      result = photos;
    }
    return result;
  }

  /// Checks the current state of the gallery permissions without
  /// requesting them again
  Future<PermissionStatus> getGalleryPermissionStatus() async {
    PermissionStatus result;
    // Android 32 and below uses Permission.storage
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        // Android 32 and below need storage
        final permission = await Permission.storage.status;
        result = permission;
      } else {
        // Android 33 needs photo & video
        final photos = await Permission.photos.status;
        final videos = await Permission.videos.status;

        // Return the joint result of those two permissions
        final PermissionStatus status;
        if ((photos.isGranted && videos.isGranted) ||
            (photos.isLimited && videos.isLimited)) {
          status = PermissionStatus.granted;
        } else if (photos.isDenied || videos.isDenied) {
          status = PermissionStatus.denied;
        } else if (photos.isPermanentlyDenied || videos.isPermanentlyDenied) {
          status = PermissionStatus.permanentlyDenied;
        } else {
          status = PermissionStatus.denied;
        }

        result = status;
      }
      if (result == PermissionStatus.granted &&
          androidInfo.version.sdkInt >= 29) {
        result = await Permission.accessMediaLocation.status;
      }
    } else {
      // iOS can use photos
      final photos = await Permission.photos.status;
      result = photos;
    }
    return result;
  }

  Widget _buildPermissionRequest() {
    if (_permissionStatus?.isLimited ?? false) {
      return _buildPermissionLimited();
    }
    return _buildPermissionDenied();
  }

  Widget _buildPermissionLimited() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Localization.current.permission_onboarding_permission_limited,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => openAppSettings(),
                  child: Text(Localization
                      .current.permission_onboarding_go_to_settings),
                ),
                TextButton(
                  onPressed: _loadBackupData,
                  child: Text(Localization
                      .current.permission_onboarding_continue_anyway),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionDenied() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Localization.current.permission_onboarding_permission_denied,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => openAppSettings(),
              child: Text(
                  Localization.current.permission_onboarding_go_to_settings),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfigDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: _buildConfigSection(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        centerTitle: true,
        title: Text(
          Localization.current.backup_title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/backup/settings'),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _permissionStatus?.isGranted != true
              ? _buildPermissionRequest()
              : _buildBackupList(),
    );
  }

  Widget _buildConfigSection() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Localization.current.backup_settings,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: Text(Localization.current.auto_backup),
              subtitle: Text(Localization.current.auto_backup_desc),
              value: _autoBackup,
              onChanged: (value) {
                setState(() {
                  _autoBackup = value;
                });
              },
            ),
            SwitchListTile(
              title: Text(Localization.current.background_backup),
              subtitle: Text(Localization.current.background_backup_desc),
              value: _backgroundBackup,
              onChanged: _autoBackup
                  ? (value) {
                      setState(() {
                        _backgroundBackup = value;
                      });
                    }
                  : null,
            ),
            const Divider(),
            ListTile(
              title: Text(Localization.current.choose_backup_albums),
              subtitle: Text(
                SettingImpl.instance.selectedAlbums.isEmpty
                    ? Localization.current.no_albums_selected
                    : '${SettingImpl.instance.selectedAlbums.length} ${Localization.current.albums_selected}',
                style: TextStyle(color: Colors.grey),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                context.go('/select_albums');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackupList() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(4),
                  onTap: () => setState(() => _selectedTabIndex = 0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: [
                        Text(
                          '正在备份',
                          style: TextStyle(
                            color: _selectedTabIndex == 0
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 2,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          color: _selectedTabIndex == 0
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(4),
                  onTap: () => setState(() => _selectedTabIndex = 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: [
                        Text(
                          '备份失败',
                          style: TextStyle(
                            color: _selectedTabIndex == 1
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 2,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          color: _selectedTabIndex == 1
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: _selectedTabIndex == 0
                  ? _buildBackupListContent()
                  : _buildFailedListContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackupListContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_uploadingAssets.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                '没有正在备份的文件',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ),
          )
        else
          ..._uploadingAssets.map((id) {
            final asset = _findAssetById(id);
            if (asset == null) return const SizedBox.shrink();
            final progress = _uploadProgress[id] ?? 0;
            return ListTile(
              leading: Icon(
                asset.type == AssetType.video
                    ? Icons.video_collection
                    : Icons.photo,
              ),
              title: Text(asset.fileName),
              subtitle: LinearProgressIndicator(value: progress),
              trailing: Text('${(progress * 100).toInt()}%'),
            );
          }),
        if (_pendingAssets.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '等待备份: ${_pendingAssets.length}个文件',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ),
      ],
    );
  }

  Widget _buildFailedListContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _failedAssets
          .map((asset) => ListTile(
                leading: Icon(
                  asset.type == AssetType.video
                      ? Icons.video_collection
                      : Icons.photo,
                  color: Colors.red,
                ),
                title: Text(asset.fileName),
                subtitle: const Text('Upload failed'),
                trailing: IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    setState(() {
                      _failedAssets.remove(asset);
                      _pendingAssets.add(asset);
                    });
                    _startUploads();
                  },
                ),
              ))
          .toList(),
    );
  }

  Asset? _findAssetById(String id) {
    try {
      return _pendingAssets.firstWhere((asset) => asset.localId == id);
    } catch (e) {
      return null;
    }
  }
}
