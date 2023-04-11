import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppCustomLoading extends StatelessWidget {
  const AppCustomLoading({
    super.key,
    this.size,
  });

  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size ?? 200,
        width: size ?? 200,
        child: Lottie.asset('assets/anim/loading.json'));
  }
}
