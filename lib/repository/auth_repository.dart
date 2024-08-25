import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../routes/routes.dart';
import '../utils/utils.dart';

class AuthRepository {

  final FirebaseAuth firebaseAuth;

  final FirebaseFirestore firebaseFirestore;

  AuthRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try{
      Utils.showLoadingDialog(context: context, message: 'Please Wait...');

      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        Navigator.pushNamedAndRemoveUntil(context, Routes.navigationMenu, (route) => false);
      } else {
        Utils.showAlertBox(context: context, title: 'Unable to create account..!!');
      }

    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      Utils.showAlertBox(context: context, title: e.code.toString());
    }
  }

  createAccount({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try{
      Utils.showLoadingDialog(context: context, message: 'Please Wait...');

      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        Map<String, String> userData = {
          'email': email,
          'password': password,
        };
        await firebaseFirestore.collection('users').doc(email).set(userData);
        Navigator.pushNamedAndRemoveUntil(context, Routes.navigationMenu, (route) => false);
      } else {
        Utils.showAlertBox(context: context, title: 'Unable to create account..!!');
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      Utils.showAlertBox(context: context, title: e.code.toString());
    }
  }

  logout(context) async{
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacementNamed(context, Routes.auth);
  }
}
