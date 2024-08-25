import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/habit_model.dart';
import 'package:habit_tracker_app/view_model/progress_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HabitList extends StatelessWidget {
  const HabitList({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<ProgressProvider>(

      builder: (BuildContext context, ProgressProvider value, Widget? child) {

        return StreamBuilder(
            stream: value.fetchAllHabits(),
            builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade100,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(

                            trailing: Container(
                              width: 50,
                              height: 50,
                              color: Colors.white,
                            ),

                            title: Container(
                              width: 85,
                              height: 10,
                              color: Colors.white,
                            ),

                            subtitle: Container(
                              width: 85,
                              height: 10,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }
                  ),
                );
              }

              List<HabitModel> habitList = [];
              int day = value.selectedDay.day;
              int month = value.selectedDay.month;

              int completed = 0;
              double progress = 0;

              for (HabitModel habit in snapshot.data!) {
                DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(habit.dateTime);
                if (dateTime.day == day && dateTime.month == month) {
                  habitList.add(habit);
                  if (habit.isCompleted) {
                    completed++;
                  }
                }
              }

              if (habitList.isEmpty) {
                return const Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      'No Habit on this day!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                );
              }

              progress = completed/habitList.length;

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Habits for ${DateFormat('d MMM').format(value.selectedDay)}",
                              style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                            Text(
                                "${(progress * 100).round()}%",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                )
                            )
                          ],
                        ),

                        const SizedBox(height: 6),

                        LinearProgressIndicator(
                          minHeight: 12,
                          color: Colors.deepPurpleAccent,
                          backgroundColor: Colors.deepPurpleAccent.shade100,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          value: progress,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: habitList.length,
                        itemBuilder: (context, index) {
                          HabitModel habit = habitList[index];
                          return ListTile(
                              trailing: habit.isCompleted ?
                              Icon(
                                Icons.check,
                                size: 24,
                                color: Colors.green.shade600,
                              ) :
                              const Icon(
                                Icons.close,
                                size: 24,
                                color: Colors.red,
                              ),

                              title: Text(
                                habit.habitName,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                              subtitle: Text(
                                habit.habitDescription,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            );
                        }
                    ),
                  ),
                ],
              );
            }
        );
      },
    );
  }
}
