import 'package:dio/dio.dart';
import 'package:ttld/models/ntd_tuyendung/ntd_tuyendung_model.dart';

class TuyenDungApiService {
  final Dio _dio;

  TuyenDungApiService(this._dio);

  Future<Response> getTuyenDungList(String? ntdId) async {
    // return _dio
    //     .get('/nghiep-vu/tuyendung', queryParameters: {'idDoanhNghiep': ntdId});
    try {
      final response = await _dio.get(
        '/nghiep-vu/tuyendung',
        queryParameters: {'idDoanhNghiep': ntdId},
      );
      // Decode the response body to handle UTF-8 issues
      // String decodedBody =
      //     utf8.decode(response.data.toString().codeUnits, allowMalformed: true);
      // response.data =
      //     jsonDecode(decodedBody); // Replace raw data with decoded JSON
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to fetch tuyen dung: ${e.message}');
    }
  }

  Future<Response> createTuyenDung(NTDTuyenDung tuyenDung) async {
    return _dio.post('/nghiep-vu/tuyendung', data: tuyenDung.toJson());
  }

  Future<Response> updateTuyenDung(NTDTuyenDung tuyenDung) async {
    return _dio.put('/nghiep-vu/tuyendung', data: tuyenDung.toJson());
  }

  Future<Response> deleteTuyenDung(String idTuyenDung) async {
    return _dio.delete(
      '/nghiep-vu/tuyendung',
      queryParameters: {'id': idTuyenDung},
      options: Options(
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );
  }
}
