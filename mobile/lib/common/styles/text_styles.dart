import 'package:flutter/material.dart';

abstract class TextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle titleBold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle subTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle bodyBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle detail = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle detailBold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );
}
