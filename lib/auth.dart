import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rive/rive.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> googleLogin() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null)
        return AlertDialog(
          title: Column(
            children: [
              Text("Error"),
              RiveAnimation.asset("assets/4954-10032-fire-skull.riv")
            ],
          ),
          content: Text("Something went wrong"),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text("OK"),
            ),
          ],
        );
      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(authCredential);
    } on FirebaseAuthException catch (e) {}
  }

  Future<void> logOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}

Future<void> googleLogin() async {
  try {
    final CollectionReference _usersCollection =
        FirebaseFirestore.instance.collection('users');
    final googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final DocumentReference userDocRef = _usersCollection.doc(googleUser.id);
    if (googleUser == null) {
      return AlertDialog(
          title: Column(
            children: [
              Text("Error"),
              RiveAnimation.asset("assets/4954-10032-fire-skull.riv")
            ],
          ),
          content: Text("Something went wrong"),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text("OK"),
            ),
          ],
        );
    } else {
      print(googleUser);
      final Map<String, dynamic> userData = {
        'name': googleUser.displayName,
        'email': googleUser.email,
        'photoUrl': googleUser.photoUrl,
        'address': null,
        'mobile': null,
        'password': null,
        
        // 'serverAuthCode': googleAuth.serverAuthCode,
        'documentId': googleUser.id,
      };
      await userDocRef.set(userData, SetOptions(merge: true));
    }

    // final googleAuth = await googleUser.authentication;
    final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    await FirebaseAuth.instance.signInWithCredential(authCredential);
  } on FirebaseAuthException catch (e) {
    print(e);
  }
}
