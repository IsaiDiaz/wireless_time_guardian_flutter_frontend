import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/employe_init_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/employee_dto.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/recived_message.dart';
import 'dart:convert';

class EmployesTable extends StatefulWidget {
  const EmployesTable({super.key});

  @override
  State<EmployesTable> createState() => _EmployesTableState();
}

class _EmployesTableState extends State<EmployesTable> {
  StompClient? client;

  @override
  void initState() {
    super.initState();
    client = StompClient(
        config: StompConfig(
      url: 'ws://localhost:8080/ws',
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
    print('Conectado');
    client?.subscribe(
      destination: '/topic/greetings',
      headers: {},
      callback: (StompFrame frame) {
        final body = json.decode(frame.body!);
        final recivedMessage = RecivedMessage.fromJson(body);
        print('Recibido: ${recivedMessage.content}');
      },
    );
  }

  void sendMessage() {
    client?.send(
      destination: '/app/hello',
      body: '{"name": "flutter"}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeInitCubit, EmployeInitState>(
        builder: (context, state) {
      return Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Table(
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
                ..._buildEmployes(state.employes),
              ],
            ),
            TextButton(onPressed: 
            (){
              //harcoded add employee
              BlocProvider.of<EmployeInitCubit>(context).addEmploye(EmployeeDto(
                id: 99,
                fullName: 'Juan Perez',
                ci: '1234567',
                update: true,
                isPresentRfid: true,
                isPresentWifi: true,
              ));
            }
            , child: const Text('Agregar Empleado'))
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
            child: Text(employe.fullName),
          ),
          TableCell(
            child: Text(employe.ci),
          ),
          TableCell(
            child: Text(
              employe.update ? 'Activo' : 'Inactivo',
              style: TextStyle(color: employe.update ? Colors.green : Colors.red),
              ),
          ),
          TableCell(
            child: Text(
              employe.isPresentRfid ? 'Presente' : 'Ausente',
              style: TextStyle(color: employe.isPresentRfid ? Colors.green : Colors.red),
            ),
          ),
          TableCell(
            child: Text(
              employe.isPresentWifi ? 'Presente' : 'Ausente',
              style: TextStyle(color: employe.isPresentWifi ? Colors.green : Colors.red),
              ),
          ),
          TableCell(
            child: TextButton(
              onPressed: () {
                BlocProvider.of<EmployeInitCubit>(context).removeEmploye(employes.indexOf(employe));
              },
              child: const Text('Cambiar estado'),
            ),
          ),
        ],
      ));
    }
    return rows;
  }

}
