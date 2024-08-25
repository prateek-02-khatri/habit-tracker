import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:habit_tracker_app/models/habit_model.dart';
import 'package:table_calendar/table_calendar.dart';

import '../repository/habit_repository.dart';

class ProgressProvider with ChangeNotifier {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime get selectedDay => _selectedDay;
  DateTime get focusedDay => _focusedDay;
  CalendarFormat get calendarFormat => _calendarFormat;

  void setSelectedDay(DateTime day) {
    _selectedDay = day;
    notifyListeners();
  }

  void setFocusedDay(DateTime day) {
    _focusedDay = day;
    notifyListeners();
  }

  void setCalendarFormat(CalendarFormat format) {
    _calendarFormat = format;
    notifyListeners();
  }

  void resetCalendar() {
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
  }

  HabitRepository habitRepository = HabitRepository(
      email: FirebaseAuth.instance.currentUser!.email!,
      firestore: FirebaseFirestore.instance,
      realtimeDatabase: FirebaseDatabase.instance
  );

  Stream<List<HabitModel>> fetchAllHabits() {
    return habitRepository.fetchAllHabits();
  }

  int _streak = 0;
  int get streak => _streak;

  void calculateStreaks() {
    Stream<List<HabitModel>> habitStream = fetchAllHabits();

    habitStream.listen((List<HabitModel> habits) {
      Map<DateTime, List<HabitModel>> habitsByDate = {};
      for (HabitModel habit in habits) {
        DateTime habitDate = DateTime.fromMillisecondsSinceEpoch(habit.dateTime).toLocal();
        DateTime dateKey = DateTime(habitDate.year, habitDate.month, habitDate.day);

        if (!habitsByDate.containsKey(dateKey)) {
          habitsByDate[dateKey] = [];
        }

        habitsByDate[dateKey]!.add(habit);
      }

      int streakCount = 0;
      List<DateTime> sortedDates = habitsByDate.keys.toList()..sort();

      for (int i = 0; i < sortedDates.length; i++) {
        DateTime date = sortedDates[i];
        List<HabitModel> habitsForDay = habitsByDate[date]!;

        bool allCompleted = habitsForDay.every((habit) => habit.isCompleted);

        if (allCompleted) {
          streakCount++;
        } else {
          break;
        }
      }

      _streak = streakCount;
    });
  }

}