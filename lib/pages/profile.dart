import 'package:flutter/material.dart';
import '../scoped-models/main.dart';

class ProfilePage extends StatelessWidget {
  final MainModel model;

  ProfilePage(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.person_outline),
              title: Text(model.user.displayName ?? ""),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text(model.user.email ?? ""),
            ),
            ListTile(
              leading: Icon(Icons.call),
              title: Text(model.user.phoneNumber ?? ""),
            ),
            ListTile(
              leading: Icon(Icons.pin_drop),
              title: Text(model.totalTrips().toString()),
            ),
          ],
        ),
      ),
    );
  }
}
