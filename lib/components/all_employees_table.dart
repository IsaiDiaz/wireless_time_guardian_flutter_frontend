import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/employe_init_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/general_application_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/components/edit_employee_form.dart';
import 'package:wireless_time_guardian_flutter_frontend/components/employee_devices.dart';
import 'package:wireless_time_guardian_flutter_frontend/services/employe_services.dart';

class AllEmployeesTable extends StatelessWidget {
  const AllEmployeesTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var serverIp = BlocProvider.of<ApplicationCubit>(context).state.serverIp;

    return BlocBuilder<EmployeInitCubit, EmployeInitState>(
      builder: (context, state) {
        if (state.allEmployees.isNotEmpty) {
          BlocProvider.of<EmployeInitCubit>(context).deleteNooneEmployee();
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              children: [
                const Text(
                  'Todos los empleados',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Column(
                  children: state.allEmployees.map((employee) {
                    return ListTile(
                      title: Text(employee.fullName),
                      subtitle: Text(employee.ci),
                      trailing: IntrinsicWidth(
                        child: Row(
                          children: [
                            Icon(Icons.person,
                                color: employee.update ? Colors.green : Colors.red),
                                EmployeeDevices(employee: employee)
                          ],
                        ),
                      ),
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Eliminar empleado'),
                                content: Text(
                                    '¿Está seguro que desea eliminar al empleado ${employee.fullName}?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancelar')),
                                  TextButton(
                                      onPressed: () {
                                        EmployeServices.deleteEmployee(
                                            serverIp, employee.id!);
                                        BlocProvider.of<EmployeInitCubit>(
                                                context)
                                            .deleteEmployee(employee);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Eliminar'))
                                ],
                              );
                            });
                      },
                      onTap: () {
                        showDialog(context: context, 
                        builder: (BuildContext context){
                          return EditEmployeeForm(employee: employee);
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('No hay empleados'),
          );
        }
      },
    );
  }
}
