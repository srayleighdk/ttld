import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:ttld/models/ngoai_ngu_model.dart';

import '../../../repositories/ngoai_ngu/ngoai_ngu_repository.dart';

part 'ngoai_ngu_state.dart';

@injectable
class NgoaiNguCubit extends Cubit<NgoaiNguState> {
  final NgoaiNguRepository _repository;

  NgoaiNguCubit(this._repository) : super(NgoaiNguInitial());

  Future<void> getNgoaiNgu() async {
    emit(NgoaiNguLoading());
    try {
      final response = await _repository.getNgoaiNgus();
      emit(NgoaiNguLoaded(response));
    } on DioException catch (e) {
      emit(NgoaiNguError(e.message ?? 'Có lỗi xảy ra'));
    } catch (e) {
      emit(NgoaiNguError('Có lỗi xảy ra'));
    }
  }
}
