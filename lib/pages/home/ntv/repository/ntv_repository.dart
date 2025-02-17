import 'package:dio/dio.dart';
import 'package:ttld/pages/home/ntv/model/ntv_model.dart';

class NTVRepository {
  final Dio dio = Dio();

  Future<bool> createUser(Ntv ntv) async {
    try {
      final response =
          await dio.post("https://api.example.com/users", data: ntv.toJson());
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUser(Ntv ntv) async {
    try {
      final response = await dio.put("https://api.example.com/users/${ntv.id}",
          data: ntv.toJson());
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
