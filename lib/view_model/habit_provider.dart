import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/habit_model.dart';
import 'package:habit_tracker_app/repository/habit_repository.dart';


class HabitProvider with ChangeNotifier {

  HabitRepository habitRepository = HabitRepository(
    email: FirebaseAuth.instance.currentUser!.email!,
    firestore: FirebaseFirestore.instance,
    realtimeDatabase: FirebaseDatabase.instance
  );

  void addHabit(HabitModel habit) {
    habitRepository.addHabit(habit: habit);
  }

  void removeHabit(int id, bool value) {
    habitRepository.removeHabit(id: id);
  }

  void editHabit(HabitModel habit) async {
    await habitRepository.editHabit(habit: habit);
  }

  Stream<List<HabitModel>> fetchAllHabits() {
    Stream<List<HabitModel>> habits = habitRepository.fetchAllHabits();
    return habits;
  }
}