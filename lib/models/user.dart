import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String token;
  List<int> tripInfo = [];
  int totalTrips = 0;

  User({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.token,
  });
}
