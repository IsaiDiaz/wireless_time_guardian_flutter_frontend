import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:wireless_time_guardian_flutter_frontend/dto/employee_dto.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/response_dto.dart';

class EmployeServices {

  static Future<List<EmployeeDto>> getEmployesFromCurrentProject(String serverIp) async {
    final response = await http.get(Uri.parse('http://$serverIp:8080/api/v1/employe/current_project'));
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final responseDto = ResponseDto.fromJson(jsonResponse);
      final List<dynamic> dataList = responseDto.data;
      final List<EmployeeDto> employees = dataList.map((e) => EmployeeDto.fromJson(e)).toList();
      return employees;
    } else {
      throw Exception('Failed to load employes');
    }
  }

  
}
