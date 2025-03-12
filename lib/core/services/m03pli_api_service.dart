import 'package:dio/dio.dart';
import 'package:ttld/models/m03pli_model.dart';

class M03PLIApiService {
  final Dio _dio;

  M03PLIApiService(this._dio);

  Future<List<M03PLIModel>> getM03PLIs() async {
    try {
      final response = await _dio.get('/tttt/m03pli');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => M03PLIModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load M03PLIs');
      }
    } catch (e) {
      throw Exception('Failed to load M03PLIs: $e');
    }
  }

  Future<M03PLIModel> createM03PLI(M03PLIModel m03pli) async {
    try {
      final response = await _dio.post('/tttt/m03pli', data: m03pli.toJson());
      if (response.statusCode == 201) {
        return M03PLIModel.fromJson(response.data);
      } else {
        throw Exception('Failed to create M03PLI');
      }
    } catch (e) {
      throw Exception('Failed to create M03PLI: $e');
    }
  }

  Future<M03PLIModel> updateM03PLI(M03PLIModel m03pli) async {
    try {
      final response = await _dio.put('/tttt/m03pli', data: m03pli.toJson());
      if (response.statusCode == 200) {
        return M03PLIModel.fromJson(response.data);
      } else {
        throw Exception('Failed to update M03PLI');
      }
    } catch (e) {
      throw Exception('Failed to update M03PLI: $e');
    }
  }

  Future<void> deleteM03PLI(String id) async {
    try {
      final response =
          await _dio.delete('/tttt/m03pli', queryParameters: {'id': id});
      if (response.statusCode != 204) {
        throw Exception('Failed to delete M03PLI');
      }
    } catch (e) {
      throw Exception('Failed to delete M03PLI: $e');
    }
  }
}
