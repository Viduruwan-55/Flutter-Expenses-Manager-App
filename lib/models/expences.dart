//import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

part 'expences.g.dart';

final uuid = Uuid().v4();
final fomattedDate = DateFormat.yMd();

enum Category {
  food('food'),
  transport('transport'),
  entertainment('entertainment'),
  health('health');

  const Category(this.value);
  final String value;
}

final CategoryIcons = {
  Category.food: Icons.fastfood,
  Category.transport: Icons.directions_car_filled,
  Category.entertainment: Icons.movie_creation,
  Category.health: Icons.health_and_safety
};

@HiveType(typeId: 1)
class ExpenceMode {
  ExpenceMode(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid;
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final Category category;

  String get formattedDate {
    return fomattedDate.format(date);
  }
}
