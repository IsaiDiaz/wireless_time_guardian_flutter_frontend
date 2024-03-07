import 'package:wireless_time_guardian_flutter_frontend/dto/employee_dto.dart';

class ProjectEmployeesDto {
  final int projectId;
  final List<EmployeeDto> employees;

  ProjectEmployeesDto({required this.projectId, required this.employees});

  factory ProjectEmployeesDto.fromJson(Map<String, dynamic> json) {
    return ProjectEmployeesDto(
      projectId: json['projectId'],
      employees: (json['employees'] as List).map((e) => EmployeeDto.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'employees': employees.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'ProjectEmployeesDto{projectId: $projectId, employees: $employees}';
  }
}