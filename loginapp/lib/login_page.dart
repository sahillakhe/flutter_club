import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
// var _changes = _auth.authStateChanges().listen((event) {});

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

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser;

    // Trigger the authentication flow
    googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    // Obtain the auth details from the request

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void _authenticateGoogleSignIn() async {
    UserCredential userCredential = await signInWithGoogle();
    if (userCredential.user?.email != null) {
      _pageNavigator(context, userCredential.user?.email);
    }
  }

  void _authenticateEmailPassword() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );
      if (userCredential.user?.email != null) {
        _pageNavigator(context, userCredential.user?.email);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

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
                onPressed: () async {
                  _authenticateEmailPassword();
                },
                child: const Text('Login')),
            // 5. Add social media login buttons.
            SignInButton(
              Buttons.Google,
              onPressed: () async {
                _authenticateGoogleSignIn();
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
