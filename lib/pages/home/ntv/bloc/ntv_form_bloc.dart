import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ttld/pages/home/ntv/model/ntv_model.dart';
import 'package:ttld/pages/home/ntv/repository/ntv_repository.dart';

part 'ntv_form_event.dart';
part 'ntv_form_state.dart';

class NTVFormBloc extends Bloc<NTVFormEvent, NTVFormState> {
  final NTVRepository ntvRepository;

  NTVFormBloc({required this.ntvRepository}) : super(UserInitial()) {
    on<CreateUserEvent>((event, emit) async {
      emit(UserLoading());
      final result = await ntvRepository.createUser(event.ntv);
      emit(result ? UserSuccess() : UserFailure());
    });

    on<UpdateUserEvent>((event, emit) async {
      emit(UserLoading());
      final result = await ntvRepository.updateUser(event.ntv);
      emit(result ? UserSuccess() : UserFailure());
    });
  }
}
