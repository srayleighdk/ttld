import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/models/ngoai_ngu_model.dart';

abstract class NgoaiNguRepository {
  Future<List<NgoaiNgu>> getNgoaiNgus();
}

@Injectable(as: NgoaiNguRepository)
class NgoaiNguRepositoryImpl implements NgoaiNguRepository {
  final ApiClient _client;

  NgoaiNguRepositoryImpl(this._client);

  @override
  Future<List<NgoaiNgu>> getNgoaiNgus() async {
    try {
      final response = await _client.get(
        '/common/td-nn',
        queryParameters: {'pageSize': 1000},
      );
      return (response.data['result'] as List)
          .map((json) => NgoaiNgu.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception('Lỗi khi tải danh sách ngoại ngữ: ${e.message}');
    } catch (e) {
      throw Exception('Lỗi không xác định khi tải danh sách ngoại ngữ: $e');
    }
  }
}
