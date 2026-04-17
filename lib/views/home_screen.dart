import 'package:extra_pol/viewModels/home_view_model.dart';
import 'package:extra_pol/widgets/my_field_group.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<HomeScreen> {
  final HomeViewModel viewModel = HomeViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Extra Pol"),
        backgroundColor: Colors.grey[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            for (int i = 0; i < viewModel.puntos.length; i++)
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: MyFieldGroup(
                  c1: viewModel.puntos[i].patron,
                  c2: viewModel.puntos[i].equipo,
                  labelSuffix: " P${i + 1}",
                ),
              ),
          ],
        ),
      ),
    );
  }

  //Llama a Limpiar memoria
  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
}
