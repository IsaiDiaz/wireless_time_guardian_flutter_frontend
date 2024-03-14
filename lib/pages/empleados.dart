import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/employe_init_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/components/add_employee_form.dart';
import 'package:wireless_time_guardian_flutter_frontend/components/all_employees_table.dart';
import 'package:wireless_time_guardian_flutter_frontend/components/current_project_employees_table.dart';

class Empleados extends StatelessWidget {
  const Empleados({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeInitCubit, EmployeInitState>(
      builder: (context, state) {
        return Column(
      children: [
        const CurrentProjectEmployeesTable(),
        const SizedBox(height: 20),
        const AllEmployeesTable(),
        const SizedBox(height: 20),
        IconButton(
          tooltip: "Agregar nuevo empleado",
          iconSize: 40,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    content: IntrinsicHeight(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: AddEmployeeForm()),
                    ),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cerrar"))
                    ],
                  );
                });
          },
          icon: const Icon(
            Icons.add_circle,
            color: Colors.white,
          ),
        )
      ],
    );
      },
    );
  }
}
