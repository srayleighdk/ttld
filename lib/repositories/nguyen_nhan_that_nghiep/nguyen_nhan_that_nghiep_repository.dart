import 'package:ttld/core/services/nguyen_nhan_that_nghiep_api_service.dart';
import 'package:ttld/models/nguyen_nhan_that_nghiep_model.dart';

abstract class NguyenNhanThatNghiepRepository {
  Future<List<NguyenNhanThatNghiep>> getNguyenNhanThatNghieps();
}

class NguyenNhanThatNghiepRepositoryImpl implements NguyenNhanThatNghiepRepository {
  final NguyenNhanThatNghiepApiService apiService;

  NguyenNhanThatNghiepRepositoryImpl({required this.apiService});

  @override
  Future<List<NguyenNhanThatNghiep>> getNguyenNhanThatNghieps() async {
    final response = await apiService.getNguyenNhanThatNghieps();
    return (response.data['data'] as List)
        .map((json) => NguyenNhanThatNghiep.fromJson(json))
        .toList();
  }
}
