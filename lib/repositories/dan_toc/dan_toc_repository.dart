import 'package:ttld/core/services/dan_toc_api_service.dart';
import 'package:ttld/models/dan_toc_model.dart';

abstract class DanTocRepository {
  Future<List<DanToc>> getDanTocs();
  Future<DanToc> addDanToc(DanToc danToc);
  Future<DanToc> updateDanToc(DanToc danToc);
  Future<void> deleteDanToc(String id);
}

class DanTocRepositoryImpl implements DanTocRepository {
  final DanTocApiService danTocApiService;

  DanTocRepositoryImpl({required this.danTocApiService});

  @override
  Future<List<DanToc>> getDanTocs() async {
    final response = await danTocApiService.getDanToc();
    return (response.data['data'] as List)
        .map((json) => DanToc.fromJson(json))
        .toList();
  }

  @override
  Future<DanToc> addDanToc(DanToc danToc) async {
    final response = await danTocApiService.postDanToc(danToc.toJson());
    return DanToc.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<DanToc> updateDanToc(DanToc danToc) async {
    final response = await danTocApiService.putDanToc(danToc.toJson());
    return DanToc.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteDanToc(String id) async {
    await danTocApiService.deleteDanToc(id);
  }
}
