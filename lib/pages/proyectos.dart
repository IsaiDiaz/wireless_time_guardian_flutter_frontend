import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/general_application_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/project_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/components/add_project_form.dart';
import 'package:wireless_time_guardian_flutter_frontend/components/project_card.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/project_dto.dart';
import 'package:wireless_time_guardian_flutter_frontend/services/project_service.dart';

class Proyectos extends StatelessWidget {
  const Proyectos({super.key});

  @override
  Widget build(BuildContext context) {
    String serverIp = BlocProvider.of<ApplicationCubit>(context).state.serverIp;

    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        if (state.currentProject == null) {
          Future<ProjectDto> currentProject =
              ProjectService.getCurrentProject(serverIp);
          currentProject.then((value) {
            BlocProvider.of<ProjectCubit>(context).setCurrentProject(value);
          });
          if (state.projects == null) {
            Future<List<ProjectDto>> projects =
                ProjectService.getNotCurrentProjects(serverIp);
            projects.then((value) {
              BlocProvider.of<ProjectCubit>(context).initProjects(value);
            });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            children: [
              ProjectCard(project: state.currentProject!),
              ...state.projects!.map((e) => ProjectCard(project: e)).toList(),
              const SizedBox(
                height: 20,
              ),
              IconButton(
                  tooltip: "Agregar nuevo proyecto",
                  iconSize: 40,
                  onPressed: () {
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return const AddProjectForm();
                      }
                      );
                  },
                  icon: const Icon(
                    Icons.add_circle,
                    color: Colors.white,
                  ))
            ],
          );
        }
      },
    );
  }
}
