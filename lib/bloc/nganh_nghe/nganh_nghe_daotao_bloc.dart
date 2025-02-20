import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/nganh_nghe_daotao.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_daotao_repository.dart';

part 'nganh_nghe_daotao_event.dart';
part 'nganh_nghe_daotao_state.dart';

class NganhNgheDaoTaoBloc extends Bloc<NganhNgheDaoTaoEvent, NganhNgheDaoTaoState> {
  final NganhNgheDaoTaoRepository nganhNgheDaoTaoRepository;

  NganhNgheDaoTaoBloc({required this.nganhNgheDaoTaoRepository}) : super(NganhNgheDaoTaoInitial()) {
    on<LoadNganhNgheDaoTaos>(_onLoadNganhNgheDaoTaos);
    on<AddNganhNgheDaoTao>(_onAddNganhNgheDaoTao);
    on<UpdateNganhNgheDaoTao>(_onUpdateNganhNgheDaoTao);
    on<DeleteNganhNgheDaoTao>(_onDeleteNganhNgheDaoTao);
  }

  Future<void> _onLoadNganhNgheDaoTaos(LoadNganhNgheDaoTaos event, Emitter<NganhNgheDaoTaoState> emit) async {
    emit(NganhNgheDaoTaoLoading());
    try {
      final nganhNgheDaoTaos = await nganhNgheDaoTaoRepository.getNganhNgheDaoTaos();
      emit(NganhNgheDaoTaoLoaded(nganhNgheDaoTaos: nganhNgheDaoTaos));
    } catch (e) {
      emit(NganhNgheDaoTaoError(message: e.toString()));
    }
  }

  Future<void> _onAddNganhNgheDaoTao(AddNganhNgheDaoTao event, Emitter<NganhNgheDaoTaoState> emit) async {
    try {
      final nganhNgheDaoTao = await nganhNgheDaoTaoRepository.addNganhNgheDaoTao(event.nganhNgheDaoTao);
      if (state is NganhNgheDaoTaoLoaded) {
        final updatedNganhNgheDaoTaos = List<NganhNgheDaoTao>.from((state as NganhNgheDaoTaoLoaded).nganhNgheDaoTaos)..add(nganhNgheDaoTao);
        emit(NganhNgheDaoTaoLoaded(nganhNgheDaoTaos: updatedNganhNgheDaoTaos));
      }
    } catch (e) {
      emit(NganhNgheDaoTaoError(message: e.toString()));
    }
  }

  Future<void> _onUpdateNganhNgheDaoTao(UpdateNganhNgheDaoTao event, Emitter<NganhNgheDaoTaoState> emit) async {
    try {
      final nganhNgheDaoTao = await nganhNgheDaoTaoRepository.updateNganhNgheDaoTao(event.nganhNgheDaoTao);
      if (state is NganhNgheDaoTaoLoaded) {
        final updatedNganhNgheDaoTaos = (state as NganhNgheDaoTaoLoaded).nganhNgheDaoTaos.map((q) => q.nnTen == nganhNgheDaoTao.nnTen ? nganhNgheDaoTao : q).toList();
        emit(NganhNgheDaoTaoLoaded(nganhNgheDaoTaos: updatedNganhNgheDaoTaos));
      }
    } catch (e) {
      emit(NganhNgheDaoTaoError(message: e.toString()));
    }
  }

  Future<void> _onDeleteNganhNgheDaoTao(DeleteNganhNgheDaoTao event, Emitter<NganhNgheDaoTaoState> emit) async {
    try {
      await nganhNgheDaoTaoRepository.deleteNganhNgheDaoTao(event.nnTen);
      if (state is NganhNgheDaoTaoLoaded) {
        final updatedNganhNgheDaoTaos = (state as NganhNgheDaoTaoLoaded).nganhNgheDaoTaos.where((q) => q.nnTen != event.nnTen).toList();
        emit(NganhNgheDaoTaoLoaded(nganhNgheDaoTaos: updatedNganhNgheDaoTaos));
      }
    } catch (e) {
      emit(NganhNgheDaoTaoError(message: e.toString()));
    }
  }
}
