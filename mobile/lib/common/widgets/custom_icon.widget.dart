import 'package:flutter/material.dart';

class CustomIcon extends Icon {
  final double? iconSize;
  final IconData iconData;
  final Color? iconColor;

  const CustomIcon({
    super.key,
    required this.iconData,
    this.iconSize,
    this.iconColor,
  }) : super(
          iconData,
          size: iconSize ?? 24,
          color: iconColor ?? Colors.white,
        );
}
