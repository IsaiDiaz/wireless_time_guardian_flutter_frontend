import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/employe_init_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/general_application_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/project_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/employee_dto.dart';
import 'package:wireless_time_guardian_flutter_frontend/services/employe_services.dart';

class AddEmployeeToProjectForm extends StatefulWidget {
  final int projectId;
  const AddEmployeeToProjectForm({required this.projectId, super.key});

  @override
  State<AddEmployeeToProjectForm> createState() => _AddEmployeeToProjectFormState();
}

class _AddEmployeeToProjectFormState extends State<AddEmployeeToProjectForm> {

    EmployeeDto? _selectedEmpmloyee;
    List<EmployeeDto> allEmployees = [];
    String serverIp = "";

   @override
    void initState() {
      super.initState();
      loadEmployees();
    }

    Future<void> loadEmployees() async {
      serverIp = BlocProvider.of<ApplicationCubit>(context).state.serverIp;
      allEmployees = BlocProvider.of<EmployeInitCubit>(context)
            .state
            .currentProjectEmployees +
        BlocProvider.of<EmployeInitCubit>(context).state.allEmployees;
        setState(() {
          
        });
    }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar Empleado a Proyecto'),
      content: IntrinsicHeight(
        child: Column(
          children: [
            const Text('Empleados Disponibles:',
                style: TextStyle(
                  fontSize: 16,
                )),
            const SizedBox(
              height: 10,
            ),
            DropdownButton<EmployeeDto>(
              hint: const Text('Seleccione un empleado'),
              value: _selectedEmpmloyee,
              onChanged: (EmployeeDto? newValue) {
                setState(() {
                  _selectedEmpmloyee = newValue;
                });
              },
              items: allEmployees.map<DropdownMenuItem<EmployeeDto>>((EmployeeDto value) {
                return DropdownMenuItem<EmployeeDto>(
                  value: value,
                  child: Text(value.fullName),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cerrar")),
        TextButton(
            onPressed: () {
             if(_selectedEmpmloyee != null){
               Future<EmployeeDto> assignedEmployee = EmployeServices.assignEmployeeToProject(serverIp, _selectedEmpmloyee!.id!, widget.projectId, 1);
               assignedEmployee.then((value) => 
                BlocProvider.of<ProjectCubit>(context).addEmployeeToProject(widget.projectId, value)
               );
             }
              Navigator.of(context).pop();
            },
            child: const Text("Agregar"))
      ],
    );
  }
}
