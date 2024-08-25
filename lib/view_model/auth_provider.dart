import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:habit_tracker_app/repository/auth_repository.dart';

class AuthenticationProvider with ChangeNotifier {
  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;
  void setPasswordVisibility(bool value) {
    _isPasswordVisible = value;
    notifyListeners();
  }

  AuthRepository authRepository = AuthRepository(
    firebaseAuth: FirebaseAuth.instance,
    firebaseFirestore: FirebaseFirestore.instance
  );

  login({
    required BuildContext context,
    required String email,
    required String password,
  }) {
    authRepository.login(
      context: context,
      email: email,
      password: password
    );
  }

  createAccount({
    required BuildContext context,
    required String email,
    required String password,
  }) {
    authRepository.createAccount(
        context: context,
        email: email,
        password: password
    );
  }

  logout(context) {
    authRepository.logout(context);
  }
}