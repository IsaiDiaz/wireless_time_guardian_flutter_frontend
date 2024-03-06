import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/employe_init_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/general_application_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/employee_dto.dart';
import 'package:wireless_time_guardian_flutter_frontend/services/employe_services.dart';

class EditEmployeeForm extends StatefulWidget {
  final EmployeeDto employee;

  const EditEmployeeForm({required this.employee, super.key});

  @override
  State<EditEmployeeForm> createState() => _EditEmployeeFormState();
}

class _EditEmployeeFormState extends State<EditEmployeeForm> {
  late TextEditingController _nameController;
  late TextEditingController _ciController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.employee.fullName);
    _ciController = TextEditingController(text: widget.employee.ci);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ciController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      content: IntrinsicHeight(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10) 
          ),
          child: Column(
            children: [
              const Text(
                'Editar Empleado',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _ciController,
                decoration: const InputDecoration(labelText: 'CI'),
              ),
            ],
          ),
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
            String serverIp = BlocProvider.of<ApplicationCubit>(context).state.serverIp;
            EmployeeDto updatedEmployee = EmployeeDto(
              id: widget.employee.id,
              fullName: _nameController.text,
              ci: _ciController.text,
              update: widget.employee.update,
              isPresentRfid: widget.employee.isPresentRfid,
              isPresentWifi: widget.employee.isPresentWifi,
            );
            BlocProvider.of<EmployeInitCubit>(context).updateAllEmployeesEmployee(updatedEmployee);
            EmployeServices.updateEmployee(serverIp, updatedEmployee);
            Navigator.of(context).pop();
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}