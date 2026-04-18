import 'package:extra_pol/models/fila_patron_equipo.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isupdating = false;

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
  //gestiona los cambios en las filas de puntos
  void _onChanged() {
    //Si esta calculando no hago nada mas
    if (_isupdating) {
      return;
    }
    //Creamos un bool por fila para compraobar si esta la pareja vacia o no con el fin de bloquear o no.
    bool f1 =
        puntos[0].patron.text.isNotEmpty && puntos[0].equipo.text.isNotEmpty;
    bool f2 =
        puntos[1].patron.text.isNotEmpty && puntos[1].equipo.text.isNotEmpty;
    bool f3 =
        puntos[2].patron.text.isNotEmpty && puntos[2].equipo.text.isNotEmpty;

    //Recorremos filas y si se cumple la condicion la marcamos como manual
    for (var punto in puntos) {
      if ((punto.patron.text.isNotEmpty || punto.equipo.text.isNotEmpty) &&
          !punto.estaCalculado) {
        punto.esManual = true;
      }
    }

    //creamos variables nulables y la intentamos pasar a dobles(tryParse)

    double? p1 = double.tryParse(puntos[0].patron.text);
    double? e1 = double.tryParse(puntos[0].equipo.text);
    double? p2 = double.tryParse(puntos[1].patron.text);
    double? e2 = double.tryParse(puntos[1].equipo.text);
    double? p3 = double.tryParse(puntos[2].patron.text);
    double? e3 = double.tryParse(puntos[2].equipo.text);
    //caso 1 (fila 1 y fila 2)
    if (f1 && f2 && !puntos[2].esManual) {
      _isupdating = true;
      double diffP = p2! - p1!;
      double diffE = e2! - e1!;
      double p3Res = p2! + diffP;
      double e3Res = e2! + diffE;
      puntos[2].patron.text = p3Res.toStringAsFixed(2);
      puntos[2].equipo.text = e3Res.toStringAsFixed(2);
      puntos[2].estaCalculado = true;
      _isupdating = false;
      //Caso 2 (fila 2 y fila 3)
    } else if (f2 && f3 && !puntos[0].esManual) {
      _isupdating = true;
      double diffP = p3! - p2!;
      double diffE = e3! - e2!;
      double p1Res = p2! - diffP;
      double e1Res = e2! - diffE;
      puntos[0].patron.text = p1Res.toStringAsFixed(2);
      puntos[0].equipo.text = e1Res.toStringAsFixed(2);
      puntos[0].estaCalculado = true;
      _isupdating = false;
      //Caso (fila 1 y fila 3)
    } else if (f1 && f3 && !puntos[1].esManual) {
      _isupdating = true;

      double p2Res = (p1! + p3!) / 2;
      double e2Res = (e1! + e3!) / 2;
      puntos[1].patron.text = p2Res.toStringAsFixed(2);
      puntos[1].equipo.text = e2Res.toStringAsFixed(2);
      puntos[1].estaCalculado = true;
      _isupdating = false;
    }
    notifyListeners();
  }

  //Reinicio de campos
  void limpiarDatos() {
    for (var punto in puntos) {
      punto.patron.clear();
      punto.equipo.clear();
      punto.esManual = false;
      punto.estaCalculado = false;
    }
    notifyListeners();
  }

  //Limpieza de los controller
  @override
  void dispose() {
    for (var punto in puntos) {
      punto.patron.dispose();
      punto.equipo.dispose();
    }
    super.dispose();
  }

  // obtiene una lista con los puntos (x,y) ordenados para el patron
  List<FlSpot> get puntosGraficaPatron {
    List<FlSpot> spots = [];

    for (var punto in puntos) {
      //Intentamos de pasar a double el texto del campo
      double? x = double.tryParse(punto.patron.text);

      //Si el punto es valido lo asignamos a la lista
      if (x != null) {
        spots.add(FlSpot(x, x));
      }
    }
    // ordena la lista de menor a mayor
    spots.sort((a, b) => a.x.compareTo(b.x));
    return spots;
  }

  // obtiene una lista con los puntos (x,y) ordenados para el equipo
  List<FlSpot> get puntosGraficaEquipos {
    List<FlSpot> spots = [];

    for (var punto in puntos) {
      //Intentamos de pasar a double el texto del campo
      double? x = double.tryParse(punto.patron.text);
      double? y = double.tryParse(punto.equipo.text);

      //Si el punto es valido lo asignamos a la lista
      if (x != null && y != null) {
        spots.add(FlSpot(x, y));
      }
    }
    // ordena la lista de menor a mayor
    spots.sort((a, b) => a.x.compareTo(b.x));
    return spots;
  }
}
