import 'package:flutter/material.dart';

import 'login_page.dart';

void main() {
  runApp(const FlutterClubLoginApp());
}

// 1. Basic starter class for a Flutter application.
class FlutterClubLoginApp extends StatelessWidget {
  const FlutterClubLoginApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
