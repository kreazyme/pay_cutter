import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({
    super.key,
    this.color,
    this.strokeWidth,
  });

  final Color? color;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color,
      strokeWidth: strokeWidth ?? 0,
    );
  }
}
