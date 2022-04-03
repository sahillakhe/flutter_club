import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
var _changes = _auth.authStateChanges().listen((event) {});
