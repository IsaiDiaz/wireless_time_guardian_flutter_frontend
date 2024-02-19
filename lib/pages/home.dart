import 'package:flutter/material.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/general_application_cubit.dart';
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
    final TextEditingController ipController = TextEditingController();
    final ApplicationCubit applicationCubit =
        BlocProvider.of<ApplicationCubit>(context);
    ipController.text = applicationCubit.state.serverIp;
    ipController.addListener(() {
      applicationCubit.changeServerIp(ipController.text);
    });

    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.2, 0.9],
              colors: [Colors.green, Color.fromARGB(255, 186, 189, 181)])),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PageTitle(title: _pagetitle(state.actualPage)),
                        SizedBox(
                          width: 210,
                          child: TextField(
                            controller: ipController,
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      style: BorderStyle.solid)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      style: BorderStyle.solid)),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide:
                                      BorderSide(style: BorderStyle.solid)),
                              labelText: 'Direccion ip del servidor',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
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
