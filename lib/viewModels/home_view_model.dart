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
    FilaPatronEquipo(
      patron: TextEditingController(),
      equipo: TextEditingController(),
    ),
  ];
  //Contructor que crea un "Listener" para cada TexEditingController
  HomeViewModel() {
    for (var punto in puntos) {
      punto.patron.addListener(_onChanged);
      punto.equipo.addListener(_onChanged);
    }
  }

  void _onChanged() {
    //creamos variables nulables y la intentamos pasar a dobles(tryParse)
    double? p1 = double.tryParse(puntos[0].patron.text);
    double? e1 = double.tryParse(puntos[0].equipo.text);
    //Si no son nulas creamos igual den el punto 2
    if (p1 != null && e1 != null) {
      double? p2 = double.tryParse(puntos[1].patron.text);
      double? e2 = double.tryParse(puntos[1].equipo.text);

      //comprobamos si tenemos ya dos filas completas
      if (p2 != null && e2 != null) {
        double diffP = p2 - p1;
        double diffE = e2 - e1;
        double p3Calculado = p2 + diffP;
        double e3Calculado = e2 + diffE;

        if (puntos[2].patron.text != p3Calculado.toStringAsFixed(2)) {
          puntos[2].patron.text = p3Calculado.toStringAsFixed(2);
        }

        if (puntos[2].equipo.text != e3Calculado.toStringAsFixed(2)) {
          puntos[2].equipo.text = e3Calculado.toStringAsFixed(2);
        }
      }
    }
  }

  @override
  void dispose() {
    for (var punto in puntos) {
      punto.patron.dispose();
      punto.equipo.dispose();
    }
    super.dispose();
  }
}
