import 'package:extra_pol/models/fila_patron_equipo.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final List<FilaPatronEquipo> puntos = [
    FilaPatronEquipo(
      patron: TextEditingController(),
      equipo: TextEditingController(),
    ),
    FilaPatronEquipo(
      patron: TextEditingController(),
      equipo: TextEditingController(),
    ),
  ];

  @override
  void dispose() {
    for (var punto in puntos) {
      punto.patron.dispose();
      punto.equipo.dispose();
    }
    super.dispose();
  }
}
