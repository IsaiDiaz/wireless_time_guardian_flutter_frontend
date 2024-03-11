import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/general_application_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/project_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/project_dto.dart';
import 'package:wireless_time_guardian_flutter_frontend/services/project_service.dart';

class EditProjectForm extends StatefulWidget {
  final ProjectDto project;
  const EditProjectForm({required this.project, Key? key}) : super(key: key);

  @override
  State<EditProjectForm> createState() => _EditProjectFormState();
}

class _EditProjectFormState extends State<EditProjectForm> {
  late TextEditingController _nameController;
  late DateTime _selectedDate;
  late String serverIp;

  @override
  void initState() {
    super.initState();
    serverIp = BlocProvider.of<ApplicationCubit>(context).state.serverIp;
    _nameController = TextEditingController(text: widget.project.projectName);
    _selectedDate = widget.project.projectInitialDate.toLocal();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Proyecto'),
      content: IntrinsicHeight(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre del Proyecto',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Fecha de Inicio:',
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
                  DateFormat('dd-MM-yyyy').format(_selectedDate),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                )),
                IconButton(
                    onPressed: () {
                      _showDatePicker(context);
                    },
                    icon: const Icon(Icons.calendar_today)
                )
              ],
            )
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
        TextButton(
          onPressed: () {
            ProjectDto localUpdatedProject = ProjectDto(
              projectId: widget.project.projectId,
              projectName: _nameController.text,
              projectInitialDate: _selectedDate.toUtc(),
              projectIsCurrent: widget.project.projectIsCurrent,
            );
            Future<ProjectDto> updatedProject = ProjectService.updateProject(serverIp, localUpdatedProject);
            updatedProject.then((value) {
              BlocProvider.of<ProjectCubit>(context).updateProject(value);
              Navigator.of(context).pop();
            });
          },
          child: const Text('Guardar'),
        )
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

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

}
