import 'package:dio/dio.dart';
import 'package:ttld/models/ntd_tuyendung/ntd_tuyendung_model.dart';
import 'package:ttld/services/tuyendung_service.dart';

class TuyenDungRepository {
  final TuyenDungApiService _tuyenDungService;

  TuyenDungRepository(this._tuyenDungService);

  Future<List<NTDTuyenDung>> getTuyenDungList(String? ntdId) async {
    try {
      final response = await _tuyenDungService.getTuyenDungList(ntdId);
      return (response.data['data'] as List)
          .map((json) => NTDTuyenDung.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception('Failed to get tuyen dung list: ${e.message}');
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
