import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/hinh_thuc_dao_tao_model.dart';
import 'package:ttld/repositories/hinh_thuc_dao_tao/hinh_thuc_dao_tao_repository.dart';

part 'hinh_thuc_dao_tao_event.dart';
part 'hinh_thuc_dao_tao_state.dart';

class HinhThucDaoTaoBloc extends Bloc<HinhThucDaoTaoEvent, HinhThucDaoTaoState> {
  final HinhThucDaoTaoRepository hinhThucDaoTaoRepository;

  HinhThucDaoTaoBloc({required this.hinhThucDaoTaoRepository}) : super(HinhThucDaoTaoInitial()) {
    on<LoadHinhThucDaoTaos>(_onLoadHinhThucDaoTaos);
    on<AddHinhThucDaoTao>(_onAddHinhThucDaoTao);
    on<UpdateHinhThucDaoTao>(_onUpdateHinhThucDaoTao);
    on<DeleteHinhThucDaoTao>(_onDeleteHinhThucDaoTao);
  }

  Future<void> _onLoadHinhThucDaoTaos(LoadHinhThucDaoTaos event, Emitter<HinhThucDaoTaoState> emit) async {
    emit(HinhThucDaoTaoLoading());
    try {
      final hinhThucDaoTaos = await hinhThucDaoTaoRepository.getHinhThucDaoTaos();
      emit(HinhThucDaoTaoLoaded(hinhThucDaoTaos: hinhThucDaoTaos));
    } catch (e) {
      emit(HinhThucDaoTaoError(message: e.toString()));
    }
  }

  Future<void> _onAddHinhThucDaoTao(AddHinhThucDaoTao event, Emitter<HinhThucDaoTaoState> emit) async {
    try {
      final hinhThucDaoTao = await hinhThucDaoTaoRepository.addHinhThucDaoTao(event.hinhThucDaoTao);
      if (state is HinhThucDaoTaoLoaded) {
        final updatedHinhThucDaoTaos = List<HinhThucDaoTao>.from((state as HinhThucDaoTaoLoaded).hinhThucDaoTaos)..add(hinhThucDaoTao);
        emit(HinhThucDaoTaoLoaded(hinhThucDaoTaos: updatedHinhThucDaoTaos));
      }
    } catch (e) {
      emit(HinhThucDaoTaoError(message: e.toString()));
    }
  }

  Future<void> _onUpdateHinhThucDaoTao(UpdateHinhThucDaoTao event, Emitter<HinhThucDaoTaoState> emit) async {
    try {
      final hinhThucDaoTao = await hinhThucDaoTaoRepository.updateHinhThucDaoTao(event.hinhThucDaoTao);
      if (state is HinhThucDaoTaoLoaded) {
        final updatedHinhThucDaoTaos = (state as HinhThucDaoTaoLoaded).hinhThucDaoTaos.map((q) => q.htdtTen == hinhThucDaoTao.htdtTen ? hinhThucDaoTao : q).toList();
        emit(HinhThucDaoTaoLoaded(hinhThucDaoTaos: updatedHinhThucDaoTaos));
      }
    } catch (e) {
      emit(HinhThucDaoTaoError(message: e.toString()));
    }
  }

  Future<void> _onDeleteHinhThucDaoTao(DeleteHinhThucDaoTao event, Emitter<HinhThucDaoTaoState> emit) async {
    try {
      await hinhThucDaoTaoRepository.deleteHinhThucDaoTao(event.htdtTen);
      if (state is HinhThucDaoTaoLoaded) {
        final updatedHinhThucDaoTaos = (state as HinhThucDaoTaoLoaded).hinhThucDaoTaos.where((q) => q.htdtTen != event.htdtTen).toList();
        emit(HinhThucDaoTaoLoaded(hinhThucDaoTaos: updatedHinhThucDaoTaos));
      }
    } catch (e) {
      emit(HinhThucDaoTaoError(message: e.toString()));
    }
  }
}
