import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:habit_tracker_app/models/habit_model.dart';

class HabitRepository {
  final String email;
  final FirebaseFirestore firestore;
  final FirebaseDatabase realtimeDatabase;

  HabitRepository({
    required this.email,
    required this.firestore,
    required this.realtimeDatabase,
  });

  Future<void> addHabit({
    required HabitModel habit,
  }) async {
    await firestore
        .collection('users')
        .doc(email)
        .collection('habits')
        .doc(habit.dateTime.toString())
        .set(habit.toMap());
  }

  Future<void> editHabit({
    required HabitModel habit,
  }) async {
    await firestore
        .collection('users')
        .doc(email)
        .collection('habits')
        .doc(habit.dateTime.toString())
        .set(habit.toMap());
  }

  Future<void> removeHabit({
    required int id,
  }) async {
    await firestore
        .collection('users')
        .doc(email)
        .collection('habits')
        .doc(id.toString())
        .delete();
  }

  Stream<List<HabitModel>> fetchAllHabits() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .collection('habits')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return HabitModel.fromMap(doc.data());
      }).toList();
    });
  }
}