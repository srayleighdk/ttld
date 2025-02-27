import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:your_app_name/models/muc_luong_mm.dart'; // Replace with your actual import

class MucLuongApiService {
  final String baseUrl = 'your_base_url'; // Replace with your actual base URL

  Future<List<MucLuongMM>> getMucLuongs() async {
    final response = await http.get(Uri.parse('$baseUrl/api/bo-sung/muc-luong'));

    if (response.statusCode == 200) {
      final List<dynamic> mucLuongsJson = jsonDecode(response.body);
      return mucLuongsJson.map((json) => MucLuongMM.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load MucLuongMM: ${response.statusCode}');
    }
  }

  Future<MucLuongMM> createMucLuong(MucLuongMM mucLuong) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/bo-sung/muc-luong'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(mucLuong.toJson()),
    );

    if (response.statusCode == 201) {
      return MucLuongMM.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create MucLuongMM: ${response.statusCode}');
    }
  }

  Future<MucLuongMM> updateMucLuong(MucLuongMM mucLuong) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/bo-sung/muc-luong'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(mucLuong.toJson()),
    );

    if (response.statusCode == 200) {
      return MucLuongMM.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update MucLuongMM: ${response.statusCode}');
    }
  }

  Future<void> deleteMucLuong(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/bo-sung/muc-luong?id=$id'),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete MucLuongMM: ${response.statusCode}');
    }
  }
}
