import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/bloc/tinh/tinh_event.dart';
import 'package:ttld/bloc/tinh/tinh_state.dart';
import 'package:ttld/models/tinh/tinh.dart';
import 'package:ttld/repositories/tinh/tinh_repository.dart';

class TinhBloc extends Bloc<TinhEvent, TinhState> {
  final TinhRepository tinhRepository;

  TinhBloc({required this.tinhRepository}) : super(TinhInitial()) {
    on<LoadTinhs>(_onLoadTinhs);
    on<AddTinh>(_onAddTinh);
    on<UpdateTinh>(_onUpdateTinh);
    on<DeleteTinh>(_onDeleteTinh);
  }

  Future<void> _onLoadTinhs(LoadTinhs event, Emitter<TinhState> emit) async {
    emit(TinhLoading());
    try {
      final tinhs = await tinhRepository.getTinhs();
      emit(TinhLoaded(tinhs: tinhs));
    } catch (e) {
      emit(TinhError(message: e.toString()));
    }
  }

  Future<void> _onAddTinh(AddTinh event, Emitter<TinhState> emit) async {
    try {
      final tinh = await tinhRepository.addTinh(event.tinh);
      if (state is TinhLoaded) {
        final List<Tinh> updatedTinhs = List.from((state as TinhLoaded).tinhs)
          ..add(tinh);
        emit(TinhLoaded(tinhs: updatedTinhs));
      }
    } catch (e) {
      emit(TinhError(message: e.toString()));
    }
  }

  Future<void> _onUpdateTinh(UpdateTinh event, Emitter<TinhState> emit) async {
    try {
      final tinh = await tinhRepository.updateTinh(event.tinh);
      if (state is TinhLoaded) {
        final List<Tinh> updatedTinhs =
            (state as TinhLoaded).tinhs.map((existingTinh) {
          return existingTinh.matinh == tinh.matinh ? tinh : existingTinh;
        }).toList();
        emit(TinhLoaded(tinhs: updatedTinhs));
      }
    } catch (e) {
      emit(TinhError(message: e.toString()));
    }
  }

  Future<void> _onDeleteTinh(DeleteTinh event, Emitter<TinhState> emit) async {
    try {
      await tinhRepository.deleteTinh(event.id);
      if (state is TinhLoaded) {
        final List<Tinh> updatedTinhs = (state as TinhLoaded)
            .tinhs
            .where((tinh) => tinh.matinh != event.id)
            .toList();
        emit(TinhLoaded(tinhs: updatedTinhs));
      }
    } catch (e) {
      emit(TinhError(message: e.toString()));
    }
  }
}
