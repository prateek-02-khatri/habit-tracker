import 'package:flutter/material.dart';

import 'custom_text_field.dart';

habitCard({
  required BuildContext context,
  required String title,
  required VoidCallback onPressed,
  required TextEditingController habitNameController,
  required TextEditingController habitDescriptionController,
}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(
                fontSize: 24
            ),
          ),

          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(controller: habitNameController, hintText: 'Habit Name'),

                CustomTextField(controller: habitDescriptionController, hintText: 'Habit Description'),
              ],
            ),
          ),

          actions: [
            TextButton(
                onPressed: () {
                  habitNameController.clear();
                  habitDescriptionController.clear();
                  Navigator.pop(context);
                },
                child: const Text("Cancel")
            ),

            TextButton(
                onPressed: onPressed,
                child: const Text('Save')
            ),
          ],
        );
      }
  );
}