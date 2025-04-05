import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:ttld/models/ky_nang_mem_model.dart';

part 'ky_nang_mem_api_service.g.dart';

@RestApi()
abstract class KyNangMemApiService {
  factory KyNangMemApiService(Dio dio, {String baseUrl}) = _KyNangMemApiService;

  @GET('/api/bo-sung/ky-nang')
  Future<List<KyNangMemModel>> getKyNangMems();

  @POST('/api/bo-sung/ky-nang')
  Future<KyNangMemModel> addKyNangMem(@Body() KyNangMemModel kyNangMem);

  @PUT('/api/bo-sung/ky-nang')
  Future<KyNangMemModel> updateKyNangMem(@Body() KyNangMemModel kyNangMem);

  // Assuming DELETE needs an ID, typically as a path parameter or query param.
  // Adjust if the API expects the ID differently (e.g., in the body).
  // Option 1: Path parameter (e.g., /api/bo-sung/ky-nang/{id})
  // @DELETE('/api/bo-sung/ky-nang/{id}')
  // Future<void> deleteKyNangMem(@Path('id') int id);

  // Option 2: Query parameter (e.g., /api/bo-sung/ky-nang?id=...)
  // @DELETE('/api/bo-sung/ky-nang')
  // Future<void> deleteKyNangMem(@Query('id') int id);

  // Option 3: ID in the body (less common for DELETE)
   @DELETE('/api/bo-sung/ky-nang')
   Future<void> deleteKyNangMem(@Body() Map<String, dynamic> body); // e.g., {'id': id}
}
