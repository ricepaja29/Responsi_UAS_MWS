import 'dart:convert';
import 'package:http/http.dart' as http;

class MotorService {
  final String apiUrl = 'http://192.168.137.140:8000/api/motors'; // Ganti dengan URL API Anda

  // Ambil semua motor
  Future<List<Map<String, dynamic>>> getMotors() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      try {
        // Decode response body
        final data = json.decode(response.body);

        // Pastikan data adalah list atau akses ke properti yang benar
        if (data is Map<String, dynamic> && data.containsKey('data')) {
          return List<Map<String, dynamic>>.from(data['data']);
        } else if (data is List) {
          return List<Map<String, dynamic>>.from(data);
        } else {
          throw Exception('Format data tidak sesuai');
        }
      } catch (e) {
        throw Exception('Error parsing data: $e');
      }
    } else {
      throw Exception('Failed to load motors (Status Code: ${response.statusCode})');
    }
  }

  // Tambah motor
  Future<void> addMotor(Map<String, dynamic> motor) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(motor),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add motor (Status Code: ${response.statusCode})');
    }
  }

  // Edit motor
  Future<void> editMotor(int id, Map<String, dynamic> updatedMotor) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedMotor),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update motor (Status Code: ${response.statusCode})');
    }
  }

  // Hapus motor
  Future<void> deleteMotor(int id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete motor (Status Code: ${response.statusCode})');
    }
  }
}
