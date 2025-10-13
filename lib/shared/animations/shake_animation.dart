import 'dart:math' as math;

import 'package:flutter/material.dart';

class ShakeAnimation extends StatefulWidget {
  final Widget child;
  final int shakes; // number of back-and-forth shakes
  final double amplitude; // max translation in pixels
  final Duration duration;
  final bool autoPlay; // if true it starts shaking once on build

  const ShakeAnimation({
    super.key,
    required this.child,
    this.shakes = 5,
    this.amplitude = 8.0,
    this.duration = const Duration(milliseconds: 700),
    this.autoPlay = false,
  });

  @override
  ShakeAnimationState createState() => ShakeAnimationState();
}

class ShakeAnimationState extends State<ShakeAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);
    // value runs 0..1; we will convert to sin() inside builder to create shake pattern
    _animation = CurvedAnimation(parent: _ctrl, curve: Curves.linear);

    if (widget.autoPlay) {
      // small delay to allow layout
      WidgetsBinding.instance.addPostFrameCallback((_) => shake());
    }
  }

  /// Call this to trigger the shake
  void shake() {
    _ctrl.forward(from: 0.0);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // use sin wave to produce left-right shake
        final double progress = _animation.value; // 0..1
        final double offsetX =
            math.sin(progress * math.pi * 2 * widget.shakes) *
            widget.amplitude *
            // optional ease-out so it calms down near the end
            (1.0 - progress);
        return Transform.translate(offset: Offset(offsetX, 0), child: child);
      },
      child: widget.child,
    );
  }
}
