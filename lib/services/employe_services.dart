import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class EmployeServices {
  static Future<List<Map<String, dynamic>>> getEmployes() async {
    final response = await http.get(Uri.parse('http://localhost:3000/employes'));
    if (response.statusCode == 200) {
      final List<dynamic> employes = convert.jsonDecode(response.body);
      return employes.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load employes');
    }
  }
}
