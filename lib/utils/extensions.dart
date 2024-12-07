import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension WidgetAnimation on Widget {
  Animate fadeInFromTop({
    Duration? delay,
    Duration? animationDuration,
    Offset? offset,
  }) =>
      animate(delay: delay ?? 300.ms)
          .move(
            duration: animationDuration ?? 300.ms,
            begin: offset ?? const Offset(0, -10),
          )
          .fade(duration: animationDuration ?? 300.ms);

  Animate fadeInFromBottom({
    Duration? delay,
    Duration? animationDuration,
    Offset? offset,
  }) =>
      animate(delay: delay ?? 300.ms)
          .move(
            duration: animationDuration ?? 300.ms,
            begin: offset ?? const Offset(0, 10),
          )
          .fade(duration: animationDuration ?? 300.ms);

  // write fadeInFromRight

  Animate fadeInFromLeft({
    Duration? delay,
    Duration? animationDuration,
    Offset? offset,
  }) =>
      animate(delay: delay ?? 300.ms)
          .move(
            duration: animationDuration ?? 300.ms,
            begin: offset ?? const Offset(-10, 0),
          )
          .fade(duration: animationDuration ?? 300.ms);

  Animate fadeInFromRight({
    Duration? delay,
    Duration? animationDuration,
    Offset? offset,
  }) =>
      animate(delay: delay ?? 300.ms)
          .move(
            duration: animationDuration ?? 300.ms,
            begin: offset ?? const Offset(10, 0),
          )
          .fade(duration: animationDuration ?? 300.ms);

  Animate fadeIn({
    Duration? delay,
    Duration? animationDuration,
    Curve? curve,
  }) =>
      animate(delay: delay ?? 300.ms).fade(
        duration: animationDuration ?? 300.ms,
        curve: curve ?? Curves.decelerate,
      );

  Animate scale({
    Duration? delay,
    Duration? animationDuration,
    Curve? curve,
  }) =>
      animate(
        delay: delay ?? 300.ms,
      ).scale(
        duration: animationDuration ?? 300.ms,
        curve: curve ?? Curves.easeOut,
      );

  Animate scaleFromLeft({
    Duration? delay,
    Duration? animationDuration,
    Curve? curve,
  }) =>
      animate(
        delay: delay ?? 300.ms,
      ).scale(
        duration: animationDuration ?? 3100.ms,
        curve: curve ?? Curves.easeOut,
        begin: const Offset(0, -20),
        // end: const Offset(0, 0),
        // alignment: Alignment.bottomLeft,
      );

  Animate slideInFromBottom({
    Duration? delay,
    Duration? animationDuration,
    Curve? curve,
    double? begin,
  }) =>
      animate(
        delay: delay ?? 300.ms,
      ).slideY(
        duration: animationDuration ?? 300.ms,
        begin: begin ?? 0.2,
        end: 0,
        curve: curve ?? Curves.linear,
      );
}
