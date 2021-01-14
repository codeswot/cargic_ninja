import 'package:cargic_ninja/providers/app_data.dart';
import 'package:cargic_ninja/utils/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthHelper {
  //checks if a user is already logedin
  getCurrentUser(context) async {
    FirebaseAuth.instance.authStateChanges().listen((User user) async {
      if (user != null) {
        currentFirebaseUser = FirebaseAuth.instance.currentUser;
        String userID = currentFirebaseUser.uid;
        DatabaseReference databaseReference =
            FirebaseDatabase.instance.reference().child('users/$userID');
        await databaseReference.once().then((DataSnapshot snapshot) {
          if (snapshot.value != null) {
            // Provider.of<AppData>(context, listen: false).getUserInfo(
            //   iD: userID,
            //   name: snapshot.value['fullname'],
            //   email: snapshot.value['email'],
            //   phone: snapshot.value['phone'],
            // );
          }
        });
      } else {
        print('User is currently signed out!');
      }
    });
  }

  //register user
  Future regsterUser({
    String email,
    String password,
    String phone,
    String fullName,
    BuildContext context,
    // String lastName,
  }) async {
    String errorCode = '';

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential);
      if (userCredential != null) {
        DatabaseReference newUserRef = FirebaseDatabase.instance
            .reference()
            .child('users/${userCredential.user.uid}');
        //set data to be saved

        Map<String, dynamic> newUserMap = {
          "fullname": fullName,
          "email": email,
          "phone": phone,
        };
        //save data
        newUserRef.set(newUserMap);
        print('Saved user $newUserMap');
        currentFirebaseUser = FirebaseAuth.instance.currentUser;
        String userID = currentFirebaseUser.uid;
        DatabaseReference databaseReference =
            FirebaseDatabase.instance.reference().child('users/$userID');
        await databaseReference.once().then((DataSnapshot snapshot) {
          if (snapshot.value != null) {
            // Provider.of<AppData>(context, listen: false).getUserInfo(
            //   iD: userID,
            //   name: snapshot.value['fullname'],
            //   email: snapshot.value['email'],
            //   phone: snapshot.value['phone'],
            // );
          }
        });
      } else {
        print('user auth failed');
      }
    } on FirebaseAuthException catch (e) {
      errorCode = e.code;
    }
    return errorCode;
  }

  //login user
  Future loginUser(
      {String email, String password, BuildContext context}) async {
    // String error = '';
    String errorCode = '';
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      getCurrentUser(context);
      if (userCredential != null) {
        currentFirebaseUser = FirebaseAuth.instance.currentUser;
        String userID = currentFirebaseUser.uid;
        DatabaseReference databaseReference =
            FirebaseDatabase.instance.reference().child('users/$userID');
        await databaseReference.once().then((DataSnapshot snapshot) {
          if (snapshot.value != null) {
            // Provider.of<AppData>(context, listen: false).getUserInfo(
            //   iD: userID,
            //   name: snapshot.value["fullname"],
            //   email: snapshot.value["email"],
            //   phone: snapshot.value["phone"],
            // );
          }
        });

        print("works");
      }
    } on FirebaseAuthException catch (e) {
      errorCode = e.code;
    }
    return errorCode;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
