import "package:flutter/material.dart";

import 'login_page.dart';

//4. Create statefule home page. Logout returns to login page.
class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.username}) : super(key: key);
  final String username;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Welcome ${widget.username}"),
            ElevatedButton(
                onPressed: () {
                  _pageNavigator(context);
                },
                child: const Text('Logout')),
          ],
        ),
      ),
    );
  }

  Future _pageNavigator(context) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
