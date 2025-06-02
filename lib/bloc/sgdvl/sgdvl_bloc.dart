import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/sgdvl/sgdvl_model.dart';
import 'package:ttld/repositories/sgdvl_repository.dart';

part 'sgdvl_event.dart';
part 'sgdvl_state.dart';

class SGDVLBloc extends Bloc<SGDVLEvent, SGDVLState> {
  SGDVLBloc({required this.sgdvlRepository}) : super(const SGDVLInitial()) {
    on<LoadSGDVLs>((event, emit) async {
      emit(const SGDVLLoading());
      try {
        final sgdvls = await sgdvlRepository.getSGDVLs();
        emit(SGDVLLoaded(sgdvls));
      } catch (e) {
        emit(SGDVLError(e.toString()));
      }
    });
  }
  final SGDVLRepository sgdvlRepository;
}

