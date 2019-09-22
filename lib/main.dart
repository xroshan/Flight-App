import 'package:flutter/material.dart';
import 'package:flutter_course/pages/navigator.dart';

import 'package:scoped_model/scoped_model.dart';

import './pages/auth.dart';
import './pages/navigator.dart';
import './scoped-models/main.dart';

const PrimaryColor =
    const Color(0xff212f3d); //declaring the color for the appbar

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  bool _isAuthenticated = false;

  @override
  void initState() {
    _model.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('building main page');
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: PrimaryColor,
          accentColor: Colors.blueAccent,
          buttonColor: Colors.blueAccent,
          hoverColor: Colors.blueAccent,
        ),
        //home: AuthPage(),
        routes: {
          '/': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : NavigatorPage(_model),
        },
      ),
    );
  }
}
