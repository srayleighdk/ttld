import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/trinh_do_van_hoa_model.dart';
import 'package:ttld/repositories/trinh_do_van_hoa/trinh_do_van_hoa_repository.dart';

part 'trinh_do_van_hoa_event.dart';
part 'trinh_do_van_hoa_state.dart';

class TrinhDoVanHoaBloc extends Bloc<TrinhDoVanHoaEvent, TrinhDoVanHoaState> {
  final TrinhDoVanHoaRepository trinhDoVanHoaRepository;

  TrinhDoVanHoaBloc({required this.trinhDoVanHoaRepository}) : super(TrinhDoVanHoaInitial()) {
    on<LoadTrinhDoVanHoas>(_onLoadTrinhDoVanHoas);
    on<AddTrinhDoVanHoa>(_onAddTrinhDoVanHoa);
    on<UpdateTrinhDoVanHoa>(_onUpdateTrinhDoVanHoa);
    on<DeleteTrinhDoVanHoa>(_onDeleteTrinhDoVanHoa);
  }

  Future<void> _onLoadTrinhDoVanHoas(LoadTrinhDoVanHoas event, Emitter<TrinhDoVanHoaState> emit) async {
    emit(TrinhDoVanHoaLoading());
    try {
      final trinhDoVanHoas = await trinhDoVanHoaRepository.getTrinhDoVanHoas();
      emit(TrinhDoVanHoaLoaded(trinhDoVanHoas: trinhDoVanHoas));
    } catch (e) {
      emit(TrinhDoVanHoaError(message: e.toString()));
    }
  }

  Future<void> _onAddTrinhDoVanHoa(AddTrinhDoVanHoa event, Emitter<TrinhDoVanHoaState> emit) async {
    try {
      final trinhDoVanHoa = await trinhDoVanHoaRepository.addTrinhDoVanHoa(event.trinhDoVanHoa);
      if (state is TrinhDoVanHoaLoaded) {
        final updatedTrinhDoVanHoas = List<TrinhDoVanHoa>.from((state as TrinhDoVanHoaLoaded).trinhDoVanHoas)..add(trinhDoVanHoa);
        emit(TrinhDoVanHoaLoaded(trinhDoVanHoas: updatedTrinhDoVanHoas));
      }
    } catch (e) {
      emit(TrinhDoVanHoaError(message: e.toString()));
    }
  }

  Future<void> _onUpdateTrinhDoVanHoa(UpdateTrinhDoVanHoa event, Emitter<TrinhDoVanHoaState> emit) async {
    try {
      final trinhDoVanHoa = await trinhDoVanHoaRepository.updateTrinhDoVanHoa(event.trinhDoVanHoa);
      if (state is TrinhDoVanHoaLoaded) {
        final updatedTrinhDoVanHoas = (state as TrinhDoVanHoaLoaded).trinhDoVanHoas.map((q) => q.hocvanTen == trinhDoVanHoa.hocvanTen ? trinhDoVanHoa : q).toList();
        emit(TrinhDoVanHoaLoaded(trinhDoVanHoas: updatedTrinhDoVanHoas));
      }
    } catch (e) {
      emit(TrinhDoVanHoaError(message: e.toString()));
    }
  }

  Future<void> _onDeleteTrinhDoVanHoa(DeleteTrinhDoVanHoa event, Emitter<TrinhDoVanHoaState> emit) async {
    try {
      await trinhDoVanHoaRepository.deleteTrinhDoVanHoa(event.hocvanTen);
      if (state is TrinhDoVanHoaLoaded) {
        final updatedTrinhDoVanHoas = (state as TrinhDoVanHoaLoaded).trinhDoVanHoas.where((q) => q.hocvanTen != event.hocvanTen).toList();
        emit(TrinhDoVanHoaLoaded(trinhDoVanHoas: updatedTrinhDoVanHoas));
      }
    } catch (e) {
      emit(TrinhDoVanHoaError(message: e.toString()));
    }
  }
}
