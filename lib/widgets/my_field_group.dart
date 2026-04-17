import 'package:extra_pol/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

class MyFieldGroup extends StatelessWidget {
  final String patron;
  final String equipo;
  final TextEditingController c1, c2;
  const MyFieldGroup({
    super.key,
    this.equipo = "Equipo",
    this.patron = "Patron",
    required this.c1,
    required this.c2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MyTextField(myLabelText: patron, myController: c1),
        ),
        SizedBox(width: 30),
        Expanded(
          child: MyTextField(myLabelText: equipo, myController: c2),
        ),
      ],
    );
  }
}
