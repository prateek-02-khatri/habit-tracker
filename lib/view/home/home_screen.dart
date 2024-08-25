import 'package:flutter/material.dart';
import 'package:habit_tracker_app/components/custom_app_head.dart';
import 'package:habit_tracker_app/models/habit_model.dart';
import 'package:habit_tracker_app/utils/utils.dart';
import 'package:habit_tracker_app/view/home/widgets/home_progress_bar.dart';
import 'package:habit_tracker_app/view_model/habit_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../components/habit_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HabitProvider provider;
  TextEditingController habitNameController = TextEditingController();
  TextEditingController habitDescriptionController = TextEditingController();

  @override
  void initState() {
    provider = Provider.of<HabitProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    habitNameController.dispose();
    habitDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<HabitProvider>(
              builder: (BuildContext context, HabitProvider value, Widget? child) {

                return StreamBuilder(
                    stream: value.fetchAllHabits(),
                    builder: (context, snapshot) {

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          children: [

                            const CustomAppHead(
                                title: 'Hey User..!',
                                subtitle: 'You have - habits left for today'
                            ),

                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade200,
                              highlightColor: Colors.grey.shade100,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 10,
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
                            ),
                          ],
                        );
                      }

                      List<HabitModel> habitList = [];

                      int day = today.day;
                      int month = today.month;

                      int completed = 0;
                      double progress = 0;

                      for (HabitModel habit in snapshot.data!) {
                        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(habit.dateTime);
                        if (dateTime.day == day && dateTime.month == month) {
                          habitList.add(habit);
                          if (habit.isCompleted) {
                            completed++;
                          }
                          progress = completed/habitList.length;
                        }
                      }

                      return Column(
                        children: [
                          CustomAppHead(
                              title: 'Hey User..!',
                              subtitle: 'You have ${habitList.length-completed} habits left for today'
                          ),

                          HomeProgressBar(
                            value: progress,
                          ),

                          const SizedBox(height: 10,),

                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                            child: Divider(),
                          ),

                          const SizedBox(height: 10,),

                          (habitList.isEmpty) ? const Center(
                              child: Text(
                                'Tap + to add Habit',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400
                                ),
                              )
                          ) :
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: habitList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, int index) {
                              HabitModel habit = habitList[index];
                              return ListTile(

                                onTap: () {

                                  TextEditingController habitNameController = TextEditingController(text: habit.habitName);
                                  TextEditingController habitDescriptionController = TextEditingController(text: habit.habitDescription);

                                  habitCard(
                                      context: context,
                                      title: 'Edit Habit',
                                      habitNameController: habitNameController,
                                      habitDescriptionController: habitDescriptionController,
                                      onPressed: () {

                                        String habitName = habitNameController.text.trim();
                                        String habitDescription = habitDescriptionController.text.trim();

                                        if (habitName.isNotEmpty && habitDescription.isNotEmpty) {
                                          HabitModel editedHabit = HabitModel(
                                              habitName: habitName,
                                              habitDescription: habitDescription,
                                              isCompleted: habit.isCompleted,
                                              dateTime: habit.dateTime
                                          );

                                          value.editHabit(editedHabit);

                                          Navigator.pop(context);
                                          habitNameController.clear();
                                          habitDescriptionController.clear();
                                        } else {
                                          Navigator.pop(context);
                                          Utils.showAlertBox(context: context, title: 'Please fill required fields..!!');
                                        }
                                      }
                                  );
                                },

                                leading: Checkbox(
                                  value: habit.isCompleted,
                                  checkColor: Colors.white,
                                  activeColor: Colors.deepPurpleAccent,
                                  onChanged: ((val) {
                                    HabitModel temp = HabitModel(
                                        habitName: habit.habitName,
                                        habitDescription: habit.habitDescription,
                                        isCompleted: val!,
                                        dateTime: habit.dateTime
                                    );
                                    value.editHabit(temp);
                                  }),
                                ),

                                title: Text(
                                  habit.habitName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),

                                subtitle: Text(
                                  habit.habitDescription,
                                  style: const TextStyle(
                                    fontSize: 17,
                                  ),
                                ),

                                trailing: IconButton(
                                    onPressed: () {
                                      value.removeHabit(habit.dateTime, habit.isCompleted);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 10,)
                        ],
                      );
                    }
                );
              },
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          habitCard(
            context: context,
            title: 'Add Habit',
            habitNameController: habitNameController,
            habitDescriptionController: habitDescriptionController,
            onPressed: () {
              String habitName = habitNameController.text.trim();
              String habitDescription = habitDescriptionController.text.trim();
              if (habitName.isNotEmpty && habitDescription.isNotEmpty) {
                HabitModel habit = HabitModel(
                  habitName: habitName,
                  habitDescription: habitDescription,
                  isCompleted: false,
                  dateTime: DateTime.now().millisecondsSinceEpoch
                );

                provider.addHabit(habit);

                Navigator.pop(context);
                habitNameController.clear();
                habitDescriptionController.clear();
              } else {
                Utils.showAlertBox(context: context, title: 'Please fill required fields..!!');
              }
            }
          );
        },
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.transparent,
            width: 0,
          )
        ),
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(
          Icons.add,
          size: 32,
          color: Colors.white,
        ),
      ),
    );
  }
}


