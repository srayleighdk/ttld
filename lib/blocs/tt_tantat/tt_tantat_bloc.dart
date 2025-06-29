
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/tttantat/tttantat.dart';
import 'package:ttld/repositories/tt_tantat/tt_tantat_repository.dart';

abstract class TtTantatState {}

class TtTantatInitial extends TtTantatState {}

class TtTantatLoading extends TtTantatState {}

class TtTantatLoaded extends TtTantatState {
  final List<TtTantat> ttTantatList;
  TtTantatLoaded(this.ttTantatList);
}

class TtTantatError extends TtTantatState {
  final String message;
  TtTantatError(this.message);
}

abstract class TtTantatEvent {}

class FetchTtTantat extends TtTantatEvent {}

class TtTantatBloc extends Bloc<TtTantatEvent, TtTantatState> {
  final TtTantatRepository _repository;

  TtTantatBloc(this._repository) : super(TtTantatInitial()) {
    on<FetchTtTantat>((event, emit) async {
      emit(TtTantatLoading());
      try {
        final ttTantatList = await _repository.getTtTantat();
        emit(TtTantatLoaded(ttTantatList));
      } catch (e) {
        emit(TtTantatError(e.toString()));
      }
    });
  }
}
