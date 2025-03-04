import 'package:ttld/models/m01tt11_model.dart';

abstract class M01TT11Repository {
  Future<List<M01TT11>> getAllM01TT11();
  Future<M01TT11> createM01TT11(M01TT11 m01tt11);
  Future<M01TT11> updateM01TT11(String id, M01TT11 m01tt11);
  Future<void> deleteM01TT11(String id);
}
