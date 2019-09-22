import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  Widget _signInButton(MainModel model) {
    return FlatButton(
      color: Colors.white,
      hoverColor: Colors.black87,
      splashColor: Colors.grey,
      onPressed: () {
        model.signInWithGoogle().whenComplete(() {
          Navigator.pushReplacementNamed(context, '/');
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      //highlightElevation: 0,
      //borderSide: BorderSide(color: Colors.white, style: BorderStyle.solid),
      child: Container(
        margin: const EdgeInsets.fromLTRB(70, 15, 70, 15),
        child: Text(
          'Log in',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff213148),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xff213148),
          child: Center(
            child: ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/fore.jpg',
                      width: 180,
                      height: 180,
                    ),
                    Text(
                      'ForeFlight\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\tChallenge',
                      style: TextStyle(
                        fontSize: 44,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w700,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(
                      height: 120,
                    ),
                    _signInButton(model),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
