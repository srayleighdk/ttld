import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/chuyenmon/chuyenmon.dart';
import 'package:ttld/repositories/tblDmChuyenMon/chuyenmon_repository.dart';

part 'chuyenmon_state.dart';
part 'chuyenmon_event.dart';

class ChuyenMonBloc extends Bloc<ChuyenMonEvent, ChuyenMonState> {
  final ChuyenMonRepository chuyenMonRepository;

  ChuyenMonBloc(this.chuyenMonRepository) : super(ChuyenMonInitial()) {
    on<LoadChuyenMons>((event, emit) async {
      emit(ChuyenMonLoading());
      try {
        final chuyenMons = await chuyenMonRepository.getChuyenMons();
        emit(ChuyenMonLoaded(chuyenMons));
      } catch (e) {
        emit(ChuyenMonError('Failed to load chuyên môn: $e'));
      }
    });

    on<CreateChuyenMon>((event, emit) async {
      try {
        await chuyenMonRepository.createChuyenMon(event.chuyenMon);
        emit(ChuyenMonOperationSuccess());
        add(LoadChuyenMons());
      } catch (e) {
        emit(ChuyenMonOperationFailure('Failed to create chuyên môn: $e'));
      }
    });

    on<UpdateChuyenMon>((event, emit) async {
      try {
        await chuyenMonRepository.updateChuyenMon(event.id, event.chuyenMon);
        emit(ChuyenMonOperationSuccess());
        add(LoadChuyenMons());
      } catch (e) {
        emit(ChuyenMonOperationFailure('Failed to update chuyên môn: $e'));
      }
    });

    on<DeleteChuyenMon>((event, emit) async {
      try {
        await chuyenMonRepository.deleteChuyenMon(event.id);
        emit(ChuyenMonOperationSuccess());
        add(LoadChuyenMons());
      } catch (e) {
        emit(ChuyenMonOperationFailure('Failed to delete chuyên môn: $e'));
      }
    });
  }
}
