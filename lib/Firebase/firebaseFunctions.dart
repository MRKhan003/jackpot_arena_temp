import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jackpot_arena/Firebase/userDetails.dart';
import 'package:jackpot_arena/Screens/homeScreen.dart';

class Firebasefunctions with ChangeNotifier {
  UserDetails currentUser = UserDetails();
  FirebaseAuth auth = FirebaseAuth.instance;
  late bool exception;

  Future<bool> signUp(String email, String pass, String userName) async {
    UserDetails userDetails = UserDetails();
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      if (credential.user != null) {
        exception = true;
        print("Data sent for authentication");
        userDetails.userID = credential.user!.uid;
        userDetails.userName = credential.user!.displayName;
        userDetails.email = credential.user!.email;
        userDetails.password = pass;
      }
      print(exception);

      return true;
    } on FirebaseAuthException catch (e) {
      exception = false;
      if (e.code == 'weak-password') {
        print(exception);
        print('The password provided is too weak.');
        return false;
      } else if (e.code == 'email-already-in-use') {
        print(exception);
        print('The account already exists for that email.');
        return false;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> loggingIn(
      String email, String pass, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      // ignore: unused_local_variable
      UserCredential userCredential =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      if (userCredential.user != null) {
        print(currentUser.email);
      }

      navigateToNextScreenAfterLogin(context);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        print('Invalid username or password');

        return false;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');

        return false;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

void navigateToNextScreenAfterLogin(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen()),
  );
}
