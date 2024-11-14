import 'package:flutter/material.dart';
import 'package:fstation/ui/widget/animation.dart';
import 'package:fstation/util/extensions.dart';
import 'package:shimmer/shimmer.dart';

class BlankPage extends StatefulWidget {
  const BlankPage({super.key});

  @override
  State<BlankPage> createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            WidgetAnimator(
              child: Image.asset(
                context.isDarkMode? 'assets/logo_grey.png': 'assets/logo_color.png',
                height: 100,
              ),
            ),
            const SizedBox(height: 10),
            Shimmer.fromColors(
              baseColor: context.isDarkMode ? Colors.white : Colors.black,
              highlightColor: context.isDarkMode ? Colors.grey : Colors.white,
              child: const Text('Loading...'),
            ),
          ],
        ),
      ),
    );
  }
}
