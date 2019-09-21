import 'package:flutter/material.dart';
import 'package:flutter_course/scoped-models/main.dart';

import './input.dart';
import './display.dart';

class NavigatorPage extends StatelessWidget {
  final MainModel model;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  NavigatorPage(this.model);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
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
              print('Prfile');
            },
          ),
          ListTile(
            leading: Icon(Icons.save),
            title: Text('Save'),
            onTap: () {
              Navigator.pop(context);
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text('Saved!'),
                  duration: Duration(seconds: 2),
                ),
              );
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
          key: _scaffoldKey,
          drawer: _buildSideDrawer(context),
          appBar: AppBar(
            centerTitle: true,
            title: Text('Flight App'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: 'Input',
                ),
                Tab(
                  text: 'Display',
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
