import 'package:dio/dio.dart';
import 'package:ttld/models/thoigian_hoatdong.dart';

class ThoiGianHoatDongApiService {
  final Dio _dio;

  ThoiGianHoatDongApiService(this._dio);

  Future<List<ThoiGianHoatDong>> getThoiGianHoatDongList() async {
    const String apiUrl = '/api/common/tg-hd';
    final response = await _dio.get(apiUrl);

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'];
      return data.map((json) => ThoiGianHoatDong.fromJson(json)).toList();
    } else {
      throw Exception(
          'Failed to load ThoiGianHoatDong: ${response.statusCode}');
    }
  }
}
