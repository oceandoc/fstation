import 'dart:math';

import 'package:flutter/material.dart';

class FlipCardAnimation extends StatefulWidget {
  const FlipCardAnimation(
      {required this.frontWidget, required this.rearWidget, super.key});

  final Widget Function(void Function()) frontWidget;
  final Widget Function(void Function()) rearWidget;

  @override
  State<FlipCardAnimation> createState() => _FlipCardAnimationState();
}

class _FlipCardAnimationState extends State<FlipCardAnimation>
    with SingleTickerProviderStateMixin {
  Widget _buildFront() {
    return Container(
      key: const ValueKey(true),
      child: widget.frontWidget(flipCard),
    );
  }

  void flipCard() {
    setState(() => _showFrontSide = !_showFrontSide);
  }

  Widget _buildRear() {
    return Container(
      key: const ValueKey(false),
      child: widget.rearWidget(flipCard),
    );
  }

  late bool _showFrontSide;

  @override
  void initState() {
    super.initState();
    _showFrontSide = true;
  }

  Widget _buildFlipAnimation() {
    return AnimatedSwitcher(
      layoutBuilder: (widget, list) => Stack(
        children: [widget!, ...list],
      ),
      transitionBuilder: __transitionBuilder,
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeInBack,
      switchOutCurve: Curves.easeInBack.flipped,
      child: _showFrontSide ? _buildFront() : _buildRear(),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);

    return AnimatedBuilder(
        animation: rotateAnim,
        builder: (context, child) {
          final isUnder = (ValueKey(_showFrontSide) != widget.key);
          var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
          tilt *= isUnder ? -1.0 : 1.0;
          final value = isUnder
              ? min(rotateAnim.value, pi / 2)
              : min(pi / 2, rotateAnim.value);

          return Transform(
            transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
            alignment: Alignment.center,
            child: widget,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return _buildFlipAnimation();
  }
}
