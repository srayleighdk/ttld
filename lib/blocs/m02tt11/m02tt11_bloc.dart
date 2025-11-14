import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/m02tt11/m02tt11_model.dart';
import 'package:ttld/core/services/m02tt11_api_service.dart';

part 'm02tt11_event.dart';
part 'm02tt11_state.dart';

class M02TT11Bloc extends Bloc<M02TT11Event, M02TT11State> {
  final M02TT11ApiService apiService;

  M02TT11Bloc({required this.apiService}) : super(M02TT11Initial()) {
    on<LoadM02TT11List>(_onLoadM02TT11List);
    on<LoadM02TT11ById>(_onLoadM02TT11ById);
    on<CreateM02TT11>(_onCreateM02TT11);
    on<UpdateM02TT11>(_onUpdateM02TT11);
    on<DeleteM02TT11>(_onDeleteM02TT11);
  }

  Future<void> _onLoadM02TT11List(
      LoadM02TT11List event, Emitter<M02TT11State> emit) async {
    emit(M02TT11Loading());
    try {
      final items = await apiService.getM02TT11List(event.userId);
      emit(M02TT11ListLoaded(items: items));
    } catch (e) {
      emit(M02TT11Error(message: e.toString()));
    }
  }

  Future<void> _onLoadM02TT11ById(
      LoadM02TT11ById event, Emitter<M02TT11State> emit) async {
    emit(M02TT11Loading());
    try {
      final item = await apiService.getM02TT11ById(event.id);
      emit(M02TT11SingleLoaded(item: item));
    } catch (e) {
      emit(M02TT11Error(message: e.toString()));
    }
  }

  Future<void> _onCreateM02TT11(
      CreateM02TT11 event, Emitter<M02TT11State> emit) async {
    emit(M02TT11Loading());
    try {
      await apiService.createM02TT11(event.data);
      emit(M02TT11OperationSuccess(
          message: 'Đăng ký tìm việc làm thành công!'));
    } catch (e) {
      emit(M02TT11Error(message: 'Đăng ký thất bại: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateM02TT11(
      UpdateM02TT11 event, Emitter<M02TT11State> emit) async {
    emit(M02TT11Loading());
    try {
      await apiService.updateM02TT11(event.id, event.data);
      emit(M02TT11OperationSuccess(
          message: 'Cập nhật đăng ký thành công!'));
    } catch (e) {
      emit(M02TT11Error(message: 'Cập nhật thất bại: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteM02TT11(
      DeleteM02TT11 event, Emitter<M02TT11State> emit) async {
    emit(M02TT11Loading());
    try {
      await apiService.deleteM02TT11(event.id);
      emit(M02TT11OperationSuccess(message: 'Xóa đăng ký thành công!'));
    } catch (e) {
      emit(M02TT11Error(message: 'Xóa thất bại: ${e.toString()}'));
    }
  }
}
