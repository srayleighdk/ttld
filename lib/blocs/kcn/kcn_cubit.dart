import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/core/services/danhmuc_kcn_api_service.dart';
import 'package:ttld/models/kcn/kcn_model.dart';

part 'kcn_state.dart';

class KcnCubit extends Cubit<KcnState> {
  final DanhMucKcnApiService _danhmucApiService;

  KcnCubit(this._danhmucApiService) : super(KcnInitial());

  Future<void> getKCN(String matinh) async {
    emit(KcnLoading());
    try {
      final response = await _danhmucApiService.getKCN(matinh);
      final List<dynamic> data = response.data['data'];
      final List<KCNModel> kcnList =
          data.map((json) => KCNModel.fromJson(json)).toList();
      emit(KcnLoaded(kcnList));
    } catch (e) {
      emit(KcnError(e.toString()));
    }
  }
}
