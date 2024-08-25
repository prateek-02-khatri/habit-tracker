import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.controller, required this.hintText});

  final TextEditingController controller;
  final String hintText;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
          fontSize: 18
      ),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey
          ),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black
              )
          )
      ),
    );
  }
}
