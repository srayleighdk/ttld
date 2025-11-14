import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/ton_giao_model.dart';
import 'package:ttld/repositories/ton_giao/ton_giao_repository.dart';

part 'ton_giao_event.dart';
part 'ton_giao_state.dart';

class TonGiaoBloc extends Bloc<TonGiaoEvent, TonGiaoState> {
  final TonGiaoRepository tonGiaoRepository;

  TonGiaoBloc({required this.tonGiaoRepository}) : super(TonGiaoInitial()) {
    on<LoadTonGiaos>(_onLoadTonGiaos);
    on<AddTonGiao>(_onAddTonGiao);
    on<UpdateTonGiao>(_onUpdateTonGiao);
    on<DeleteTonGiao>(_onDeleteTonGiao);
  }

  Future<void> _onLoadTonGiaos(LoadTonGiaos event, Emitter<TonGiaoState> emit) async {
    emit(TonGiaoLoading());
    try {
      final tonGiaos = await tonGiaoRepository.getTonGiaos();
      emit(TonGiaoLoaded(tonGiaos: tonGiaos));
    } catch (e) {
      emit(TonGiaoError(message: e.toString()));
    }
  }

  Future<void> _onAddTonGiao(AddTonGiao event, Emitter<TonGiaoState> emit) async {
    try {
      final tonGiao = await tonGiaoRepository.addTonGiao(event.tonGiao);
      if (state is TonGiaoLoaded) {
        final updatedTonGiaos = List<TonGiao>.from((state as TonGiaoLoaded).tonGiaos)..add(tonGiao);
        emit(TonGiaoLoaded(tonGiaos: updatedTonGiaos));
      }
    } catch (e) {
      emit(TonGiaoError(message: e.toString()));
    }
  }

  Future<void> _onUpdateTonGiao(UpdateTonGiao event, Emitter<TonGiaoState> emit) async {
    try {
      final tonGiao = await tonGiaoRepository.updateTonGiao(event.tonGiao);
      if (state is TonGiaoLoaded) {
        final updatedTonGiaos = (state as TonGiaoLoaded).tonGiaos.map((q) => q.displayName == tonGiao.displayName ? tonGiao : q).toList();
        emit(TonGiaoLoaded(tonGiaos: updatedTonGiaos));
      }
    } catch (e) {
      emit(TonGiaoError(message: e.toString()));
    }
  }

  Future<void> _onDeleteTonGiao(DeleteTonGiao event, Emitter<TonGiaoState> emit) async {
    try {
      await tonGiaoRepository.deleteTonGiao(event.tenTg);
      if (state is TonGiaoLoaded) {
        final updatedTonGiaos = (state as TonGiaoLoaded).tonGiaos.where((q) => q.displayName != event.tenTg).toList();
        emit(TonGiaoLoaded(tonGiaos: updatedTonGiaos));
      }
    } catch (e) {
      emit(TonGiaoError(message: e.toString()));
    }
  }
}
