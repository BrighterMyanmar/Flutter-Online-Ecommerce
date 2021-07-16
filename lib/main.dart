import 'package:flutter/material.dart';
import 'package:foodmonkey/pages/Chat.dart';
import 'package:foodmonkey/pages/Flash.dart';
import 'package:foodmonkey/pages/Home.dart';
import 'package:foodmonkey/pages/Login.dart';
import 'package:foodmonkey/pages/Record.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "/": (context) => Flash(),
      "/home": (context) => Home(),
      "/record": (context) => Record(),
      "/chat": (context) => Chat(),
      "/login": (context) => Login()
    },
    theme: ThemeData(fontFamily: "English"),
  ));
}
