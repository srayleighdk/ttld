import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/quocgia/quocgia_model.dart';
import 'package:ttld/repositories/quocgia/quocgia_repository.dart';

part 'quocgia_event.dart';
part 'quocgia_state.dart';

class QuocGiaBloc extends Bloc<QuocGiaEvent, QuocGiaState> {
  final QuocGiaRepository quocGiaRepository;

  QuocGiaBloc({required this.quocGiaRepository}) : super(QuocGiaInitial()) {
    on<LoadQuocGias>(_onLoadQuocGias);
    on<AddQuocGia>(_onAddQuocGia);
    on<UpdateQuocGia>(_onUpdateQuocGia);
    on<DeleteQuocGia>(_onDeleteQuocGia);
  }

  Future<void> _onLoadQuocGias(LoadQuocGias event, Emitter<QuocGiaState> emit) async {
    emit(QuocGiaLoading());
    try {
      final quocGias = await quocGiaRepository.getQuocGias();
      emit(QuocGiaLoaded(quocGias: quocGias));
    } catch (e) {
      emit(QuocGiaError(message: e.toString()));
    }
  }

  Future<void> _onAddQuocGia(AddQuocGia event, Emitter<QuocGiaState> emit) async {
    try {
      final quocGia = await quocGiaRepository.addQuocGia(event.quocGia);
      if (state is QuocGiaLoaded) {
        final updatedQuocGias = List<QuocGia>.from((state as QuocGiaLoaded).quocGias)..add(quocGia);
        emit(QuocGiaLoaded(quocGias: updatedQuocGias));
      }
    } catch (e) {
      emit(QuocGiaError(message: e.toString()));
    }
  }

  Future<void> _onUpdateQuocGia(UpdateQuocGia event, Emitter<QuocGiaState> emit) async {
    try {
      final quocGia = await quocGiaRepository.updateQuocGia(event.quocGia);
      if (state is QuocGiaLoaded) {
        final updatedQuocGias = (state as QuocGiaLoaded).quocGias.map((q) => q.tenQuocGia == quocGia.tenQuocGia ? quocGia : q).toList();
        emit(QuocGiaLoaded(quocGias: updatedQuocGias));
      }
    } catch (e) {
      emit(QuocGiaError(message: e.toString()));
    }
  }

  Future<void> _onDeleteQuocGia(DeleteQuocGia event, Emitter<QuocGiaState> emit) async {
    try {
      await quocGiaRepository.deleteQuocGia(event.tenQuocGia);
      if (state is QuocGiaLoaded) {
        final updatedQuocGias = (state as QuocGiaLoaded).quocGias.where((q) => q.tenQuocGia != event.tenQuocGia).toList();
        emit(QuocGiaLoaded(quocGias: updatedQuocGias));
      }
    } catch (e) {
      emit(QuocGiaError(message: e.toString()));
    }
  }
}
