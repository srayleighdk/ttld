import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api_client.dart';
import '../../../models/ngoai_ngu_model.dart';
import '../../../repositories/ngoai_ngu/ngoai_ngu_repository.dart';

part 'ngoai_ngu_state.dart';

@injectable
class NgoaiNguCubit extends Cubit<NgoaiNguState> {
  final NgoaiNguRepository _repository;
  
  NgoaiNguCubit(this._repository) : super(NgoaiNguInitial());

  Future<void> getNgoaiNgu() async {
    emit(NgoaiNguLoading());
    try {
      final response = await _repository.getNgoaiNgu();
      emit(NgoaiNguLoaded(response));
    } on ApiException catch (e) {
      emit(NgoaiNguError(e.message));
    } catch (e) {
      emit(const NgoaiNguError('Có lỗi xảy ra'));
    }
  }
}
