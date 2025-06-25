import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/don_vi_model.dart';
import 'package:ttld/repositories/don_vi/don_vi_repository.dart';

part 'don_vi_event.dart';
part 'don_vi_state.dart';

class DonViBloc extends Bloc<DonViEvent, DonViState> {
  final DonViRepository donViRepository;

  DonViBloc({required this.donViRepository}) : super(DonViInitial()) {
    on<LoadDonVis>(_onLoadDonVis);
    on<AddDonVi>(_onAddDonVi);
    on<UpdateDonVi>(_onUpdateDonVi);
    on<DeleteDonVi>(_onDeleteDonVi);
  }

  Future<void> _onLoadDonVis(LoadDonVis event, Emitter<DonViState> emit) async {
    emit(DonViLoading());
    try {
      final donVis = await donViRepository.getDonVis();
      emit(DonViLoaded(donVis: donVis));
    } catch (e) {
      emit(DonViError(message: e.toString()));
    }
  }

  Future<void> _onAddDonVi(AddDonVi event, Emitter<DonViState> emit) async {
    try {
      final donVi = await donViRepository.addDonVi(event.donVi);
      if (state is DonViLoaded) {
        final updatedDonVis = List<DonVi>.from((state as DonViLoaded).donVis)..add(donVi);
        emit(DonViLoaded(donVis: updatedDonVis));
      }
    } catch (e) {
      emit(DonViError(message: e.toString()));
    }
  }

  Future<void> _onUpdateDonVi(UpdateDonVi event, Emitter<DonViState> emit) async {
    try {
      final donVi = await donViRepository.updateDonVi(event.donVi);
      if (state is DonViLoaded) {
        final updatedDonVis = (state as DonViLoaded).donVis.map((q) => q.madonvi == donVi.madonvi ? donVi : q).toList();
        emit(DonViLoaded(donVis: updatedDonVis));
      }
    } catch (e) {
      emit(DonViError(message: e.toString()));
    }
  }

  Future<void> _onDeleteDonVi(DeleteDonVi event, Emitter<DonViState> emit) async {
    try {
      await donViRepository.deleteDonVi(event.madonvi);
      if (state is DonViLoaded) {
        final updatedDonVis = (state as DonViLoaded).donVis.where((q) => q.madonvi != event.madonvi).toList();
        emit(DonViLoaded(donVis: updatedDonVis));
      }
    } catch (e) {
      emit(DonViError(message: e.toString()));
    }
  }
}
