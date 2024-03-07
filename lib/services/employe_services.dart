import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:wireless_time_guardian_flutter_frontend/dto/device_dto.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/employee_dto.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/employee_entity.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/response_dto.dart';

class EmployeServices {
  /// Get all employes for current project
  static Future<List<EmployeeDto>> getEmployesFromCurrentProject(
      String serverIp) async {
    final response = await http
        .get(Uri.parse('http://$serverIp:8080/api/v1/employe/current_project'));
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final responseDto = ResponseDto.fromJson(jsonResponse);
      final List<dynamic> dataList = responseDto.data;
      final List<EmployeeDto> employees =
          dataList.map((e) => EmployeeDto.fromJson(e)).toList();
      return employees;
    } else {
      throw Exception('Failed to load employes');
    }
  }

  /// Post a new employe
  static Future<bool> postEmploye(
      String serverIp, EmployeeEntity employe) async {
    final response = await http.post(
      Uri.parse('http://$serverIp:8080/api/v1/employe'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(employe.toJson()),
    );
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final responseDto = ResponseDto.fromJson(jsonResponse);
      final responseData = responseDto.data;
      return responseData;
    } else {
      throw Exception('Failed to create employe');
    }
  }

  static Future<List<EmployeeDto>> getEmployesNotAssignedToCurrentProject(
      String serverIp) async {
    final response = await http.get(Uri.parse(
        'http://$serverIp:8080/api/v1/employe/not_assigned_to_current_project'));
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final responseDto = ResponseDto.fromJson(jsonResponse);
      final List<dynamic> dataList = responseDto.data;
      final List<EmployeeDto> employees =
          dataList.map((e) => EmployeeDto.fromJson(e)).toList();
      return employees;
    } else {
      throw Exception('Failed to load employes');
    }
  }

  static Future<EmployeeDto> updateEmployee(
      String serverIp, EmployeeDto employeeDto) async {
    final response = await http.put(
      Uri.parse('http://$serverIp:8080/api/v1/employe'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(employeeDto.toJson()),
    );

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final responseDto = ResponseDto.fromJson(jsonResponse);
      final responseData = responseDto.data;
      return EmployeeDto.fromJson(responseData);
    } else {
      throw Exception('Failed to update employe');
    }
  }

  static Future<void> deleteEmployee(String serverIp, int id) async {
    final response = await http
        .delete(Uri.parse('http://$serverIp:8080/api/v1/employe/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete employe');
    }
  }

  static Future<List<DeviceDto>> getDevices(
      String serverIp, int employeeId) async {
    final response = await http.get(
        Uri.parse('http://$serverIp:8080/api/v1/employe/device/$employeeId'));
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final responseDto = ResponseDto.fromJson(jsonResponse);
      final List<dynamic> dataList = responseDto.data;
      final List<DeviceDto> devices =
          dataList.map((e) => DeviceDto.fromJson(e)).toList();
      return devices;
    } else {
      throw Exception('Failed to load devices');
    }
  }

  static Future<bool> postDevice(
      String serverIp, int employeeId, String deviceMac) async {
    final response = await http.post(
      Uri.parse('http://$serverIp:8080/api/v1/employe/device/$employeeId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert
          .jsonEncode({'employeeId': employeeId, 'deviceMac': deviceMac}),
    );
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final responseDto = ResponseDto.fromJson(jsonResponse);
      final responseData = responseDto.data;
      return responseData;
    } else {
      throw Exception('Failed to create device');
    }
  }

  static Future<List<EmployeeDto>> getEmployeesByProject(
      String serverIp, int projectId) async {
    final response = await http.get(
        Uri.parse('http://$serverIp:8080/api/v1/employe/project/$projectId'));
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final responseDto = ResponseDto.fromJson(jsonResponse);
      final List<dynamic> dataList = responseDto.data;
      final List<EmployeeDto> employees =
          dataList.map((e) => EmployeeDto.fromJson(e)).toList();
      return employees;
    } else {
      throw Exception('Failed to load employes');
    }
  }

  static Future<EmployeeDto> assignEmployeeToProject(
      String serverIp, int employeeId, int projectId, int salaryId) async {
    final response = await http.post(
      Uri.parse(
          'http://$serverIp:8080/api/v1/employe/$employeeId/project/$projectId/salary/$salaryId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final responseDto = ResponseDto.fromJson(jsonResponse);
      final responseData = responseDto.data;
      return EmployeeDto.fromJson(responseData);
    } else {
      throw Exception('Failed to assign employee to project');
    }
  }

  static Future<void> deleteEmployeeFromProject(
      String serverIp, int employeeId, int projectId) async {
    final response = await http.delete(Uri.parse(
        'http://$serverIp:8080/api/v1/employe/$employeeId/project/$projectId'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete employe from project');
    }
  }
}
