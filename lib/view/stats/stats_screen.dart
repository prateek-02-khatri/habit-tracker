import 'package:flutter/material.dart';
import 'package:habit_tracker_app/components/custom_app_head.dart';
import 'package:habit_tracker_app/view/stats/widgets/habit_vs_days_chart.dart';
import 'package:habit_tracker_app/view/stats/widgets/stat_card.dart';
import 'package:habit_tracker_app/view_model/stats_provider.dart';
import 'package:provider/provider.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {

  late StatsProvider provider;
  late List<List<dynamic>> data;

  @override
  void initState() {
    provider = Provider.of<StatsProvider>(context, listen: false);
    provider.fetchHabits(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppHead(
              title: 'Hey User..!',
              subtitle: ''
            ),
        
            const SizedBox(height: 30,),

            Consumer<StatsProvider>(
              builder: (BuildContext context, StatsProvider value, Widget? child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StatCard(color: Colors.orangeAccent, title: 'Total Habits', value: value.total),
                    StatCard(color: Colors.green, title: 'Completed', value: value.completed),
                    StatCard(color: Colors.redAccent, title: 'Missed', value: value.missed),
                  ],
                );
              },
            ),
        
            const SizedBox(height: 30),

            const Text(
              'Habit Completion Trend',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            Consumer<StatsProvider>(
              builder: (BuildContext context,StatsProvider value, Widget? child) {
                return
                  value.isLoading ?
                  const AspectRatio(
                    aspectRatio: 1.75,
                    child: Center(child: CircularProgressIndicator(color: Colors.deepPurpleAccent,)),
                  ) :
                  HabitVsDaysChart(
                    provider: provider,
                  );
              },
            ),

          ],
        ),
      ),
    );
  }
}
