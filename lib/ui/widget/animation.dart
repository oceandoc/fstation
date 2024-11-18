import 'dart:async';

import 'package:flutter/material.dart';

class Animator extends StatefulWidget {
  const Animator({super.key, this.child, this.time});
  final Widget? child;
  final Duration? time;

  @override
  AnimatorState createState() => AnimatorState();
}

class AnimatorState extends State<Animator>
    with SingleTickerProviderStateMixin {
  late Timer timer;
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 290), vsync: this);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    timer = Timer(widget.time!, animationController.forward);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: widget.child,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: animation.value as double,
          child: Transform.translate(
            offset: Offset(0, (1 - (animation.value as double)) * 20),
            child: child,
          ),
        );
      },
    );
  }
}

Timer? timer;
Duration duration = Duration.zero;

Duration wait() {
  if (timer == null || !timer!.isActive) {
    timer = Timer(const Duration(microseconds: 120), () {
      duration = Duration.zero;
    });
  }
  return duration += const Duration(milliseconds: 100);
}

class WidgetAnimator extends StatelessWidget {
  const WidgetAnimator({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Animator(
      time: wait(),
      child: child,
    );
  }
}
