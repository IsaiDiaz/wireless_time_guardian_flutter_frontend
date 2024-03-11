import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/general_application_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/project_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/project_dto.dart';
import 'package:wireless_time_guardian_flutter_frontend/services/project_service.dart';

class EditProjectFinalDateForm extends StatefulWidget {
  final ProjectDto project;
  const EditProjectFinalDateForm({required this.project, Key? key}) : super(key: key);

  @override
  State<EditProjectFinalDateForm> createState() => _EditProjectFinalDateFormState();
}

class _EditProjectFinalDateFormState extends State<EditProjectFinalDateForm> {
  late DateTime? _selectedEndDate;
  late String serverIp;

  @override
  void initState() {
    super.initState();
    serverIp = BlocProvider.of<ApplicationCubit>(context).state.serverIp;
    _selectedEndDate = widget.project.projectFinalDate?.toLocal();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Fecha de Finalización del Proyecto'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fecha de Finalización:',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  _selectedEndDate != null ? DateFormat('dd-MM-yyyy').format(_selectedEndDate!) : 'No definida',
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
              )
            ],
          )
        ],
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
            _updateProject();
          },
          child: const Text('Guardar'),
        )
      ],
    );
  }

  void _showDatePicker(BuildContext context) async {
    try {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate ?? DateTime.now(),
      firstDate: widget.project.projectInitialDate.toLocal(),
      lastDate: DateTime(2100),
      locale: const Locale('es', 'ES'),
    );


    if (picked != null && picked != _selectedEndDate) {
      setState(() {
        _selectedEndDate = picked;
      });
    }
    } catch (e) {
      showDialog(context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text('Error al seleccionar la fecha de finalización: $e'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            )
          ],
        );
      });
    }
  }

  void _updateProject() {
    ProjectDto localUpdatedProject = ProjectDto(
      projectId: widget.project.projectId,
      projectName: widget.project.projectName,
      projectInitialDate: widget.project.projectInitialDate,
      projectFinalDate: _selectedEndDate?.toUtc(),
      projectIsCurrent: widget.project.projectIsCurrent,
    );

    Future<ProjectDto> updatedProject = ProjectService.updateProject(serverIp, localUpdatedProject);
    updatedProject.then((value) {
      BlocProvider.of<ProjectCubit>(context).updateProject(value);
      Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
