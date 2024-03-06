import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/general_application_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/components/add_employee_device_form.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/device_dto.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/employee_dto.dart';
import 'package:wireless_time_guardian_flutter_frontend/services/employe_services.dart';

class EmployeeDevices extends StatelessWidget {
  final EmployeeDto employee;
  const EmployeeDevices({required this.employee, super.key});

  @override
  Widget build(BuildContext context) {
    String serverIp = BlocProvider.of<ApplicationCubit>(context).state.serverIp;
    return IconButton(   
      tooltip: 'Dispositivos del empleado',
      onPressed: (){
      Future<List<DeviceDto>> employeeDevices = EmployeServices.getDevices(serverIp, employee.id!);
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text('Dispositivos del empleado'),
            content: IntrinsicHeight(
              child: FutureBuilder<List<DeviceDto>>(
                future: employeeDevices,
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const CircularProgressIndicator();
                  }
                  if(snapshot.hasData){
                    if(
                      snapshot.data!.isEmpty
                    ){
                      return const Text('No se encontraron dispositivos');
                    }
                    return Column(
                      children: snapshot.data!.map((device){
                        return ListTile(
                          title: Text(device.deviceMac)
                        );
                      }).toList(),
                    );
                  }
                  return const Text('No se encontraron dispositivos');
                },
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                  showDialog(context: context, builder: (BuildContext context){
                    return AddEmployeeDeviceForm(employee: employee); 
                  });
              }, child: const Text('Agregar dispositivo')),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                }, 
                child: const Text('Cerrar')
              )
            ],
          );
        }
      );
    }, 
    icon: const Icon(Icons.devices)
    );
  }
}