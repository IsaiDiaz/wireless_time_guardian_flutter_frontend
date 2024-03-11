import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:wireless_time_guardian_flutter_frontend/dto/project_dto.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/response_dto.dart';

class ProjectService{
  
  static Future<ProjectDto> getCurrentProject(String serverIp) async {
    final response = await http.get(Uri.parse('http://$serverIp:8080/api/v1/project/current'));
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final responseDto = ResponseDto.fromJson(jsonResponse);
      final projectDto = ProjectDto.fromJson(responseDto.data);
      return projectDto;
    } else {
      throw Exception('Failed to load current project');
    }
  }

  static Future<List<ProjectDto>> getNotCurrentProjects(String serverIp) async {
    final response = await http.get(Uri.parse('http://$serverIp:8080/api/v1/project/not_current'));
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final responseDto = ResponseDto.fromJson(jsonResponse);
      final List<dynamic> dataList = responseDto.data;
      final List<ProjectDto> projects = dataList.map((e) => ProjectDto.fromJson(e)).toList();
      return projects;
    } else {
      throw Exception('Failed to load projects');
    }
  }

  static Future<void> createProject(String serverIp, ProjectDto projectDto) async {
    final response = await http.post(
      Uri.parse('http://$serverIp:8080/api/v1/project'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(projectDto.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create project');
    }
  }

  static Future<List<ProjectDto>> getAllProjects(String serverIp) async {
    final response = await http.get(Uri.parse('http://$serverIp:8080/api/v1/project/all'));
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final responseDto = ResponseDto.fromJson(jsonResponse);
      final List<dynamic> dataList = responseDto.data;
      final List<ProjectDto> projects = dataList.map((e) => ProjectDto.fromJson(e)).toList();
      return projects;
    } else {
      throw Exception('Failed to load projects');
    }
  }

  static Future<ProjectDto> updateCurrentProject(String serverIp, int projectId) async {
    final response = await http.put(
      Uri.parse('http://$serverIp:8080/api/v1/project/current/$projectId'),
    );
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final responseDto = ResponseDto.fromJson(jsonResponse);
      final projectDto = ProjectDto.fromJson(responseDto.data);
      return projectDto;
    } else {
      throw Exception('Failed to update current project');
    }
  }

  //make a project inactive
  static Future<ProjectDto> updateProjectState(String serverIp, int projectId) async {
    final response = await http.put(
      Uri.parse('http://$serverIp:8080/api/v1/project/not_current/$projectId'),
    );
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final responseDto = ResponseDto.fromJson(jsonResponse);
      final projectDto = ProjectDto.fromJson(responseDto.data);
      return projectDto;
    } else {
      throw Exception('Failed to update project');
    }
  } 

  static Future<ProjectDto> updateProject(String serverIp, ProjectDto projectDto) async {
    final response = await http.put(
      Uri.parse('http://$serverIp:8080/api/v1/project'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(projectDto.toJson()),
    );
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final responseDto = ResponseDto.fromJson(jsonResponse);
      final projectDto = ProjectDto.fromJson(responseDto.data);
      return projectDto;
    } else {
      throw Exception('Failed to update project');
    }
  }

}