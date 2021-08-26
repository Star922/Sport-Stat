import 'dart:convert';

import 'package:smartforce_test/data/model/user.dart';

class Event {
  final String id;
  final String title;
  final int price;
  final String date;
  final List<String> images;
  final int matchPercent;
  final User user;
  final String location;
  Event({
    required this.id,
    required this.title,
    required this.price,
    required this.date,
    required this.images,
    required this.matchPercent,
    required this.location,
    required this.user,
  });
}
