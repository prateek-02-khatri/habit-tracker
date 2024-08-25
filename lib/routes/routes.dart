import 'package:flutter/material.dart';
import 'package:habit_tracker_app/view/auth/auth_screen.dart';
import 'package:habit_tracker_app/view/navigation_screen.dart';

class Routes {
  static const String waiting = 'waiting';
  static const String auth = 'auth';
  static const String navigationMenu = 'navigationMenu';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {

      case auth:
        return MaterialPageRoute(builder: (context) => const AuthScreen());

      case navigationMenu:
        return MaterialPageRoute(builder: (context) => const NavigationScreen());

      case waiting:
        return MaterialPageRoute(builder: (context) => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ));

      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
                child: Text(
                  'No Route Defined..!!'
                )
            ),
          );
        });
    }
  }
}