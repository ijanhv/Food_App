import 'package:dineout/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;



  // sign in with email and password
  Future<void> signInWithEmailAndPassword(
      String email, String password) async {
    try {
          await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    try {
          await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}