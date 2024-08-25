import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/habit_model.dart';
import 'package:habit_tracker_app/repository/stats_repository.dart';

class StatsProvider extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  StatsRepository statsRepository = StatsRepository();

  List<HabitModel> _habitList = [];

  fetchHabits(context) async {
    _habitList = await statsRepository.getAllHabits(context);
    getStats();
    getLineChartData();
    setLoading(false);
  }

  List<FlSpot> _chartData = [];
  List<FlSpot> get chartData => _chartData;

  List<int> _order = [];
  List<int> get order => _order;

  void getLineChartData() {
    List<FlSpot> chartData = [];
    List<int> order = [];
    int count = 7;

    DateTime today = DateTime.now();
    for (int i=0; i<7; i++) {
      DateTime day = today.subtract(Duration(days: i));
      int completedHabits = 0;
      for (HabitModel habit in _habitList) {
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(habit.dateTime);
        if (habit.isCompleted && dateTime.day == day.day && dateTime.month == dateTime.month) {
          completedHabits++;
        }
      }
      order.add(day.weekday);
      chartData.add(FlSpot(count.toDouble(), completedHabits.toDouble()));
      count--;
    }

    _chartData = chartData.reversed.toList();
    _order = order.reversed.toList();
  }

  int _total = 0;
  int get total => _total;

  int _completed = 0;
  int get completed => _completed;

  int _missed = 0;
  int get missed => _missed;

  void getStats() {
    _completed = 0;
    _missed = 0;

    for (var habit in _habitList) {
      habit.isCompleted ? _completed++ : _missed++;
    }
    _total = _habitList.length;
  }
}
