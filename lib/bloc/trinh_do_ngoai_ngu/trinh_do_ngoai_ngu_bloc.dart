import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/trinh_do_ngoai_ngu_model.dart';
import 'package:ttld/repositories/trinh_do_ngoai_ngu/trinh_do_ngoai_ngu_repository.dart';

part 'trinh_do_ngoai_ngu_event.dart';
part 'trinh_do_ngoai_ngu_state.dart';

class TrinhDoNgoaiNguBloc extends Bloc<TrinhDoNgoaiNguEvent, TrinhDoNgoaiNguState> {
  final TrinhDoNgoaiNguRepository trinhDoNgoaiNguRepository;

  TrinhDoNgoaiNguBloc({required this.trinhDoNgoaiNguRepository}) : super(TrinhDoNgoaiNguInitial()) {
    on<LoadTrinhDoNgoaiNgus>(_onLoadTrinhDoNgoaiNgus);
    on<AddTrinhDoNgoaiNgu>(_onAddTrinhDoNgoaiNgu);
    on<UpdateTrinhDoNgoaiNgu>(_onUpdateTrinhDoNgoaiNgu);
    on<DeleteTrinhDoNgoaiNgu>(_onDeleteTrinhDoNgoaiNgu);
  }

  Future<void> _onLoadTrinhDoNgoaiNgus(LoadTrinhDoNgoaiNgus event, Emitter<TrinhDoNgoaiNguState> emit) async {
    emit(TrinhDoNgoaiNguLoading());
    try {
      final trinhDoNgoaiNgus = await trinhDoNgoaiNguRepository.getTrinhDoNgoaiNgus();
      emit(TrinhDoNgoaiNguLoaded(trinhDoNgoaiNgus: trinhDoNgoaiNgus));
    } catch (e) {
      emit(TrinhDoNgoaiNguError(message: e.toString()));
    }
  }

  Future<void> _onAddTrinhDoNgoaiNgu(AddTrinhDoNgoaiNgu event, Emitter<TrinhDoNgoaiNguState> emit) async {
    try {
      final trinhDoNgoaiNgu = await trinhDoNgoaiNguRepository.addTrinhDoNgoaiNgu(event.trinhDoNgoaiNgu);
      if (state is TrinhDoNgoaiNguLoaded) {
        final updatedTrinhDoNgoaiNgus = List<TrinhDoNgoaiNgu>.from((state as TrinhDoNgoaiNguLoaded).trinhDoNgoaiNgus)..add(trinhDoNgoaiNgu);
        emit(TrinhDoNgoaiNguLoaded(trinhDoNgoaiNgus: updatedTrinhDoNgoaiNgus));
      }
    } catch (e) {
      emit(TrinhDoNgoaiNguError(message: e.toString()));
    }
  }

  Future<void> _onUpdateTrinhDoNgoaiNgu(UpdateTrinhDoNgoaiNgu event, Emitter<TrinhDoNgoaiNguState> emit) async {
    try {
      final trinhDoNgoaiNgu = await trinhDoNgoaiNguRepository.updateTrinhDoNgoaiNgu(event.trinhDoNgoaiNgu);
      if (state is TrinhDoNgoaiNguLoaded) {
        final updatedTrinhDoNgoaiNgus = (state as TrinhDoNgoaiNguLoaded).trinhDoNgoaiNgus.map((q) => q.id == trinhDoNgoaiNgu.id ? trinhDoNgoaiNgu : q).toList();
        emit(TrinhDoNgoaiNguLoaded(trinhDoNgoaiNgus: updatedTrinhDoNgoaiNgus));
      }
    } catch (e) {
      emit(TrinhDoNgoaiNguError(message: e.toString()));
    }
  }

  Future<void> _onDeleteTrinhDoNgoaiNgu(DeleteTrinhDoNgoaiNgu event, Emitter<TrinhDoNgoaiNguState> emit) async {
    try {
      await trinhDoNgoaiNguRepository.deleteTrinhDoNgoaiNgu(event.id);
      if (state is TrinhDoNgoaiNguLoaded) {
        final updatedTrinhDoNgoaiNgus = (state as TrinhDoNgoaiNguLoaded).trinhDoNgoaiNgus.where((q) => q.id != event.id).toList();
        emit(TrinhDoNgoaiNguLoaded(trinhDoNgoaiNgus: updatedTrinhDoNgoaiNgus));
      }
    } catch (e) {
      emit(TrinhDoNgoaiNguError(message: e.toString()));
    }
  }
}
