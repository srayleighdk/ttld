import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/thoigianlamviec_model.dart';
import 'package:ttld/repositories/thoigianlamviec/thoigianlamviec_repository.dart';

part 'thoigianlamviec_event.dart';
part 'thoigianlamviec_state.dart';

class ThoiGianLamViecBloc extends Bloc<ThoiGianLamViecEvent, ThoiGianLamViecState> {
  final ThoiGianLamViecRepository thoiGianLamViecRepository;

  ThoiGianLamViecBloc({required this.thoiGianLamViecRepository}) : super(ThoiGianLamViecInitial()) {
    on<LoadThoiGianLamViecs>(_onLoadThoiGianLamViecs);
    on<AddThoiGianLamViec>(_onAddThoiGianLamViec);
    on<UpdateThoiGianLamViec>(_onUpdateThoiGianLamViec);
    on<DeleteThoiGianLamViec>(_onDeleteThoiGianLamViec);
  }

  Future<void> _onLoadThoiGianLamViecs(LoadThoiGianLamViecs event, Emitter<ThoiGianLamViecState> emit) async {
    emit(ThoiGianLamViecLoading());
    try {
      final thoiGianLamViecs = await thoiGianLamViecRepository.getThoiGianLamViecs();
      emit(ThoiGianLamViecLoaded(thoiGianLamViecs: thoiGianLamViecs));
    } catch (e) {
      emit(ThoiGianLamViecError(message: e.toString()));
    }
  }

  Future<void> _onAddThoiGianLamViec(AddThoiGianLamViec event, Emitter<ThoiGianLamViecState> emit) async {
    try {
      final thoiGianLamViec = await thoiGianLamViecRepository.addThoiGianLamViec(event.thoiGianLamViec);
      if (state is ThoiGianLamViecLoaded) {
        final updatedThoiGianLamViecs = List<ThoiGianLamViec>.from((state as ThoiGianLamViecLoaded).thoiGianLamViecs)..add(thoiGianLamViec);
        emit(ThoiGianLamViecLoaded(thoiGianLamViecs: updatedThoiGianLamViecs));
      }
    } catch (e) {
      emit(ThoiGianLamViecError(message: e.toString()));
    }
  }

  Future<void> _onUpdateThoiGianLamViec(UpdateThoiGianLamViec event, Emitter<ThoiGianLamViecState> emit) async {
    try {
      final thoiGianLamViec = await thoiGianLamViecRepository.updateThoiGianLamViec(event.thoiGianLamViec);
      if (state is ThoiGianLamViecLoaded) {
        final updatedThoiGianLamViecs = (state as ThoiGianLamViecLoaded).thoiGianLamViecs.map((q) => q.name == thoiGianLamViec.name ? thoiGianLamViec : q).toList();
        emit(ThoiGianLamViecLoaded(thoiGianLamViecs: updatedThoiGianLamViecs));
      }
    } catch (e) {
      emit(ThoiGianLamViecError(message: e.toString()));
    }
  }

  Future<void> _onDeleteThoiGianLamViec(DeleteThoiGianLamViec event, Emitter<ThoiGianLamViecState> emit) async {
    try {
      await thoiGianLamViecRepository.deleteThoiGianLamViec(event.id.toString());
      if (state is ThoiGianLamViecLoaded) {
        final updatedThoiGianLamViecs = (state as ThoiGianLamViecLoaded).thoiGianLamViecs.where((q) => q.id != event.id).toList();
        emit(ThoiGianLamViecLoaded(thoiGianLamViecs: updatedThoiGianLamViecs));
      }
    } catch (e) {
      emit(ThoiGianLamViecError(message: e.toString()));
    }
  }
}
