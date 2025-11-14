import 'package:dio/dio.dart';
import 'package:ttld/models/ntd_tuyendung/ntd_tuyendung_model.dart';
import 'package:ttld/services/tuyendung_service.dart';

class TuyenDungRepository {
  final TuyenDungApiService _tuyenDungService;

  TuyenDungRepository(this._tuyenDungService);

  // Future<List<NTDTuyenDung>> getTuyenDungList(String? ntdId) async {
  //   try {
  //     final response = await _tuyenDungService.getTuyenDungList(ntdId);
  //     return (response.data['data'] as List)
  //         .map((json) => NTDTuyenDung.fromJson(json))
  //         .toList();
  //   } on DioException catch (e) {
  //     throw Exception('Failed to get tuyen dung list: ${e.message}');
  //   }
  // }

//NOTE: This is for testing waring
  Future<Map<String, dynamic>> getTuyenDungList(
    String? ntdId, {
    String? idUv,
    int? limit,
    int? page,
    String? search,
    String? status,
    String? duyet,
    String? id,
  }) async {
    try {
      final response = await _tuyenDungService.getTuyenDungList(
        ntdId,
        idUv: idUv,
        limit: limit,
        page: page,
        search: search,
        status: status,
        duyet: duyet,
        id: id,
      );
      
      final data = response.data['data'] as List;
      final tuyenDungList = <NTDTuyenDung>[];

      for (var i = 0; i < data.length; i++) {
        try {
          final json = data[i] as Map<String, dynamic>;
          final item = NTDTuyenDung.fromJson(json);
          tuyenDungList.add(item);
        } catch (e) {
          print('Error parsing tuyendung item at index $i: $e');
          print('JSON data: ${data[i]}');
          rethrow;
        }
      }

      // Handle both string and int types from API
      int parseIntSafely(dynamic value, int defaultValue) {
        if (value == null) return defaultValue;
        if (value is int) return value;
        if (value is String) return int.tryParse(value) ?? defaultValue;
        return defaultValue;
      }

      // Backend returns: page, limit, total, totalQuery
      // Convert to: currentPage, limit, totalItems, totalPages
      final currentPage = parseIntSafely(response.data['page'], page ?? 1);
      final limitValue = parseIntSafely(response.data['limit'], limit ?? 10);
      final totalItems = parseIntSafely(response.data['totalQuery'], tuyenDungList.length);
      final totalPages = limitValue > 0 ? (totalItems / limitValue).ceil() : 1;

      return {
        'data': tuyenDungList,
        'pagination': {
          'currentPage': currentPage,
          'totalPages': totalPages,
          'totalItems': totalItems,
          'limit': limitValue,
        }
      };
    } on DioException catch (e) {
      throw Exception('Failed to get tuyen dung list: ${e.message}');
    } catch (e) {
      rethrow;
    }
  }

  Future<NTDTuyenDung> createTuyenDung(NTDTuyenDung tuyenDung) async {
    try {
      final response = await _tuyenDungService.createTuyenDung(tuyenDung);
      return NTDTuyenDung.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to create tuyen dung: ${e.message}');
    }
  }

  Future<NTDTuyenDung> updateTuyenDung(NTDTuyenDung tuyenDung) async {
    try {
      final response = await _tuyenDungService.updateTuyenDung(tuyenDung);
      return NTDTuyenDung.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to update tuyen dung: ${e.message}');
    }
  }

  Future<void> deleteTuyenDung(String idTuyenDung) async {
    try {
      await _tuyenDungService.deleteTuyenDung(idTuyenDung);
    } on DioException catch (e) {
      throw Exception('Failed to delete tuyen dung: ${e.message}');
    }
  }
}
