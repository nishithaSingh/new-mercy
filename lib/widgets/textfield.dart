import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hint,
      required this.label,
      this.controller,
      this.isPassword = false});
  
  final String hint;
  final String label;
  final bool isPassword;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        label: Text(
          label,
          style: TextStyle(color: Colors.deepPurple),  // Label color change
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),  // Rounded corners
          borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2),
        ),
        fillColor: Colors.purple.shade50,  // Background color when text field is focused
        filled: true,
      ),
    );
  }
}
