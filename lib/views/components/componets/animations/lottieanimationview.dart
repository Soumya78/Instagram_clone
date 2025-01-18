import 'package:flutter/material.dart';
import 'package:instagram_clone/views/components/componets/animations/model/lottieanimation.dart';
import 'package:lottie/lottie.dart';

class Lottieanimationview extends StatelessWidget {
  final LottieAnimation lottieAnimation;
  final bool repeat;
  final bool reverse;
  const Lottieanimationview(
      {super.key,
      required this.lottieAnimation,
      this.repeat = true,
      this.reverse = false});

  @override
  Widget build(BuildContext context) =>
      Lottie.asset(lottieAnimation.fullPath, repeat: repeat, reverse: reverse);
}

extension GetfullPath on LottieAnimation {
  String get fullPath => 'lib/assets/animations/$name.json';
}
