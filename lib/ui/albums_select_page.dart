import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

import '../generated/l10n.dart';
import '../impl/logger.dart';
import '../impl/setting_impl.dart';

class AlbumsSelectPage extends StatefulWidget {
  const AlbumsSelectPage({super.key});

  @override
  State<AlbumsSelectPage> createState() => _AlbumsSelectPageState();
}

class _AlbumsSelectPageState extends State<AlbumsSelectPage> {
  bool _isLoading = true;
  List<AssetPathEntity> _albums = [];
  late Set<String> _selectedAlbumIds;

  @override
  void initState() {
    super.initState();
    _selectedAlbumIds = Set.from(SettingImpl.instance.selectedAlbums);
    _loadAlbums();
  }

  Future<void> _loadAlbums() async {
    try {
      final albums = await PhotoManager.getAssetPathList(
        type: RequestType.common,
        hasAll: true,
      );

      setState(() {
        _albums = albums;
        _isLoading = false;
      });
    } catch (e) {
      Logger.error('Error loading albums', e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/backup'),
          icon: const Icon(Icons.close),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                if (_selectedAlbumIds.length == _albums.length) {
                  _selectedAlbumIds.clear();
                } else {
                  _selectedAlbumIds.addAll(_albums.map((a) => a.id));
                }
              });
            },
            child: Text(_selectedAlbumIds.length == _albums.length
                ? Localization.current.deselect_all
                : Localization.current.select_all),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: _selectedAlbumIds.isEmpty
                ? null
                : () async {
                    await SettingImpl.instance
                        .saveSelectedAlbums(_selectedAlbumIds.toList());
                    context.go('/backup');
                  },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey[300],
              disabledForegroundColor: Colors.grey[600],
            ),
            child: Text(
              '${Localization.current.confirm} (${_selectedAlbumIds.length})',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_albums.isEmpty) {
      return Center(
        child: Text(
          Localization.current.no_albums_found,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: _albums.length,
      itemBuilder: (context, index) {
        final album = _albums[index];
        return FutureBuilder<int>(
          future: album.assetCountAsync,
          builder: (context, snapshot) {
            final count = snapshot.data ?? 0;
            if (count == 0) return const SizedBox.shrink();

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (_selectedAlbumIds.contains(album.id)) {
                    _selectedAlbumIds.remove(album.id);
                  } else {
                    _selectedAlbumIds.add(album.id);
                  }
                });
              },
              child: Stack(
                children: [
                  FutureBuilder<AssetEntity?>(
                    future: album.getAssetListRange(start: 0, end: 1).then(
                          (assets) => assets.isEmpty ? null : assets.first,
                        ),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child:
                              const Center(child: CircularProgressIndicator()),
                        );
                      }

                      final asset = snapshot.data;
                      if (asset == null) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.photo_library),
                        );
                      }

                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: AssetEntityImage(
                          asset,
                          isOriginal: false,
                          thumbnailSize: const ThumbnailSize.square(200),
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _selectedAlbumIds.contains(album.id)
                            ? Colors.green
                            : Colors.white,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: _selectedAlbumIds.contains(album.id)
                          ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            album.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$count items',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
