import 'package:dio/dio.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/core/constants/api_endpoints.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';

class NTDApiService {
  final Dio _dio = ApiClient().dio;

  Future<List<Ntd>> getNtdList({
    int? limit,
    int? page,
    int? ntdLoai,
    int? idStatus,
    String? search,
    int? idUv,
  }) async {
    try {
      final response = await _dio.get(ApiEndpoints.ntd, queryParameters: {
        if (limit != null) 'limit': limit,
        if (page != null) 'page': page,
        if (ntdLoai != null) 'ntdLoai': ntdLoai,
        if (idStatus != null) 'idStatus': idStatus,
        if (search != null) 'search': search,
        if (idUv != null) 'idUv': idUv,
      });
      List<Ntd> ntdList = (response.data["data"] as List)
          .map((json) => Ntd.fromJson(json))
          .toList();
      return ntdList;
    } catch (e) {
      throw Exception('Failed to fetch NTD list: $e');
    }
  }

  Future<Ntd> getNtdById(String id) async {
    try {
      print('Fetching NTD with ID: $id');
      final response =
          await _dio.get(ApiEndpoints.ntdById, queryParameters: {'id': id});
      print('API Response: ${response.data}');
      if (response.data == null || response.data['data'] == null) {
        throw Exception('Invalid API response format');
      }
      final Ntd ntd = Ntd.fromJson(response.data["data"]);
      return ntd;
    } catch (e) {
      print('Error in getNtdById: $e');
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
      final response = await _dio.put(ApiEndpoints.ntd,
          data: ntd.toJson(), queryParameters: {'id': ntd.idDoanhNghiep});
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
