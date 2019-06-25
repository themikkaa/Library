import 'package:flutter/material.dart';
import 'package:ketabkhane_app/Home.dart';
import 'package:ketabkhane_app/Login.dart';
import 'package:ketabkhane_app/Splash.dart';
import 'package:ketabkhane_app/Register.dart';
import 'package:ketabkhane_app/profile.dart';

void main() {
  runApp(new MaterialApp(
    home: new Splash(),
    routes: <String, WidgetBuilder>{
      '/Register': (BuildContext context) => new Register(),
      '/Login': (BuildContext context) => new Login(),
      '/Home': (BuildContext context) => new Home(),
      '/Profile': (BuildContext context) => new Profile(),
    },
  ));
}
