import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {

  static const String baseUrl =
      'http://10.0.2.2/syrn_api';

  /* REGISTER */
  static Future<Map<String, dynamic>> register(
      String firstName,
      String lastName,
      String email,
      String password,
      String role,
      ) async {

    try {

      final response = await http.post(

        Uri.parse('$baseUrl/signup.php'),

        headers: {
          'Content-Type':
          'application/x-www-form-urlencoded',
        },

        body: {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'password': password,
          'role': role,
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {
          'success': true,
          'data': data,
        };
      }

      return {
        'success': false,
        'message': data['message'],
      };

    } catch (e) {

      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  /* LOGIN */
  static Future<Map<String, dynamic>> login(
      String email,
      String password,
      ) async {

    try {

      final response = await http.post(

        Uri.parse('$baseUrl/login.php'),

        headers: {
          'Content-Type':
          'application/x-www-form-urlencoded',
        },

        body: {
          'email': email,
          'password': password,
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {

        return {
          'success': true,
          'data': data,
        };
      }

      return {
        'success': false,
        'message': data['message'] ?? 'Login failed',
        'attempts_left': data['attempts_left'],
      };

    } catch (e) {

      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  /* LOGOUT */
  static Future<Map<String, dynamic>> logout() async {

    try {

      final response = await http.post(

        Uri.parse('$baseUrl/logout.php'),

        headers: {
          'Content-Type':
          'application/x-www-form-urlencoded',
        },
      );

      final data = jsonDecode(response.body);

      return data;

    } catch (e) {

      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }
}