import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: ListTile(
        leading: Icon(
          icon,
          size: 26,
          color: Colors.black,
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios_sharp,
          color: Colors.black,
        ),
      ),
    );
  }
}
