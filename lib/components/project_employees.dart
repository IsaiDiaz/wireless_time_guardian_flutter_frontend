import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/general_application_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/employee_dto.dart';
import 'package:wireless_time_guardian_flutter_frontend/services/employe_services.dart';

class ProjectEmployees extends StatelessWidget {
  final int projectId;
  const ProjectEmployees({required this.projectId, super.key});

  @override
  Widget build(BuildContext context) {
    //Search employees for the projectId
    String serverIp = BlocProvider.of<ApplicationCubit>(context).state.serverIp;
    Future<List<EmployeeDto>> employees = EmployeServices.getEmployeesByProject(serverIp, projectId);
    return Column(
      children: [
        const Text('Empleados'),
        FutureBuilder<List<EmployeeDto>>(
          future: employees,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index].fullName),
                      subtitle: Text(snapshot.data![index].ci),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
            }
            return const CircularProgressIndicator();
          },
        ),
      ],
    );
  }
}