import 'package:dio/dio.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/core/constants/api_endpoints.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';

class NTDApiService {
  final Dio _dio = ApiClient().dio;

  Future<List<Ntd>> getNtdList() async {
    try {
      final response = await _dio.get(ApiEndpoints.ntd);
      List<Ntd> ntdList =
          (response.data as List).map((json) => Ntd.fromJson(json)).toList();
      return ntdList;
    } catch (e) {
      throw Exception('Failed to fetch NTD list: $e');
    }
  }

  Future<Ntd> getNtdById(String id) async {
    try {
      final response =
          await _dio.get(ApiEndpoints.ntdById, queryParameters: {'id': id});
      final Ntd ntd = Ntd.fromJson(response.data["data"]);
      print('response.data: ${response.data}');
      print('ntd: $ntd');
      return ntd;
    } catch (e) {
      throw Exception('Failed to fetch NTD by ID: $e');
    }
  }

  Future<Ntd> addNtd(Ntd ntd) async {
    try {
      final response = await _dio.post(ApiEndpoints.ntd, data: ntd.toJson());
      final Ntd addedNtd = Ntd.fromJson(response.data);
      return addedNtd;
    } catch (e) {
      throw Exception('Failed to add NTD: $e');
    }
  }

  Future<Ntd> updateNtd(Ntd ntd) async {
    try {
      final response = await _dio.put(ApiEndpoints.ntd, data: ntd.toJson());
      final Ntd updatedNtd = Ntd.fromJson(response.data);
      return updatedNtd;
    } catch (e) {
      throw Exception('Failed to update NTD: $e');
    }
  }

  Future<void> deleteNtd(int id) async {
    try {
      await _dio.delete('${ApiEndpoints.ntd}/$id');
    } catch (e) {
      throw Exception('Failed to delete NTD: $e');
    }
  }
}
