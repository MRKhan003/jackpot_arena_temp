import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jackpot_arena/AccountAuth/loginUser.dart';
import 'package:jackpot_arena/Firebase/userDatabase.dart';
import 'package:jackpot_arena/Firebase/userDetails.dart';
import 'package:jackpot_arena/Screens/homeScreen.dart';
import 'package:jackpot_arena/Startup/splashScreen.dart';

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

  Future<bool> signUp(String email, String pass, String userName, String name,
      BuildContext context) async {
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
          userDetails.name = name;
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
              msg: 'Use a strong password',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.yellow,
              textColor: Colors.white,
              fontSize: 16.0);
          return false;
        } else if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(
              msg: 'Email already in use',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.yellow,
              textColor: Colors.white,
              fontSize: 16.0);
          return false;
        } else if (e.code == 'network-request-failed') {
          Fluttertoast.showToast(
              msg: 'Internet Connection Failed',
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
    String profileImage = '';
    //FirebaseAuth loginAuth = FirebaseAuth.instance;
    try {
      print('Testing...');
      UserCredential loginCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);

      FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get()
          .then((DocumentSnapshot doc) {
        profileImage = doc['ProfileImage'];
      });
      print('Testing...');
      if (loginCredential.user != null) {
        Fluttertoast.showToast(
            msg: "Welcome back " +
                await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .get()
                    .then((DocumentSnapshot doc) {
                  return doc['UserName'];
                }),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        print('Error');
      }
      navigateToNextScreenAfterLogin(
        context,
        profileImage,
      );
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
      } else if (e.code == 'invalid-email') {
        Fluttertoast.showToast(
            msg: 'The email address is badly formatted',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print('$e');
        return false;
      } else if (e.code == 'network-request-failed') {
        Fluttertoast.showToast(
            msg: 'Internet Connection Failed',
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

  Future<bool> deleteUser(
    BuildContext context,
  ) async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SplashScreen(),
        ),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  void reauthenticateUser(
    String email,
    String currentPassword,
    String newPassword,
    BuildContext context,
  ) async {
    int temp = 0;
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser!.email);
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: currentPassword,
      );

      try {
        await FirebaseAuth.instance.currentUser!
            .reauthenticateWithCredential(credential);
        print('User reauthenticated successfully.');
        temp++;
      } on FirebaseException catch (e) {
        print(temp);
        Fluttertoast.showToast(
          msg: e.message.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        print(e.message);
      }
    } else {
      print('User is not signed in.');
    }
    if (temp > 0) {
      FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
      Fluttertoast.showToast(
        msg: 'Password Updated Successfuly',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      navigateToNextScreenAfterSignUp(context);
    }
    print(FirebaseAuth.instance.currentUser!.email);
  }

  void setCurrentUser(UserDetails user) {
    currentUser = user;
    notifyListeners();
  }
}

void navigateToNextScreenAfterLogin(BuildContext context, String profileImage) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => HomeScreen(
        profileImage: profileImage,
      ),
    ),
  );
}

void navigateToNextScreenAfterSignUp(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => UserLogin(),
    ),
  );
}
