import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/nganh_nghe_td_model.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_td_repository.dart';

part 'nganh_nghe_td_event.dart';
part 'nganh_nghe_td_state.dart';

class NganhNgheTDBloc extends Bloc<NganhNgheTDEvent, NganhNgheTDState> {
  final NganhNgheTDRepository nganhNgheTDRepository;

  NganhNgheTDBloc({required this.nganhNgheTDRepository}) : super(NganhNgheTDInitial()) {
    on<LoadNganhNgheTDs>(_onLoadNganhNgheTDs);
  }

  Future<void> _onLoadNganhNgheTDs(LoadNganhNgheTDs event, Emitter<NganhNgheTDState> emit) async {
    emit(NganhNgheTDLoading());
    try {
      final nganhNgheTDs = await nganhNgheTDRepository.getNganhNgheTDs();
      emit(NganhNgheTDLoaded(nganhNgheTDs: nganhNgheTDs));
    } catch (e) {
      emit(NganhNgheTDError(message: e.toString()));
    }
  }
}
