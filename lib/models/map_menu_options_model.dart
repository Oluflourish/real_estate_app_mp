import 'package:flutter/material.dart';

enum MenuOptions { cosyAreas, price, infrastucture, withoutAnyLayer }

class MapOptionsModel {
  const MapOptionsModel(
      {required this.icon, required this.name, required this.menuOption});
  final IconData icon;
  final String name;
  final MenuOptions menuOption;
}
