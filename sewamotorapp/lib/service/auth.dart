import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const secureStorage = FlutterSecureStorage();

const String baseUrl = 'http://192.168.1.101:8000/api';

Future<Map<String, String>> getDefaultHeaders() async {
  final accessToken = await secureStorage.read(key: 'access_token');
  return {
    'Content-Type': 'application/json',
    if (accessToken != null) 'Authorization': 'Bearer $accessToken',
  };
}

Future<void> login(String email, String password) async {
  final url = Uri.parse('$baseUrl/auth/login');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final accessToken = data['token']['access_token'];

      await secureStorage.write(key: 'access_token', value: accessToken);
      print('Access token successfully stored!');
    } else {
      final error = json.decode(response.body) as Map<String, dynamic>;
      throw Exception('Login failed: ${error['message'] ?? 'Server error'}');
    }
  } catch (e) {
    throw Exception('Login failed: $e');
  }
}

Future<void> register(String name, String email, String password) async {
  final url = Uri.parse('$baseUrl/auth/register');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      print('Registration successful! Please log in.');
    } else {
      final error = json.decode(response.body) as Map<String, dynamic>;
      throw Exception('Registration failed: ${error['message'] ?? 'Server error'}');
    }
  } catch (e) {
    throw Exception('Registration failed: $e');
  }
}

Future<Map<String, dynamic>> fetchProtectedData() async {
  final url = Uri.parse('$baseUrl/user/me');

  try {
    final response = await http.get(
      url,
      headers: await getDefaultHeaders(),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      print('Data retrieved successfully: $data');
      return data;
    } else if (response.statusCode == 401) {
      throw Exception('Invalid or expired access token. Please log in again.');
    } else {
      final error = json.decode(response.body) as Map<String, dynamic>;
      throw Exception('Error: ${error['message'] ?? 'Server error'}');
    }
  } catch (e) {
    throw Exception('An error occurred: $e');
  }
}

Future<void> logout() async {
  try {
    await secureStorage.delete(key: 'access_token');
    print('Access token successfully deleted.');
  } catch (e) {
    throw Exception('Logout failed: $e');
  }
}
