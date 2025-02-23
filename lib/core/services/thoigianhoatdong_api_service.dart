import 'package:dio/dio.dart';
import 'package:ttld/models/thoigian_hoatdong.dart';

class ThoiGianHoatDongApiService {
  final Dio _dio;

  ThoiGianHoatDongApiService(this._dio);

  Future<List<ThoiGianLamViec>> getThoiGianHoatDongList() async {
    const String apiUrl = '/api/common/tg-hd';
    final response = await _dio.get(apiUrl);

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data as List<dynamic>;
      return data.map((json) => ThoiGianLamViec.fromJson(json)).toList();
    } else {
      throw Exception(
          'Failed to load ThoiGianHoatDong: ${response.statusCode}');
    }
  }
}
