import 'package:flutter/material.dart';

class Utils {
  static showAlertBox({required BuildContext context, required String title}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Ok",
                )
            )
          ],
        );
      },
    );
  }

  static showLoadingDialog({
    required BuildContext context,
    required String message,
  }) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const CircularProgressIndicator(
                        color: Colors.deepPurpleAccent,
                      ),

                      const SizedBox(width: 25,),

                      Expanded(
                          child: Text(
                            message,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              height: 1.5
                            ),
                          )
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}