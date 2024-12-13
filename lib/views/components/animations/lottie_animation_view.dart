import 'package:flutter/material.dart';
import 'package:instantgramclonexyz/views/components/animations/models/lottie_animations.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationView extends StatelessWidget {
  final LottieAnimation animation;
  final bool repeat;
  final bool reverse;

  const LottieAnimationView({
    super.key,
    required this.animation,
    this.repeat = true,
    this.reverse = true,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      animation.fullPath,
      repeat: repeat,
      reverse: reverse,
      animate: true,
    );
  }
}

extension GetLottieAnimation on LottieAnimation {
  String get fullPath => 'assets/animations/$name.json';
}
