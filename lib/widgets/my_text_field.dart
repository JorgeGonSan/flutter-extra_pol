import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String myLabelText;
  final TextEditingController myController;
  final TextInputType myKeyboard;
  final Color? myBackgroundColor;

  const MyTextField({
    super.key,
    required this.myLabelText,
    required this.myController,
    this.myKeyboard = const TextInputType.numberWithOptions(
      signed: true,
      decimal: true,
    ),
    this.myBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: myController,
      keyboardType: myKeyboard,
      decoration: InputDecoration(
        filled: true,
        fillColor: myBackgroundColor,
        labelText: myLabelText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
