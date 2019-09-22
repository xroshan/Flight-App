import 'package:flutter/material.dart';
import 'package:flutter_course/scoped-models/main.dart';

import './input.dart';
import './display.dart';
import './profile.dart';

class NavigatorPage extends StatelessWidget {
  final MainModel model;

  NavigatorPage(this.model);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage(model)));
            },
          ),
          ListTile(
            leading: Icon(Icons.save),
            title: Text('Save'),
            onTap: () {
              model.updateTrip();
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text('Sign Out'),
            onTap: () {
              model.signOutGoogle();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: _buildSideDrawer(context),
          appBar: AppBar(
            centerTitle: true,
            title: Text('Flight App'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: 'Airports',
                ),
                Tab(
                  text: 'Recommendations',
                )
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              InputPage(model),
              DisplayPage(),
            ],
          ),
        ),
      ),
    );
  }
}
