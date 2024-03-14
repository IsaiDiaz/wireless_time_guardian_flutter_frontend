import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/general_application_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/employee_advance_dto.dart';
import 'package:wireless_time_guardian_flutter_frontend/services/project_service.dart';

class AddEmployeeAdvanceForm extends StatefulWidget {
  final int projectId;
  final int employeeId;

  const AddEmployeeAdvanceForm(this.projectId, this.employeeId, {Key? key}) : super(key: key);

  @override
  State<AddEmployeeAdvanceForm> createState() => _AddEmployeeAdvanceFormState();
}

class _AddEmployeeAdvanceFormState extends State<AddEmployeeAdvanceForm> {
  final TextEditingController _advanceAmountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Crear adelanto del empleado'),
      content: IntrinsicHeight(
        child: Column(
          children: [
            TextField(
              controller: _advanceAmountController,
              decoration: const InputDecoration(
                labelText: 'Cantidad del Adelanto',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            const Text(
              'Fecha del Adelanto:',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    DateFormat('dd-MM-yyyy').format(_selectedDate),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _showDatePicker(context);
                  },
                  icon: const Icon(Icons.calendar_today),
                ),
              ],
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
        ElevatedButton(
          onPressed: () {
            _createEmployeeAdvance();
          },
          child: const Text('Crear'),
        ),
      ],
    );
  }

  void _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('es', 'ES'),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _createEmployeeAdvance() {
    double amount = double.tryParse(_advanceAmountController.text) ?? 0.0;
    EmployeeAdvanceDto newAdvance = EmployeeAdvanceDto(
      employeAdvanceAmount: amount,
      employeAdvanceDate: _selectedDate,
      projectEmployeId: widget.employeeId,
    );

    String serverIp = BlocProvider.of<ApplicationCubit>(context).state.serverIp;

    ProjectService.postEmployeeAdvancePayment(serverIp, widget.projectId, widget.employeeId, newAdvance).then((createdAdvance) {
      // Aquí puedes manejar la respuesta, por ejemplo, mostrar un mensaje de éxito y cerrar el diálogo.
      Navigator.of(context).pop();
    }).catchError((error) {
      // Aquí puedes manejar errores, por ejemplo, mostrar un mensaje de error.
      print('Error al crear el avance del empleado: $error');
    });
  }
}
