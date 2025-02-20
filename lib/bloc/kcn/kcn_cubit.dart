import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ttld/core/services/danhmuc_api_service.dart';

part 'kcn_state.dart';

class KcnCubit extends Cubit<KcnState> {
  final DanhMucApiService _danhmucApiService;

  KcnCubit(this._danhmucApiService) : super(KcnInitial());

  Future<void> getKCN(String matinh) async {
    emit(KcnLoading());
    try {
      final response = await _danhmucApiService.getKCN(matinh);
      emit(KcnLoaded(response.data));
    } catch (e) {
      emit(KcnError(e.toString()));
    }
  }
}
