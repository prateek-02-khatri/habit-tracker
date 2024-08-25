import 'package:flutter/material.dart';
import 'package:habit_tracker_app/view_model/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  bool isNewUser = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late AuthenticationProvider provider;

  @override
  void initState() {
    provider = Provider.of<AuthenticationProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height * 0.1;

    return Scaffold(

      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          'Habit Tracker',
          style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0, 0),
            end: const Alignment(1, 1),
            colors: [
              Colors.deepPurpleAccent.withOpacity(0.65),
              Colors.deepPurpleAccent.shade100.withOpacity(0.65),
            ]
          )
        ),
        child: Center(
          child: Stack(
            children: [

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  customTextField(
                    controller: emailController,
                    hintText: 'Email',
                    prefixIcon: Icons.email_outlined,
                    obscureText: false,
                  ),

                  const SizedBox(height: 35,),

                  Consumer<AuthenticationProvider>(
                    builder: (BuildContext context, AuthenticationProvider value, Widget? child) {
                      return customTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        prefixIcon: Icons.lock_outline,
                        obscureText: value.isPasswordVisible ? false : true,
                        suffixIcon: value.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        onPressed: () {
                          bool val = !value.isPasswordVisible;
                          value.setPasswordVisibility(val);
                        }
                      );
                    }
                  ),

                  const SizedBox(height: 20,),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isNewUser ? 'Already have an account?' : 'New User..!!',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            FocusScope.of(context).unfocus();
                            isNewUser = !isNewUser;
                            emailController.clear();
                            passwordController.clear();
                          });
                        },
                        child: Text(
                          isNewUser ? 'Login' : 'Sign up',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurpleAccent.shade200
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: height),
                  child: ElevatedButton(
                      onPressed: isNewUser ? signup : login,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.deepPurpleAccent,
                          minimumSize: const Size(125, 50)
                      ),
                      child: Text(
                        isNewUser ? 'Sign Up' : 'Login',
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  login() {

    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Utils.showAlertBox(context: context, title: 'Please fill required fields..!!');
    } else if (password.length < 6) {
      Utils.showAlertBox(context: context, title: 'Password length must be greater than 6..!!');
    } else {
      provider.login(context: context, email: email, password: password);
    }
  }

  signup() {

    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Utils.showAlertBox(context: context, title: 'Please fill required fields..!!');
    } else if (password.length < 6) {
      Utils.showAlertBox(context: context, title: 'Password length must be greater than 6..!!');
    } else {
      provider.createAccount(context: context, email: email, password: password);
    }
  }

  customTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData? prefixIcon,
    required bool obscureText,
    IconData? suffixIcon,
    VoidCallback? onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,

        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.white
          ),

          counterText: "",

          prefixIcon: Icon(
            prefixIcon,
            color: Colors.white
          ),

          suffixIcon: suffixIcon != null ? IconButton(
            onPressed: onPressed,
            icon: Icon(suffixIcon),
            color: Colors.white,
          ) : null,

          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
              width: 3
            ),
            borderRadius: BorderRadius.circular(25)
          ),

          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade100,
                width: 1.25
              ),
              borderRadius: BorderRadius.circular(25)
          ),
        ),
      ),
    );
  }
}
