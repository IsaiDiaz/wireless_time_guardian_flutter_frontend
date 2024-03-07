import 'package:flutter/material.dart';
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
        title: Text(
          project.projectName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          ),
        children: [
          ProjectEmployees(projectId: project.projectId!),
          Text(
            'Fecha de inicio: ${project.projectInitialDate.toIso8601String().split('T')[0]}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            ),
          Text(
            'Fecha de fin: ${project.projectFinalDate?? 'Proyecto no finalizado'}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
        )
    );
  }
}