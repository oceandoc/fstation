import 'package:flutter/material.dart';
import 'package:fstation/ui/themes.dart';

import '../util/app_update.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isUpdateChecked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!isUpdateChecked) {
        await updateDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {},
          child: CustomScrollView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            slivers: [
              // customDiscoverBar(context), //AppBar
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    // CaraouselWidget(),
                  ],
                ),
              )
            ],
          ),
        ),
        backgroundColor: lightAccentColor,
      ),
    );
  }

}
