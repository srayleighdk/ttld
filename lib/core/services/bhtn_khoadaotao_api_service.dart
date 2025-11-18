import 'package:dio/dio.dart';
import 'package:ttld/core/constants/api_endpoints.dart';
import 'package:ttld/models/bhtn_khoadaotao/bhtn_khoadaotao_model.dart';

class BhtnKhoadaotaoApiService {
  BhtnKhoadaotaoApiService(this.dio);

  final Dio dio;

  Future<List<BhtnKhoadaotao>> getBhtnKhoadaotaos() async {
    try {
      final response = await dio.get(ApiEndpoints.bhtnKhoadaotao);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => BhtnKhoadaotao.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load BHTN khóa đào tạo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load BHTN khóa đào tạo: $e');
    }
  }

  Future<BhtnKhoadaotao> getBhtnKhoadaotaoById(int id) async {
    try {
      final response = await dio.get('${ApiEndpoints.bhtnKhoadaotao}/$id');
      if (response.statusCode == 200) {
        return BhtnKhoadaotao.fromJson(response.data['data']);
      } else {
        throw Exception(
            'Failed to load BHTN khóa đào tạo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load BHTN khóa đào tạo: $e');
    }
  }

  Future<BhtnKhoadaotao> createBhtnKhoadaotao(BhtnKhoadaotao khoadaotao) async {
    try {
      final response = await dio.post(
        ApiEndpoints.bhtnKhoadaotao,
        data: khoadaotao.toJson(),
      );
      if (response.statusCode == 201) {
        return BhtnKhoadaotao.fromJson(response.data['data']);
      } else {
        throw Exception(
            'Failed to create BHTN khóa đào tạo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create BHTN khóa đào tạo: $e');
    }
  }

  Future<BhtnKhoadaotao> updateBhtnKhoadaotao(
      int id, BhtnKhoadaotao khoadaotao) async {
    try {
      final response = await dio.put(
        '${ApiEndpoints.bhtnKhoadaotao}/$id',
        data: khoadaotao.toJson(),
      );
      if (response.statusCode == 200) {
        return BhtnKhoadaotao.fromJson(response.data['data']);
      } else {
        throw Exception(
            'Failed to update BHTN khóa đào tạo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update BHTN khóa đào tạo: $e');
    }
  }

  Future<void> deleteBhtnKhoadaotao(int id) async {
    try {
      final response = await dio.delete('${ApiEndpoints.bhtnKhoadaotao}/$id');
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception(
            'Failed to delete BHTN khóa đào tạo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete BHTN khóa đào tạo: $e');
    }
  }
}
