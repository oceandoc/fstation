import 'dart:ui';

import 'package:flutter/material.dart';

class GlassMorphismCover extends StatelessWidget {
  const GlassMorphismCover({
    required this.child, required this.borderRadius, super.key,
    this.displayShadow = true,
    this.sigmaX = 40.0,
    this.sigmaY = 40.0,
  });
  final Widget child;
  final BorderRadius borderRadius;
  final bool displayShadow;
  final double sigmaX;
  final double sigmaY;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            blurRadius: 24,
            spreadRadius: 16,
            color: Colors.black.withOpacity(displayShadow ? 0.1 : 0.0),
          )
        ]),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: sigmaX,
              sigmaY: sigmaY,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
