import 'package:ttld/core/models/paginated_reponse.dart';
import 'package:ttld/features/ds-ld/models/ld.dart';

abstract class LdRepository {
  Future<LdModel> getLd(String id);
  Future<PaginatedResponse<LdModel>> getLds({
    required int page,
    required int limit,
    Map<String, dynamic>? filters,
    });
  Future<void> createLd(LdModel ld);
  Future<void> updateLd(LdModel ld);
  Future<void> deleteLd(String id);
}
