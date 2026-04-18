import 'package:extra_pol/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

class MyFieldGroup extends StatelessWidget {
  final String patron;
  final String equipo;
  final String labelSuffix;
  final TextEditingController c1, c2;
  final bool isManual;
  final bool isCalculado;
  const MyFieldGroup({
    super.key,
    this.equipo = "Equipo",
    this.patron = "Patron",
    required this.c1,
    required this.c2,
    required this.labelSuffix,
    required this.isManual,
    required this.isCalculado,
  });

  @override
  Widget build(BuildContext context) {
    Color? color;
    if (isManual) {
      color = Colors.amber[100];
    } else if (isCalculado) {
      color = Colors.green[100];
    } else {
      color = Colors.transparent;
    }
    return Row(
      children: [
        Expanded(
          child: MyTextField(
            myLabelText: "$patron$labelSuffix",
            myController: c1,
            myBackgroundColor: color,
          ),
        ),
        SizedBox(width: 30),
        Expanded(
          child: MyTextField(
            myLabelText: "$equipo$labelSuffix",
            myController: c2,
            myBackgroundColor: color,
          ),
        ),
      ],
    );
  }
}
