import 'package:wireless_time_guardian_flutter_frontend/dto/project_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/project_employees_dto.dart';

class ProjectState {
  List<ProjectDto>? projects;
  ProjectDto? currentProject;
  List<ProjectEmployeesDto>? projectEmployees;

  ProjectState({this.projects, this.currentProject, this.projectEmployees});

  ProjectState copyWith({List<ProjectDto>? projects, ProjectDto? currentProject, List<ProjectEmployeesDto>? projectEmployees}) {
    return ProjectState(
      projects: projects ?? this.projects,
      currentProject: currentProject ?? this.currentProject,
      projectEmployees: projectEmployees ?? this.projectEmployees,
    );
  }
}

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit() : super(ProjectState());

  void initProjects(List<ProjectDto> projects) {
    emit(state.copyWith(projects: projects));
  }

  void setCurrentProject(ProjectDto project) {
    emit(state.copyWith(currentProject: project));
  }

  void addProject(ProjectDto project) {
    emit(state.copyWith(projects: [...state.projects!, project]));
  }

  void deleteProject(int projectId) {
    emit(state.copyWith(projects: state.projects!.where((p) => p.projectId != projectId).toList()));
  }

  void initProjectEmployees(List<ProjectEmployeesDto> projectEmployees) {
    emit(state.copyWith(projectEmployees: projectEmployees));
  }

  void addProjectEmployee(ProjectEmployeesDto projectEmployee) {
    emit(state.copyWith(projectEmployees: [...state.projectEmployees!, projectEmployee]));
  }

  void deleteProjectEmployee(int projectId) {
    emit(state.copyWith(projectEmployees: state.projectEmployees!.where((pe) => pe.projectId != projectId).toList()));
  }
}

