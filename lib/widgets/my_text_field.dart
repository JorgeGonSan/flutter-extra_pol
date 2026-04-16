import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String myLabelText;
  final TextEditingController myController;
  final TextInputType myKeyboard;

  const MyTextField({
    super.key,
    required this.myLabelText,
    required this.myController,
    this.myKeyboard = TextInputType.number,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: myController,
      keyboardType: myKeyboard,
      decoration: InputDecoration(
        labelText: myLabelText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
