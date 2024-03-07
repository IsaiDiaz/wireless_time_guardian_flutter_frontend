import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/general_application_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/project_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/employee_dto.dart';
import 'package:wireless_time_guardian_flutter_frontend/services/employe_services.dart';

class ProjectEmployees extends StatelessWidget {
  final int projectId;
  const ProjectEmployees({required this.projectId, super.key});

  @override
  Widget build(BuildContext context) {
    //Search employees for the projectId
    String serverIp = BlocProvider.of<ApplicationCubit>(context).state.serverIp;
    List<EmployeeDto> employees =
        BlocProvider.of<ProjectCubit>(context).getProjectEmployees(projectId);
    return Column(
      children: [
        const Text('Empleados'),
        employees.isEmpty
            ? const Text('No hay empleados asignados a este proyecto')
            : ListView.builder(
                shrinkWrap: true,
                itemCount: employees.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(employees[index].fullName),
                    subtitle: Text(employees[index].ci),
                    onLongPress: () {
                      EmployeServices.deleteEmployeeFromProject(serverIp, employees[index].id!, projectId);
                      BlocProvider.of<ProjectCubit>(context).deleteEmployeeFromProject(projectId, employees[index].id!);
                      print("Empleado eliminado del proyecto");
                    },
                  );
                },
              ),
      ],
    );
  }
}
