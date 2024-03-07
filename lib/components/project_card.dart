import 'package:flutter/material.dart';
import 'package:wireless_time_guardian_flutter_frontend/components/add_employee_to_project_form.dart';
import 'package:wireless_time_guardian_flutter_frontend/components/project_employees.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/project_dto.dart';

class ProjectCard extends StatelessWidget {
  final ProjectDto project;

  const ProjectCard({required this.project, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        child: ExpansionTile(
          leading: Text(
            project.projectIsCurrent ? 'Proyeto Activo' : 'Proyecto Inactivo',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: project.projectIsCurrent ? Colors.green : Colors.red,
            ),
          ),
          title: Text(
            project.projectName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            ProjectEmployees(projectId: project.projectId!),
            TextButton(onPressed: (){
              showDialog(
                context: context, 
                builder: (BuildContext context) {
                  return AddEmployeeToProjectForm(projectId: project.projectId!);
                }
              );
            }, 
            child: const Text('Agregar un empleado')),
            Text(
              'Fecha de inicio: ${project.projectInitialDate.toIso8601String().split('T')[0]}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Fecha de fin: ${project.projectFinalDate ?? 'Proyecto no finalizado'}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ));
  }
}
