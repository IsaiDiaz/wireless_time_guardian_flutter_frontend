import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/employe_init_cubit.dart';

class CurrentProjectEmployeesTable extends StatelessWidget {
  const CurrentProjectEmployeesTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeInitCubit, EmployeInitState>(
      builder: (context, state) {
        if (state.currentProjectEmployees.isNotEmpty) {
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              children: [
                const Text(
                  'Empleados del proyecto actual',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Column(
                  children: 
                  state.currentProjectEmployees.map((employee) {
                    return ListTile(
                      title: Text(employee.fullName),
                      subtitle: Text(employee.ci),
                      trailing: Icon(Icons.person, color: employee.update? Colors.green:Colors.red),
                      onLongPress: () {
                        //snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Empleado: ${employee.fullName}'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      
                      // Puedes agregar más información del empleado aquí si lo deseas
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(), // Muestra un indicador de carga mientras se carga la lista de empleados
          );
        }
      },
    );
  }
}

