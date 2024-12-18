import 'package:flutter/material.dart';
import 'package:fstation/model/asset.dart';
import 'package:fstation/ui/widget/photo_grid.dart';
import 'package:go_router/go_router.dart';

import '../generated/l10n.dart';
import '../util/ring_buffer.dart';
import 'widget/control_bottom_app_bar.dart';
import 'widget/loading_indicator.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({super.key});

  @override
  PhotosPageState createState() => PhotosPageState();
}

class PhotosPageState extends State<PhotosPage> {
  bool selectMode = false;
  RingBuffer<Asset> assetBuffer = RingBuffer<Asset>(1000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('图片'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
          color: Colors.black87,
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // TODO: Implement settings
            },
            color: Colors.black87,
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Expanded(
            child: PhotoGrid(assetBuffer: assetBuffer),
          ),
          if (selectMode) const ControlBottomAppBar(),
        ],
      ),
    );
  }

  Widget buildEmptyIndicator() =>
      const Center(child: Text('no_assets_to_show'));

  Widget buildLoadingIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const LoadingIndicator(),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              Localization.current.photo_page_building_timeline,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              Localization.current.photo_page_timeline_time_cost_tips,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
