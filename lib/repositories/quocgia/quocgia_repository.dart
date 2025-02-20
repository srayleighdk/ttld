import 'package:ttld/core/services/quocgia_api_service.dart';
import 'package:ttld/models/quocgia/quocgia_model.dart';

abstract class QuocGiaRepository {
  Future<List<QuocGia>> getQuocGias();
  Future<QuocGia> addQuocGia(QuocGia quocGia);
  Future<QuocGia> updateQuocGia(QuocGia quocGia);
  Future<void> deleteQuocGia(String id);
}

class QuocGiaRepositoryImpl implements QuocGiaRepository {
  final QuocGiaApiService quocGiaApiService;

  QuocGiaRepositoryImpl({required this.quocGiaApiService});

  @override
  Future<List<QuocGia>> getQuocGias() async {
    final response = await quocGiaApiService.getQuocGia();
    return (response.data['data'] as List)
        .map((json) => QuocGia.fromJson(json))
        .toList();
  }

  @override
  Future<QuocGia> addQuocGia(QuocGia quocGia) async {
    final response = await quocGiaApiService.postQuocGia(quocGia.toJson());
    return QuocGia.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<QuocGia> updateQuocGia(QuocGia quocGia) async {
    final response = await quocGiaApiService.putQuocGia(quocGia.toJson());
    return QuocGia.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteQuocGia(String id) async {
    await quocGiaApiService.deleteQuocGia(id);
  }
}
