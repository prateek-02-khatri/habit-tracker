import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/habit_model.dart';
import '../utils/utils.dart';

class StatsRepository {
  Future<List<HabitModel>> getAllHabits(context) async {
    List<HabitModel> habitsList = [];
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('habits')
          .get();

      for (var doc in snapshot.docs) {
        HabitModel habit = HabitModel.fromMap(doc.data() as Map<String, dynamic>);
        habitsList.add(habit);
      }
    } catch (e) {
      Utils.showAlertBox(context: context, title: e.toString());
    }

    return habitsList;
  }
}