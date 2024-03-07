import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/project_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/components/project_card.dart';


class Proyectos extends StatelessWidget {
  const Proyectos({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        return ProjectCard(project: state.currentProject!);
      },
    );
  }
}