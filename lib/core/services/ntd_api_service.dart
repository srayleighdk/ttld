import 'package:dio/dio.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/core/constants/api_endpoints.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';

class NTDApiService {
  final Dio _dio = ApiClient().dio;

  Future<List<NtdModel>> getNtdList() async {
    try {
      final response = await _dio.get(ApiEndpoints.ntd);
      List<NtdModel> ntdList = (response.data as List)
          .map((json) => NtdModel.fromJson(json))
          .toList();
      return ntdList;
    } catch (e) {
      throw Exception('Failed to fetch NTD list: $e');
    }
  }

  Future<NtdModel> getNtdById(String id) async {
    try {
      final response = await _dio.get('${ApiEndpoints.ntdById.replaceAll(":id", id)}');
      final NtdModel ntd = NtdModel.fromJson(response.data);
      return ntd;
    } catch (e) {
      throw Exception('Failed to fetch NTD by ID: $e');
    }
  }

  Future<NtdModel> addNtd(NtdModel ntd) async {
    try {
      final response = await _dio.post(ApiEndpoints.ntd, data: ntd.toJson());
      final NtdModel addedNtd = NtdModel.fromJson(response.data);
      return addedNtd;
    } catch (e) {
      throw Exception('Failed to add NTD: $e');
    }
  }

  Future<NtdModel> updateNtd(NtdModel ntd) async {
    try {
      final response = await _dio.put(ApiEndpoints.ntd, data: ntd.toJson());
      final NtdModel updatedNtd = NtdModel.fromJson(response.data);
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
