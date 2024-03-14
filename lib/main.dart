import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/employe_init_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/general_application_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/page_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/project_cubit.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/employee_dto.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/project_dto.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/project_employees_dto.dart';
import 'package:wireless_time_guardian_flutter_frontend/pages/home.dart';
import 'package:wireless_time_guardian_flutter_frontend/services/employe_services.dart';
import 'package:wireless_time_guardian_flutter_frontend/services/project_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => PageBloc()),
    BlocProvider(create: (context) => EmployeInitCubit()),
    BlocProvider(create: (context) => ApplicationCubit()),
    BlocProvider(create: (context) => ProjectCubit())
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    String serverIp = BlocProvider.of<ApplicationCubit>(context).state.serverIp;

    Future<ProjectDto?> currentProject =
        ProjectService.getCurrentProject(serverIp);
    currentProject.then((value) =>
        BlocProvider.of<ProjectCubit>(context).setCurrentProject(value));

    Future<List<ProjectDto>> projects =
        ProjectService.getNotCurrentProjects(serverIp);
    projects.then(
        (value) => BlocProvider.of<ProjectCubit>(context).initProjects(value));

    Future<List<EmployeeDto>?> currentEmployees =
        EmployeServices.getEmployesFromCurrentProject(serverIp);
    BlocProvider.of<EmployeInitCubit>(context).initList(currentEmployees);

    Future<List<EmployeeDto>?> allEmployees =
        EmployeServices.getEmployesNotAssignedToCurrentProject(serverIp);
    BlocProvider.of<EmployeInitCubit>(context)
        .initAllEmployeesList(allEmployees);

    Future<List<ProjectDto>> allProjects =
        ProjectService.getAllProjects(serverIp);
    allProjects.then((projects) {
      for (ProjectDto project in projects) {
        Future<List<EmployeeDto>> projectEmployees =
            EmployeServices.getEmployeesByProject(serverIp, project.projectId!);
        projectEmployees.then((value) {
          ProjectEmployeesDto projectEmployeesDto =
              ProjectEmployeesDto(projectId: project.projectId!, employees: value);
          BlocProvider.of<ProjectCubit>(context).addProjectEmployee(
              projectEmployeesDto);
        });
      }
    });

    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es', 'ES'),
      ],
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green, brightness: Brightness.light),
          textTheme: const TextTheme(
              displayLarge: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ))),
      home: const Scaffold(body: HomePage()),
    );
  }
}
