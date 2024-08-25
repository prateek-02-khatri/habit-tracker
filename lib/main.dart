import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_app/routes/routes.dart';
import 'package:habit_tracker_app/view/auth/auth_screen.dart';
import 'package:habit_tracker_app/view/navigation_screen.dart';
import 'package:habit_tracker_app/view_model/auth_provider.dart';
import 'package:habit_tracker_app/view_model/habit_provider.dart';
import 'package:habit_tracker_app/view_model/progress_provider.dart';
import 'package:habit_tracker_app/view_model/stats_provider.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const HabitTrackerApp());
}

class HabitTrackerApp extends StatelessWidget {
  const HabitTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {

    Widget? nextPage;
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      nextPage = const AuthScreen();
    } else {
      nextPage = const NavigationScreen();
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => HabitProvider()),
        ChangeNotifierProvider(create: (_) => ProgressProvider()),
        ChangeNotifierProvider(create: (_) => StatsProvider()),
      ],
      child: MaterialApp(
        title: 'Habit Tracker App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          scaffoldBackgroundColor: Colors.white
        ),
        home: nextPage,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
