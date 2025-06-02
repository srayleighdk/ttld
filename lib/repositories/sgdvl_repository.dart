import 'package:ttld/core/services/sgdvl_api_service.dart';
import 'package:ttld/models/sgdvl/sgdvl_model.dart';

abstract class SGDVLRepository {
  Future<List<SGDVL>> getSGDVLs();
}

class SGDVLRepositoryImpl implements SGDVLRepository {
  SGDVLRepositoryImpl({required this.sgdvlApiService});
  final SGDVLApiService sgdvlApiService;

  @override
  Future<List<SGDVL>> getSGDVLs() async {
    return await sgdvlApiService.getSGDVLs();
  }
} 