import '../models/chinhsachluong/chinhsachluong_model.dart';
import '../services/chinhsachluong_api_service.dart';

class ChinhSachLuongRepository {
  final ChinhSachLuongApiService _apiService;

  ChinhSachLuongRepository(this._apiService);

  Future<List<ChinhSachLuong>> fetchChinhSachLuongs() async {
    return await _apiService.getChinhSachLuongs();
  }

  Future<ChinhSachLuong> createChinhSachLuong(ChinhSachLuong csl) async {
    return await _apiService.createChinhSachLuong(csl);
  }

  Future<ChinhSachLuong> updateChinhSachLuong(ChinhSachLuong csl) async {
    return await _apiService.updateChinhSachLuong(csl);
  }

  Future<void> deleteChinhSachLuong(int id) async {
    return await _apiService.deleteChinhSachLuong(id);
  }
}
