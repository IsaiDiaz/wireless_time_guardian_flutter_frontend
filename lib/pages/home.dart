import 'package:flutter/material.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/page_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/components/menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/components/page_title.dart';
import 'package:wireless_time_guardian_flutter_frontend/pages/default.dart';
import 'package:wireless_time_guardian_flutter_frontend/pages/empleados.dart';
import 'package:wireless_time_guardian_flutter_frontend/pages/inicio.dart';
import 'package:wireless_time_guardian_flutter_frontend/pages/proyectos.dart';
import 'package:wireless_time_guardian_flutter_frontend/pages/rfid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green, Colors.blue])),
      alignment: Alignment.center,
      child: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Menu(),
            const SizedBox(
              width: 20,
            ),
            BlocBuilder<PageBloc, PageState>(
              builder: (context, state) {
                return Expanded(
                    child: Column(
                  children: [
                    PageTitle(title: _pagetitle(state.actualPage)),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: _buildPage(context, state.actualPage)),
                    ),
                  ],
                ));
              },
            ),
          ],
        ),
      ),
    ));
  }
}

String _pagetitle(int actualPage) {
  switch (actualPage) {
    case 0:
      return "Inicio";
    case 1:
      return "Proyectos";
    case 2:
      return "Empleados";
    case 3:
      return "RFID";
    default:
      return "Default";
  }
}

Widget _buildPage(BuildContext context, int actualPage) {
  switch (actualPage) {
    case 0:
      return const Inicio();
    case 1:
      return const Proyectos();
    case 2:
      return const Empleados();
    case 3:
      return const RFID();
    default:
      return const Default();
  }
}
