import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/general_application_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/project_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/components/add_employee_to_project_form.dart';
import 'package:wireless_time_guardian_flutter_frontend/components/edit_project_form.dart';
import 'package:wireless_time_guardian_flutter_frontend/components/project_employees.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/project_dto.dart';
import 'package:wireless_time_guardian_flutter_frontend/services/project_service.dart';

class ProjectCard extends StatelessWidget {
  final ProjectDto project;

  const ProjectCard({required this.project, super.key});

  @override
  Widget build(BuildContext context) {
    String serverIp = BlocProvider.of<ApplicationCubit>(context).state.serverIp;
    return Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        child: ExpansionTile(
          leading: TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Cambiar estado del proyecto'),
                    content: IntrinsicHeight(
                      child: Text(
                        project.projectIsCurrent
                            ? '¿Desea desactivar el proyecto ${project.projectName}?'
                            : '¿Desea activar el proyecto ${project.projectName}?',
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
                          if (project.projectIsCurrent) {
                            Future<ProjectDto> updatedProject =
                                ProjectService.updateProjectState(
                                    serverIp, project.projectId!);
                            updatedProject.then((value) =>
                                BlocProvider.of<ProjectCubit>(context)
                                    .addProject(value));
                          } else {
                            Future<ProjectDto> updatedProject =
                                ProjectService.updateCurrentProject(
                                    serverIp, project.projectId!);
                            updatedProject.then((value) {
                              BlocProvider.of<ProjectCubit>(context)
                                  .deleteProject(project.projectId!);
                              ProjectDto currentProject =
                                  BlocProvider.of<ProjectCubit>(context)
                                      .state
                                      .currentProject!;
                              currentProject.projectIsCurrent = false;
                              if (currentProject.projectId != null) {
                                BlocProvider.of<ProjectCubit>(context)
                                    .addProject(currentProject);
                              }
                              BlocProvider.of<ProjectCubit>(context)
                                  .setCurrentProject(value);
                            });
                          }
                          Navigator.of(context).pop();
                        },
                        child: const Text('Aceptar'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text(
              project.projectIsCurrent ? 'Proyeto Activo' : 'Proyecto Inactivo',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: project.projectIsCurrent ? Colors.green : Colors.red,
              ),
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
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddEmployeeToProjectForm(
                            projectId: project.projectId!);
                      });
                },
                child: const Text('Agregar un empleado')),
            TextButton(onPressed: (){
              showDialog(context: context, 
              builder: (BuildContext context) {
                return EditProjectForm(project: project);
              });
            }, child: const Text('Editar proyecto')),
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
