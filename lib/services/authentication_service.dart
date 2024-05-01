import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://splitter-sync-api.vercel.app/users';

  static Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        return jsonDecode(response.body);
      } else {
        // Handling error response from the server
        return {
          'error': true,
          'message': 'Failed to register. Error: ${response.statusCode}',
          'data': jsonDecode(response.body)
        };
      }
    } catch (e) {
      // Handling exceptions during the HTTP request
      return {'error': true, 'message': 'Exception during registration: $e'};
    }
  }

  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Success
        return jsonDecode(response.body);
      } else {
        // Handling error response from the server
        return {
          'error': true,
          'message': 'Failed to login. Error: ${response.statusCode}',
          'data': jsonDecode(response.body)
        };
      }
    } catch (e) {
      // Handling exceptions during the HTTP request
      return {'error': true, 'message': 'Exception during login: $e'};
    }
  }
}
