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

}