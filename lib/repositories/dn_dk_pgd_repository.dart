import 'package:ttld/core/services/dn_dk_pgd_service.dart';
import 'package:ttld/models/dn_dk_pgd/dn_dk_pgd_model.dart';
import 'package:ttld/models/api_response_list.dart';
import 'package:ttld/models/api_response_object.dart';

class DnDkPgdRepository {
  final DnDkPgdService _service;

  DnDkPgdRepository(this._service);

  Future<ApiResponseList<DnDkPgd>> getDnDkPgdList() async {
    return await _service.getDnDkPgdList();
  }

  Future<ApiResponseObject<DnDkPgd>> createDnDkPgd(DnDkPgd dnDkPgd) async {
    return await _service.createDnDkPgd(dnDkPgd);
  }

  Future<ApiResponseObject<DnDkPgd>> updateDnDkPgd(DnDkPgd dnDkPgd) async {
    return await _service.updateDnDkPgd(dnDkPgd);
  }

  Future<ApiResponseObject<bool>> deleteDnDkPgd(String id) async {
    return await _service.deleteDnDkPgd(id);
  }
}
