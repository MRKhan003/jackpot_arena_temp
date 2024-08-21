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
  Future<bool> isDisplayNameTaken(String? userName) async {
    final nameResult = await FirebaseFirestore.instance
        .collection('Users')
        .where('UserName', isEqualTo: userName)
        .get();
    print('User name check');
    return nameResult.docs.isNotEmpty;
  }

  Future<bool> signUp(String email, String pass, String userName, String name,
      BuildContext context) async {
    bool isTakenName;
    UserDetails userDetails = UserDetails();

    isTakenName = await isDisplayNameTaken(userName);
    if (isTakenName) {
      Fluttertoast.showToast(
        msg: 'User name already in use',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Color(0xffF8F8F8),
        textColor: Colors.red,
        fontSize: 16.0,
      );
      return false;
    } else {
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
            timeInSecForIosWeb: 3,
            backgroundColor: Color(0xffF8F8F8),
            textColor: Colors.green,
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
              timeInSecForIosWeb: 3,
              backgroundColor: Color(0xffF8F8F8),
              textColor: Colors.red,
              fontSize: 16.0);
          return false;
        } else if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(
              msg: 'Email already in use',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Color(0xffF8F8F8),
              textColor: Colors.red,
              fontSize: 16.0);
          return false;
        } else if (e.code == 'network-request-failed') {
          Fluttertoast.showToast(
              msg: 'Internet Connection Failed',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Color(0xffF8F8F8),
              textColor: Colors.red,
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
            backgroundColor: Color(0xffF8F8F8),
            textColor: Colors.red,
            fontSize: 16.0);
        return false;
      }
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
            backgroundColor: Color(0xffF8F8F8),
            textColor: Colors.green,
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
            backgroundColor: Color(0xffF8F8F8),
            textColor: Colors.red,
            fontSize: 16.0);
        print(e.code);
        return false;
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: e.code,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Color(0xffF8F8F8),
            textColor: Colors.red,
            fontSize: 16.0);
        print('$e');
        return false;
      } else if (e.code == 'invalid-email') {
        Fluttertoast.showToast(
            msg: 'The email address is badly formatted',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Color(0xffF8F8F8),
            textColor: Colors.red,
            fontSize: 16.0);
        print('$e');
        return false;
      } else if (e.code == 'network-request-failed') {
        Fluttertoast.showToast(
            msg: 'Internet Connection Failed',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Color(0xffF8F8F8),
            textColor: Colors.red,
            fontSize: 16.0);
        print('$e');
        return false;
      } else {
        Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Color(0xffF8F8F8),
            textColor: Colors.red,
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
          backgroundColor: Color(0xffF8F8F8),
          textColor: Colors.red,
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
      await FirebaseFirestore.instance
          .collection(
            'Users',
          )
          .doc(
            FirebaseAuth.instance.currentUser!.email,
          )
          .delete();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(
            'Notifications',
          )
          .where(
            'UserID',
            isEqualTo: FirebaseAuth.instance.currentUser!.email,
          )
          .get();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      await FirebaseAuth.instance.currentUser!.delete();
      print(
        "User notifications deleted successfully.",
      );
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
          backgroundColor: Color(0xffF8F8F8),
          textColor: Colors.red,
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
        backgroundColor: Color(0xffF8F8F8),
        textColor: Colors.green,
        fontSize: 16.0,
      );
      navigateToNextScreenAfterSettings(context);
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

void navigateToNextScreenAfterSettings(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => UserLogin(),
    ),
  );
}
