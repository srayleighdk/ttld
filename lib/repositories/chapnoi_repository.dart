import '../models/chapnoi/chapnoi_model.dart';
import '../models/api_response_list.dart';
import '../models/api_response_object.dart';
import '../services/chapnoi_api_service.dart';

class ChapNoiRepository {
  final ChapNoiApiService _apiService;

  ChapNoiRepository(this._apiService);

  Future<ApiResponseList<ChapNoiModel>> getChapNoiList({
    required int limit,
    required int page,
    int? status,
    String? idTuyenDung,
    String? idDoanhNghiep,
  }) async {
    try {
      return await _apiService.getChapNoiList(
        limit: limit,
        page: page,
        status: status,
        idTuyenDung: idTuyenDung,
        idDoanhNghiep: idDoanhNghiep,
      );
    } catch (e) {
      // Log error or handle specific exceptions if needed
      print('Error in ChapNoiRepository getChapNoiList: $e');
      // Re-throw a more specific or user-friendly error if desired
      throw Exception('Failed to fetch ChapNoi data: ${e.toString()}');
    }
  }

   Future<ApiResponseObject<ChapNoiModel>> createChapNoi(ChapNoiModel chapNoi) async {
    try {
      return await _apiService.createChapNoi(chapNoi);
    } catch (e) {
      print('Error in ChapNoiRepository createChapNoi: $e');
      throw Exception('Failed to create ChapNoi: ${e.toString()}');
    }
  }
}
