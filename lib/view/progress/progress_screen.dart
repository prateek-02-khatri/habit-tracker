import 'package:flutter/material.dart';
import 'package:habit_tracker_app/components/custom_app_head.dart';
import 'package:habit_tracker_app/view_model/progress_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/calendar_card.dart';
import 'widgets/habit_list.dart';


class ProgressScreen extends StatefulWidget {

  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {

  late ProgressProvider provider;

  @override
  void initState() {
    provider = Provider.of(context, listen: false);
    provider.resetCalendar();
    provider.calculateStreaks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppHead(
              title: 'Hey User..!',
              subtitle: '${provider.streak} Streaks'
            ),

            const CalendarCard(),

            const SizedBox(height: 25),

            const HabitList(),

            const SizedBox(height: 10,)
          ],
        ),
      ),

    );
  }
}
