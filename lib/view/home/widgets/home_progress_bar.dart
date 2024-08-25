import 'package:flutter/material.dart';

class HomeProgressBar extends StatelessWidget {
  const HomeProgressBar({super.key, required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Keep Going!",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),

              Text(
                "${(value * 100).round()}%",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                )
              )
            ],
          ),

          const SizedBox(height: 10),

          LinearProgressIndicator(
            minHeight: 12,
            color: Colors.deepPurpleAccent,
            backgroundColor: Colors.deepPurpleAccent.shade100,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            value: value,
          ),
        ],
      ),
    );
  }
}
