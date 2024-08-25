import 'package:flutter/material.dart';
import 'package:habit_tracker_app/view_model/progress_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarCard extends StatelessWidget {
  const CalendarCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Consumer<ProgressProvider>(
        builder: (BuildContext context, ProgressProvider value, Widget? child) {

          return TableCalendar(

            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),

            calendarFormat: value.calendarFormat,
            focusedDay: value.focusedDay,

            availableGestures: AvailableGestures.none,

            selectedDayPredicate: (day) {
              return isSameDay(value.selectedDay, day);
            },

            onDaySelected: (selectedDay, focusedDay) {
              value.setSelectedDay(selectedDay);
              value.setFocusedDay(focusedDay);
            },

            onFormatChanged: (format) {
              value.setCalendarFormat(format);
            },

            onPageChanged: (focusedDay) {
              value.setFocusedDay(focusedDay);
            },

            calendarStyle: const CalendarStyle(

              todayDecoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.orangeAccent,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          );
        },
      ),
    );
  }
}
