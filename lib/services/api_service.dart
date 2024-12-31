import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://admin.fitglide.in/api';

static Future<Map<String, dynamic>> login(String email, String password) async {
  final url = Uri.parse('$baseUrl/auth/local?populate=*');
  final headers = {
    'Content-Type': 'application/json',
  };
  final body = jsonEncode({
    'identifier': email.trim(),
    'password': password.trim(),
  });

  if (kDebugMode) {
    print('Request Body: $body');
  } // Log the request body

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (kDebugMode) {
      print('Response Status Code: ${response.statusCode}');
    }
    if (kDebugMode) {
      print('Response Body: ${response.body}');
    }

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('API Error: ${response.statusCode} - ${response.body}');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Exception: $e');
    }
    rethrow;
  }
}


}