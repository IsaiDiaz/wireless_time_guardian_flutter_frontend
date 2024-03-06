import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/general_application_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/employee_dto.dart';
import 'package:wireless_time_guardian_flutter_frontend/services/employe_services.dart';

class AddEmployeeDeviceForm extends StatelessWidget {
  final TextEditingController _deviceMacController = TextEditingController();
  final EmployeeDto employee;
  AddEmployeeDeviceForm({required this.employee, super.key});

  @override
  Widget build(BuildContext context) {

    String serverIp = BlocProvider.of<ApplicationCubit>(context).state.serverIp;

    return AlertDialog(
      title: const Text('Agregar dispositivo'),
      content: IntrinsicHeight(
        child: Column(
          children: [
            TextField(
              controller: _deviceMacController,
              decoration: const InputDecoration(
                labelText: 'MAC del dispositivo',
                hintText: '00:00:00:00:00:00',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            EmployeServices.postDevice(serverIp, employee.id!, _deviceMacController.text);
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: const Text('Agregar'),
        ),
      ],
    );
  }
}