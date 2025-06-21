import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/trinh_do_hoc_van_model.dart';
import 'package:ttld/repositories/trinh_do_hoc_van/trinh_do_hoc_van_repository.dart';

part 'trinh_do_hoc_van_event.dart';
part 'trinh_do_hoc_van_state.dart';

class TrinhDoHocVanBloc extends Bloc<TrinhDoHocVanEvent, TrinhDoHocVanState> {
  final TrinhDoHocVanRepository trinhDoHocVanRepository;

  TrinhDoHocVanBloc({required this.trinhDoHocVanRepository})
      : super(TrinhDoHocVanInitial()) {
    on<LoadTrinhDoHocVans>(_onLoadTrinhDoHocVans);
    on<AddTrinhDoHocVan>(_onAddTrinhDoHocVan);
    on<UpdateTrinhDoHocVan>(_onUpdateTrinhDoHocVan);
    // on<DeleteTrinhDoHocVan>(_onDeleteTrinhDoHocVan);
  }

  Future<void> _onLoadTrinhDoHocVans(
      LoadTrinhDoHocVans event, Emitter<TrinhDoHocVanState> emit) async {
    emit(TrinhDoHocVanLoading());
    try {
      final trinhDoHocVans = await trinhDoHocVanRepository.getTrinhDoHocVans();
      emit(TrinhDoHocVanLoaded(trinhDoHocVans: trinhDoHocVans));
    } catch (e) {
      emit(TrinhDoHocVanError(message: e.toString()));
    }
  }

  Future<void> _onAddTrinhDoHocVan(
      AddTrinhDoHocVan event, Emitter<TrinhDoHocVanState> emit) async {
    try {
      final trinhDoHocVan =
          await trinhDoHocVanRepository.addTrinhDoHocVan(event.trinhDoHocVan);
      if (state is TrinhDoHocVanLoaded) {
        final updatedTrinhDoHocVans = List<TrinhDoHocVan>.from(
            (state as TrinhDoHocVanLoaded).trinhDoHocVans)
          ..add(trinhDoHocVan);
        emit(TrinhDoHocVanLoaded(trinhDoHocVans: updatedTrinhDoHocVans));
      }
    } catch (e) {
      emit(TrinhDoHocVanError(message: e.toString()));
    }
  }

  Future<void> _onUpdateTrinhDoHocVan(
      UpdateTrinhDoHocVan event, Emitter<TrinhDoHocVanState> emit) async {
    try {
      final trinhDoHocVan = await trinhDoHocVanRepository
          .updateTrinhDoHocVan(event.trinhDoHocVan);
      if (state is TrinhDoHocVanLoaded) {
        final updatedTrinhDoHocVans = (state as TrinhDoHocVanLoaded)
            .trinhDoHocVans
            .map((q) =>
                q.displayName == trinhDoHocVan.displayName ? trinhDoHocVan : q)
            .toList();
        emit(TrinhDoHocVanLoaded(trinhDoHocVans: updatedTrinhDoHocVans));
      }
    } catch (e) {
      emit(TrinhDoHocVanError(message: e.toString()));
    }
  }

  // Future<void> _onDeleteTrinhDoHocVan(DeleteTrinhDoHocVan event, Emitter<TrinhDoHocVanState> emit) async {
  //   try {
  //     await trinhDoHocVanRepository.deleteTrinhDoHocVan(event.name);
  //     if (state is TrinhDoHocVanLoaded) {
  //       final updatedTrinhDoHocVans = (state as TrinhDoHocVanLoaded).trinhDoHocVans.where((q) => q.name != event.name).toList();
  //       emit(TrinhDoHocVanLoaded(trinhDoHocVans: updatedTrinhDoHocVans));
  //     }
  //   } catch (e) {
  //     emit(TrinhDoHocVanError(message: e.toString()));
  //   }
  // }
}
