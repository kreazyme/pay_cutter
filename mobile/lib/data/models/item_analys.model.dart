import 'dart:math';

import 'package:flutter/material.dart';

class ItemAnalysModel {
  final String name;
  int total;
  final Color color;
  final int id;

  ItemAnalysModel addColor() => ItemAnalysModel(
        name: name,
        total: total,
        id: id,
        color: _generateRandomColor(),
      );

  ItemAnalysModel({
    required this.name,
    required this.total,
    required this.id,
    required this.color,
  });
}

Color _generateRandomColor() {
  return Color.fromARGB(
    255,
    Random().nextInt(256),
    Random().nextInt(256),
    Random().nextInt(256),
  ).withOpacity(0.5);
}
