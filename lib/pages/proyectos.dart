import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/project_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/components/add_project_form.dart';
import 'package:wireless_time_guardian_flutter_frontend/components/project_card.dart';

class Proyectos extends StatelessWidget {
  const Proyectos({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        return Column(children: [
          renderCurrentProject(state),
          renderProjects(state),
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
                    });
              },
              icon: const Icon(
                Icons.add_circle,
                color: Colors.white,
              ))
        ]);
      },
    );
  }

  Widget renderProjects(ProjectState state) {
    if (state.projects != null) {
      return Column(
          children:
              state.projects!.map((e) => ProjectCard(project: e)).toList());
    } else {
      return const Text("No hay proyectos");
    }
  }

  Widget renderCurrentProject(ProjectState state) {
    if (state.currentProject != null) {
      return ProjectCard(project: state.currentProject!);
    } else {
      return const Text("No hay proyectos");
    }
  }

}
