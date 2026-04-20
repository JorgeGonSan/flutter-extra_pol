import 'package:extra_pol/viewModels/home_view_model.dart';
import 'package:extra_pol/widgets/my_chart.dart';
import 'package:extra_pol/widgets/my_field_group.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, //degradado AppBar
      appBar: AppBar(
        title: const Text(
          "Extra Pol",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: viewModel.limpiarDatos,
            icon: const Icon(Icons.delete_sweep, color: Colors.redAccent),
            tooltip: "borrar campos",
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[200]!, Colors.white],
          ),
        ),
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, child) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 100.0,
                left: 16.0,
                right: 16.0,
                bottom: 16.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // TARJETA DE DATOS
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            for (int i = 0; i < viewModel.puntos.length; i++)
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: MyFieldGroup(
                                  c1: viewModel.puntos[i].patron,
                                  c2: viewModel.puntos[i].equipo,
                                  labelSuffix: " P${i + 1}",
                                  isManual: viewModel.puntos[i].esManual,
                                  isCalculado:
                                      viewModel.puntos[i].estaCalculado,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // TARJETA DE GRÁFICA + LEYENDA
                    if (viewModel.puntosGraficaEquipos.length >= 2)
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              MyChart(
                                spotsPatron: viewModel.puntosGraficaPatron,
                                spotsEquipo: viewModel.puntosGraficaEquipos,
                              ),
                              const SizedBox(height: 15),
                              // LEYENDA
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildLegendItem(
                                    Colors.blue.withOpacity(0.5),
                                    "Patrón",
                                  ),
                                  const SizedBox(width: 20),
                                  _buildLegendItem(Colors.red, "Equipo"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      const Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Text(
                          "Introduce datos en al menos 2 filas para comparar",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Widget para la leyenda
  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
}
