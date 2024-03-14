import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/employe_init_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/general_application_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/employee_dto.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/employee_entity.dart';
import 'package:wireless_time_guardian_flutter_frontend/services/employe_services.dart';

class AddEmployeeForm extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ciController = TextEditingController();

  AddEmployeeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Agregar Nuevo Empleado',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nombre'),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _ciController,
            decoration: const InputDecoration(labelText: 'CI'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              String name = _nameController.text.trim();
              String ci = _ciController.text.trim();

              if (name.isNotEmpty && ci.isNotEmpty) {
                var serverIp =
                    BlocProvider.of<ApplicationCubit>(context).state.serverIp;

                Future<EmployeeDto> savedEmployee = EmployeServices.postEmploye(
                    serverIp, EmployeeEntity(ci: ci, name: name));

                savedEmployee.then((value) {
                  BlocProvider.of<EmployeInitCubit>(context).addAllEmploye(value);
                    ElegantNotification(
                      width: 350,
                      icon: const Icon(
                        Icons.info_outlined,
                        color: Color.fromARGB(255, 95, 172, 97),
                      ),
                      description: const Text(
                        'Empleado agregado correctamente',
                      ),
                      animation: AnimationType.fromRight,
                      position: Alignment.topRight,
                      autoDismiss: true,
                      title: const Text(
                        'Registro exitoso',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      toastDuration: const Duration(seconds: 3),
                    ).show(context);
                    var actualizedEmployees = EmployeServices.getEmployesNotAssignedToCurrentProject(serverIp);
                    BlocProvider.of<EmployeInitCubit>(context).initAllEmployeesList(actualizedEmployees);
                    Navigator.of(context).pop();
                });

                _nameController.clear();
                _ciController.clear();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Por favor, complete todos los campos')),
                );
              }
            },
            child: const Text('Agregar Empleado'),
          ),
        ],
      ),
    );
  }
}
