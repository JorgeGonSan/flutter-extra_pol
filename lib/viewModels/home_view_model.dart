import 'package:flutter/cupertino.dart';

class HomeViewModel extends ChangeNotifier {
  TextEditingController patronP1Controller = TextEditingController();
  TextEditingController patronP2Controller = TextEditingController();
  TextEditingController patronP3Controller = TextEditingController();
  TextEditingController equipoP1Controller = TextEditingController();
  TextEditingController equipoP2Controller = TextEditingController();
  TextEditingController equipoP3Controller = TextEditingController();

  //Limpiar memoria
  @override
  void dispose() {
    patronP1Controller.dispose();
    patronP2Controller.dispose();
    patronP3Controller.dispose();
    equipoP1Controller.dispose();
    equipoP2Controller.dispose();
    equipoP3Controller.dispose();

    super.dispose();
  }
}
