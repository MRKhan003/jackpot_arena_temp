import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jackpot_arena/AccountAuth/loginUser.dart';
import 'package:jackpot_arena/Firebase/userDatabase.dart';
import 'package:jackpot_arena/Firebase/userDetails.dart';
import 'package:jackpot_arena/Screens/homeScreen.dart';

class Firebasefunctions with ChangeNotifier {
  UserDetails currentUser = UserDetails();
  FirebaseAuth auth = FirebaseAuth.instance;
  late bool exception;
  List<String> userNames = [];
  Future<bool> getUserNames(String userName) async {
    CollectionReference getUserName =
        FirebaseFirestore.instance.collection('Users');
    QuerySnapshot snapshot = await getUserName.get();
    snapshot.docs.forEach((doc) {
      userNames.add(doc['UserName']);
    });
    print(userNames);
    for (var i = 0; i < userNames.length; i++) {
      try {
        if (userNames.length == 0) {
          print('Successfull');
        } else if (userName == userNames[i]) {
          Fluttertoast.showToast(
              msg: "User name already exist",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.yellow,
              textColor: Colors.white,
              fontSize: 16.0);
          return false;
        } else {
          continue;
        }
        return true;
      } catch (e) {
        print(e);
        return false;
      }
    }
    return true;
  }

  Future<bool> signUp(
      String email, String pass, String userName, BuildContext context) async {
    UserDetails userDetails = UserDetails();
    if (getUserNames(userName) != false) {
      try {
        // getUserNames(userName);
        UserCredential credential = await auth.createUserWithEmailAndPassword(
            email: email, password: pass);
        if (credential.user != null) {
          userDetails.userID = credential.user!.uid;
          userDetails.userName = userName;
          userDetails.email = credential.user!.email;
          userDetails.password = pass;
        }
        Fluttertoast.showToast(
            msg: "Account Created Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        UserDatabase().sendUserData(userDetails);
        navigateToNextScreenAfterSignUp(context);

        return true;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Fluttertoast.showToast(
              msg: e.code,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.yellow,
              textColor: Colors.white,
              fontSize: 16.0);
          return false;
        } else if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(
              msg: e.code,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.yellow,
              textColor: Colors.white,
              fontSize: 16.0);
          return false;
        }
        return false;
      } catch (e) {
        Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> loggingIn(
      String email, String pass, BuildContext context) async {
    FirebaseAuth loginAuth = FirebaseAuth.instance;
    try {
      print('Testing...');
      UserCredential loginCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      print('Testing...');
      if (loginCredential.user != null) {
        Fluttertoast.showToast(
            msg: "Login Successfull",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        print('Error');
      }
      navigateToNextScreenAfterLogin(context);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        Fluttertoast.showToast(
            msg: 'Invalid email or password',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print(e.code);
        return false;
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: e.code,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print('$e');
        return false;
      } else {
        Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print(e.code);
      }
      return false;
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      print('$e');
      return false;
    }
  }

  Future<UserDetails> checkLoginInfo() async {
    UserDetails myUser = UserDetails();
    myUser.isLoadingStartupData = true;
    try {
      currentUser = myUser;
      auth.authStateChanges().listen((event) async {
        if (event?.uid == null) {
          myUser.userID = null;
          myUser.isLoadingStartupData = false;
          setCurrentUser(myUser);
        } else {
          myUser.userID = event?.uid;
          myUser = await UserDatabase().getUserbyID(auth.currentUser!.uid);
          myUser.isLoadingStartupData = false;
          setCurrentUser(myUser);
        }
      });
      return myUser;
    } catch (e) {
      print(e);
      return null!;
    }
  }

  Future<bool> sendPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Successfull!'),
            content: Text('Link sent to your email.'),
          );
        },
      );
      return true;
    } on FirebaseException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error!'),
            content: Text(e.message.toString()),
          );
        },
      );
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> verifyResetCode(String code, String newPassword) async {
    try {
      String email = await FirebaseAuth.instance.verifyPasswordResetCode(code);
      print('Password reset code is valid for email: $email');
      // Prompt the user to enter a new password and complete the reset process
      await resetPassword(code, newPassword);
    } catch (e) {
      print('Failed to verify password reset code: $e');
    }
  }

  Future<void> resetPassword(String code, String newPassword) async {
    try {
      await FirebaseAuth.instance.confirmPasswordReset(
        code: code,
        newPassword: newPassword,
      );
      print('Password has been reset successfully');
    } catch (e) {
      print('Failed to reset password: $e');
    }
  }

  Future<bool> logout(BuildContext context) async {
    try {
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserLogin(),
        ),
      );
      return true;
    } catch (e) {
      print("$e");
      return false;
    }
  }

  void setCurrentUser(UserDetails user) {
    currentUser = user;
    notifyListeners();
  }
}

void navigateToNextScreenAfterLogin(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen()),
  );
}

void navigateToNextScreenAfterSignUp(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => UserLogin()),
  );
}
