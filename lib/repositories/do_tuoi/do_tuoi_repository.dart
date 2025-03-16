import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/models/do_tuoi_model.dart';

abstract class DoTuoiRepository {
  Future<List<DoTuoi>> getDoTuois();
}

@Injectable(as: DoTuoiRepository)
class DoTuoiRepositoryImpl implements DoTuoiRepository {
  final ApiClient _client;

  DoTuoiRepositoryImpl(this._client);

  @override
  Future<List<DoTuoi>> getDoTuois() async {
    try {
      final response = await _client.get(
        '/common/do-tuoi',
        queryParameters: {'pageSize': 1000},
      );
      return (response.data['data'] as List)
          .map((json) => DoTuoi.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception('Lỗi khi tải danh sách độ tuổi: ${e.message}');
    } catch (e) {
      throw Exception('Lỗi không xác định khi tải danh sách độ tuổi: $e');
    }
  }
}
