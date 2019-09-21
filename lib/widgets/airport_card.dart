import 'package:flutter/material.dart';
import '../models/airport.dart';

class AiportCard extends StatelessWidget {
  final Airport airport;
  AiportCard(this.airport);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Card(
        child: Center(
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
