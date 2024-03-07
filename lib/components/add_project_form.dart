import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/general_application_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/project_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/project_dto.dart';
import 'package:wireless_time_guardian_flutter_frontend/services/project_service.dart';

class AddProjectForm extends StatefulWidget {
  const AddProjectForm({super.key});

  @override
  State<AddProjectForm> createState() => _AddProjectFormState();
}

class _AddProjectFormState extends State<AddProjectForm> {
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _projectInitialDateController =
      TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _projectInitialDateController.text =
        DateFormat('yyyy-MM-dd').format(_selectedDate);
  }

  @override
  void dispose() {
    _projectNameController.dispose();
    _projectInitialDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String serverIp = BlocProvider.of<ApplicationCubit>(context).state.serverIp;
    return AlertDialog(
      title: const Text('Crear Proyecto'),
      content: IntrinsicHeight(
        child: Column(
          children: [
            TextField(
              controller: _projectNameController,
              decoration: const InputDecoration(
                labelText: 'Nombre del Proyecto',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Fecha de Inicio:',
                style: TextStyle(
                  fontSize: 16,
                )),
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
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () {
                    _showDatePicker(context);
                  },
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
            child: const Text('Cancelar')),
        TextButton(
            onPressed: () {
              ProjectDto project = ProjectDto(
                  projectName: _projectNameController.text,
                  projectInitialDate: _selectedDate.toUtc(),
                  projectFinalDate: null,
                  projectIsCurrent: false);
              Future<void> postProject =
                  ProjectService.createProject(serverIp, project);
              postProject.then((value) {
                Future<List<ProjectDto>> projects =
                    ProjectService.getNotCurrentProjects(serverIp);
                projects.then((value) {
                  BlocProvider.of<ProjectCubit>(context).initProjects(value);
                });
              });
              Navigator.of(context).pop();
            },
            child: const Text('Crear'))
      ],
    );
  }

  void _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        locale: const Locale('es', 'ES'));

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked.toLocal();
      });
    }
  }
}
