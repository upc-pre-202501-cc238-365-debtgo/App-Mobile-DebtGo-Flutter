import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5062/api/v1';

  Future<List<Map<String, dynamic>>> getConsultants() async {
    final response = await http.get(Uri.parse('$baseUrl/api/v1/consultants'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Error al obtener consultores: ${response.statusCode}');
    }
  }

  Future<bool> createConsultant(String name, String email) async {
    final url = Uri.parse('$baseUrl/consultants');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email}),
    );

    return response.statusCode == 201 || response.statusCode == 200;
  }
}