import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'home_page.dart';

// 2. Create stateful login page.
class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                hintText: 'Username',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
                onPressed: () {
                  _pageNavigator(context, usernameController.text);
                },
                child: const Text('Login')),
            // 5. Add social media login buttons.
            SignInButton(
              Buttons.Google,
              onPressed: () {
                _pageNavigator(context, usernameController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 3. Add a method to navigate to the home page.
Future _pageNavigator(context, username) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => HomePage(
        username: username,
      ),
    ),
  );
}
