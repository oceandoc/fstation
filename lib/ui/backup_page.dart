import 'dart:io';
import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:app_settings/app_settings.dart';
import 'package:synchronized/synchronized.dart';

import '../generated/data.pbenum.dart';
import '../generated/l10n.dart';
import '../impl/logger.dart';
import '../impl/setting_impl.dart';
import '../impl/media_manager.dart';
import '../model/asset.dart';
import '../impl/grpc_client.dart';

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
  PermissionStatus? _permissionStatus;
  final Map<String, double> _uploadProgress = {};
  final Set<String> _uploadingAssets = {};
  final List<Asset> _pendingAssets = [];
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

      final content = await file.readAsBytes();
      final repoUuid = SettingImpl.instance.serverRepoUuids.first;
      final fileName = asset.fileName;

      await for (final response in GrpcClient.instance.uploadFile(
        fileName,
        '/photos/$fileName',
        repoUuid,
        content,
        FileType.Regular,
      )) {
        if (mounted) {
          setState(() {
            _uploadProgress[asset.localId!] =
                response.partitionNum / response.totalPartitions;
          });
        }
      }

      // Upload completed
      if (mounted) {
        setState(() {
          _uploadingAssets.remove(asset.localId);
          _uploadProgress.remove(asset.localId);
        });
      }
    } catch (e) {
      Logger.error('Error uploading asset: ${asset.fileName}', e);
      if (mounted) {
        setState(() {
          _uploadingAssets.remove(asset.localId);
          _uploadProgress.remove(asset.localId);
          _pendingAssets.add(asset); // Retry later
        });
      }
    } finally {
      // Start next upload when this one finishes
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

  Widget _buildPermissionLimited() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.photo_library_outlined,
                size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              Localization.current.permission_onboarding_permission_limited,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => openAppSettings(),
                  child: Text(Localization
                      .current.permission_onboarding_go_to_settings),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () => setState(
                      () => _permissionStatus = PermissionStatus.granted),
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
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.no_photography, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
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

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_permissionStatus?.isLimited ?? false) {
      return Scaffold(body: _buildPermissionLimited());
    }

    if (_permissionStatus!.isDenied) {
      return Scaffold(body: _buildPermissionDenied());
    }

    // Rest of your backup page UI when permissions are granted
    return Scaffold(
      appBar: AppBar(title: Text(Localization.current.backup_title)),
      body: ListView(
        children: [
          _buildConfigSection(),
          const Divider(),
          _buildBackupList(),
        ],
      ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._pendingAssets.map((asset) => ListTile(
                leading: Icon(
                  asset.type == AssetType.video
                      ? Icons.video_collection
                      : Icons.photo,
                ),
                title: Text(asset.fileName),
                subtitle: const LinearProgressIndicator(value: 0),
                trailing: const Text('Pending'),
              )),
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
        ],
      ),
    );
  }

  Asset? _findAssetById(String id) {
    return _pendingAssets.firstWhere(
      (asset) => asset.localId == id,
      orElse: () => null,
    );
  }
}
