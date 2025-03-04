import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ttld/models/m01tt11_model.dart';

class M01TT11ApiService {
  final String baseUrl;

  M01TT11ApiService({required this.baseUrl});

  Future<List<M01TT11>> getAllM01TT11() async {
    final response = await http.get(Uri.parse('$baseUrl/api/tttt/nhucautd-01tt11'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => M01TT11.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load M01TT11: ${response.statusCode}');
    }
  }

  Future<M01TT11> createM01TT11(M01TT11 m01tt11) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/tttt/nhucautd-01tt11'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(m01tt11.toJson()),
    );

    if (response.statusCode == 201) {
      return M01TT11.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create M01TT11: ${response.statusCode}');
    }
  }

  Future<M01TT11> updateM01TT11(String id, M01TT11 m01tt11) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/tttt/nhucautd-01tt11/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(m01tt11.toJson()),
    );

    if (response.statusCode == 200) {
      return M01TT11.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update M01TT11: ${response.statusCode}');
    }
  }

  Future<void> deleteM01TT11(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/api/tttt/nhucautd-01tt11/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete M01TT11: ${response.statusCode}');
    }
  }
}
