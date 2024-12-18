import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

import '../../model/asset.dart';
import '../../util/mock_generate.dart';
import '../../util/ring_buffer.dart';
import 'loading_indicator.dart';

class PhotoGrid extends StatefulWidget {
  const PhotoGrid({
    required this.assetBuffer,
    super.key,
  });
  final RingBuffer<Asset> assetBuffer;

  @override
  State<PhotoGrid> createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  final ScrollController _scrollController = ScrollController();

  final Map<String, List<Asset>> _groupedAssets = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _groupAssets();
  }

  @override
  void didUpdateWidget(PhotoGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.assetBuffer != widget.assetBuffer) {
      _groupAssets();
    }
  }

  // Load more images at the top
  Future<void> _loadMoreImagesAtTop() async {
    setState(() {
      _isLoading = true;
    });

    // Get mock assets and add them to the buffer
    final newAssets = mockServerReturnAssets();
    for (final asset in newAssets) {
      widget.assetBuffer.addPre(asset);
    }
    _groupAssets();

    // Preserve scroll position
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.offset + 300);
    });

    setState(() {
      _isLoading = false;
    });
  }

  // Load more images at the bottom
  Future<void> _loadMoreImagesAtBottom() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Get mock assets and add them to the buffer
    final newAssets = mockServerReturnAssets();
    for (final asset in newAssets) {
      widget.assetBuffer.addBack(asset);
    }
    _groupAssets();

    setState(() {
      _isLoading = false;
    });
  }

  void _groupAssets() {
    _groupedAssets.clear();
    for (final asset in widget.assetBuffer.toList()) {
      final dateStr = _formatDate(asset.fileCreatedAt);
      _groupedAssets.putIfAbsent(dateStr, () => []).add(asset);
    }
    // Sort assets within each group
    for (final assets in _groupedAssets.values) {
      assets.sort((a, b) {
        // First compare by creation date
        final dateCompare = a.fileCreatedAt.compareTo(b.fileCreatedAt);
        if (dateCompare != 0) {
          return dateCompare;
        }
        // If dates are equal, compare by thumbhash
        return (a.thumbhash ?? '').compareTo(b.thumbhash ?? '');
      });
    }
    setState(() {});
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  void _scrollListener() {
    if (_scrollController.position.pixels <= 0 && !_isLoading) {
      _loadMoreImagesAtTop();
    }

    // Detect scroll to the bottom to load more images
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoading) {
      _loadMoreImagesAtBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        ..._groupedAssets.entries.map((entry) {
          return SliverStickyHeader(
            header: _buildDateHeader(entry.key),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index >= entry.value.length) return null;
                  return _buildPhotoItem(entry.value[index]);
                },
                childCount: entry.value.length,
              ),
            ),
          );
        }).toList(),
        if (_isLoading)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: LoadingIndicator()),
            ),
          ),
      ],
    );
  }

  Widget _buildDateHeader(String date) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        date,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String thumbnailUrl(Asset asset) {
    return 'http://192.168.4.112:10003/${asset.thumbhash}';
  }

  Widget _buildPhotoItem(Asset asset) {
    if (asset.local != null) {
      return AssetEntityImage(
        asset.local!,
        isOriginal: false,
        thumbnailSize: const ThumbnailSize.square(300),
        thumbnailFormat: ThumbnailFormat.jpeg,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: LoadingIndicator());
        },
      );
    }

    // For remote assets
    return CachedNetworkImage(
      imageUrl: thumbnailUrl(asset) ?? '',
      fit: BoxFit.cover,
      placeholder: (context, url) => const Center(child: LoadingIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
}

// Helper widget for sticky headers
class SliverStickyHeader extends StatelessWidget {
  const SliverStickyHeader({
    super.key,
    required this.header,
    required this.sliver,
  });
  final Widget header;
  final Widget sliver;

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _StickyHeaderDelegate(child: header),
        ),
        sliver,
      ],
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  _StickyHeaderDelegate({required this.child});
  final Widget child;

  @override
  Widget build(context, shrinkOffset, overlapsContent) => child;

  @override
  double get maxExtent => 40;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) => false;
}
