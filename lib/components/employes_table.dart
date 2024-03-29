import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/employe_init_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/general_application_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/employee_dto.dart';
import 'dart:convert';

class EmployesTable extends StatefulWidget {
  const EmployesTable({super.key});

  @override
  State<EmployesTable> createState() => _EmployesTableState();
}

class _EmployesTableState extends State<EmployesTable> {
  late Future<List<EmployeeDto>> employes;
  StompClient? client;

  @override
  void initState(){
    super.initState();

    String serverIp = BlocProvider.of<ApplicationCubit>(context).state.serverIp;

    client = StompClient(
        config: StompConfig(
      url: 'ws://$serverIp:8080/ws',
      onConnect: onConnectCallback,
    ));
    client?.activate();
  }

  @override
  void dispose() {
    client?.deactivate();
    super.dispose();
  }

  void onConnectCallback(StompFrame connectFrame) {
    client?.subscribe(
      destination: '/topic/employees',
      headers: {},
      callback: (StompFrame frame) {
        final employeeJson = json.decode(frame.body!);
        final employee = EmployeeDto.fromJson(employeeJson);
        BlocProvider.of<EmployeInitCubit>(context).addEmploye(employee);

        ElegantNotification(
          width: 350,
          icon: const Icon(
            Icons.info_outlined,
            color: Color.fromARGB(255, 95, 172, 97),
          ),
          description: Text(
            'Se ha actualizado el estado de ${employee.fullName}',
          ),
          animation: AnimationType.fromRight,
          position: Alignment.topRight,
          autoDismiss: true,
          title: const Text(
            'Actualización de estado',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          toastDuration: const Duration(seconds: 3),
        ).show(context);
      },
    );
  }

  void sendMessage(EmployeeDto employe) {
    client?.send(
      destination: '/app/employees',
      body: json.encode(employe.toJson()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeInitCubit, EmployeInitState>(
        builder: (context, state) {
      return Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Table( 
          children: [
            const TableRow(
              children: [
                Text('Nombre', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('CI', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Estado', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('RFID', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Wifi', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Acciones', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            if (state.currentProjectEmployees.isNotEmpty)
            ..._buildEmployes(state.currentProjectEmployees),
          ],
        )
      );
    });
  }

  List<TableRow> _buildEmployes(List<EmployeeDto> employes) {
    final List<TableRow> rows = [];
    for (final employe in employes) {
      rows.add(TableRow(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 0.8,
            ),
          ),
        ),
        children: [
          TableCell(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8, right: 8),
              child: Text(employe.fullName),
            ),
          ),
          TableCell(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8, right: 8),
              child: Text(employe.ci),
            ),
          ),
          TableCell(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8, right: 8),
              child: Text(
                employe.update ? 'Activo' : 'Inactivo',
                style: TextStyle(color: employe.update ? Colors.green : Colors.red),
                ),
            ),
          ),
          TableCell(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8, right: 8),
              child: Text(
                employe.isPresentRfid ? 'Presente' : 'Ausente',
                style: TextStyle(color: employe.isPresentRfid ? Colors.green : Colors.red),
              ),
            ),
          ),
          TableCell(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8, right: 8),
              child: Text(
                employe.isPresentWifi ? 'Presente' : 'Ausente',
                style: TextStyle(color: employe.isPresentWifi ? Colors.green : Colors.red),
                ),
            ),
          ),
          TableCell(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8, right: 8),
              child: TextButton(
                style: TextButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  ),
                onPressed: () {
                  employe.update = !employe.update;
                  sendMessage(employe);
                },
                child: const Text('Cambiar estado'),
              ),
            ),
          ),
        ],
      ));
    }
    return rows;
  }

}
