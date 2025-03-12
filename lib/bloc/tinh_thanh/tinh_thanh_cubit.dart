import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ttld/core/services/tinh_thanh_api_service.dart';
import 'package:ttld/models/tinh_thanh_model.dart';

part 'tinh_thanh_state.dart';

class TinhThanhCubit extends Cubit<TinhThanhState> {
  final TinhThanhApiService tinhThanhApiService;

  TinhThanhCubit({required this.tinhThanhApiService})
      : super(TinhThanhInitial());

  Future<List<TinhThanhModel>> loadTinhThanhs() async {
    emit(TinhThanhLoading());
    try {
      final response = await tinhThanhApiService.getTinhThanh();
      final List<TinhThanhModel> tinhThanhs = (response.data['data'] as List)
          .map((json) => TinhThanhModel.fromJson(json))
          .toList();
      emit(TinhThanhLoaded(tinhThanhs: tinhThanhs));
      return tinhThanhs;
    } catch (e) {
      emit(TinhThanhError(message: e.toString()));
      return [];
    }
  }
}
