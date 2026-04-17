import 'package:flutter/material.dart';

class FilaPatronEquipo {
  final TextEditingController patron;
  final TextEditingController equipo;
  bool esManual = false;
  bool estaCalculado = false;

  FilaPatronEquipo({required this.patron, required this.equipo});
}
