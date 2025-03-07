import 'package:injectable/injectable.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/models/ngoai_ngu_model.dart';

abstract class NgoaiNguRepository {
  Future<List<NgoaiNgu>> getNgoaiNgu();
}

@Injectable(as: NgoaiNguRepository)
class NgoaiNguRepositoryImpl implements NgoaiNguRepository {
  final ApiClient _client;

  NgoaiNguRepositoryImpl(this._client);

  @override
  Future<List<NgoaiNgu>> getNgoaiNgu() async {
    try {
      final response = await _client.get(
        '/api/common/td-nn',
        queryParameters: {'pageSize': 1000},
      );
      return (response.data['result'] as List)
          .map((json) => NgoaiNgu.fromJson(json))
          .toList();
    } catch (e) {
      throw ApiException(message: 'Lỗi khi tải danh sách ngoại ngữ');
    }
  }
}
