import 'package:bloc/bloc.dart';
import 'package:ttld/bloc/m01tt11/m01tt11_event.dart';
import 'package:ttld/bloc/m01tt11/m01tt11_state.dart';
import 'package:ttld/models/m01tt11_model.dart';
import 'package:ttld/repositories/m01tt11/m01tt11_repository.dart';

class M01TT11Bloc extends Bloc<M01TT11Event, M01TT11State> {
  final M01TT11Repository m01tt11Repository;

  M01TT11Bloc({required this.m01tt11Repository}) : super(M01TT11Initial()) {
    on<M01TT11LoadAll>((event, emit) async {
      emit(M01TT11Loading());
      try {
        final List<M01TT11> m01tt11s = await m01tt11Repository.getAllM01TT11();
        emit(M01TT11Loaded(m01tt11s: m01tt11s));
      } catch (e) {
        emit(M01TT11Error(message: e.toString()));
      }
    });

    on<M01TT11Create>((event, emit) async {
      emit(M01TT11Loading());
      try {
        final M01TT11 newM01TT11 = await m01tt11Repository.createM01TT11(event.m01tt11);
        // After creating, reload all items
        final List<M01TT11> m01tt11s = await m01tt11Repository.getAllM01TT11();
        emit(M01TT11Loaded(m01tt11s: m01tt11s));
      } catch (e) {
        emit(M01TT11Error(message: e.toString()));
      }
    });

    on<M01TT11Update>((event, emit) async {
      emit(M01TT11Loading());
      try {
        final M01TT11 updatedM01TT11 = await m01tt11Repository.updateM01TT11(event.id, event.m01tt11);
        // After updating, reload all items
         final List<M01TT11> m01tt11s = await m01tt11Repository.getAllM01TT11();
        emit(M01TT11Loaded(m01tt11s: m01tt11s));
      } catch (e) {
        emit(M01TT11Error(message: e.toString()));
      }
    });

    on<M01TT11Delete>((event, emit) async {
      emit(M01TT11Loading());
      try {
        await m01tt11Repository.deleteM01TT11(event.id);
        // After deleting, reload all items
        final List<M01TT11> m01tt11s = await m01tt11Repository.getAllM01TT11();
        emit(M01TT11Loaded(m01tt11s: m01tt11s));
      } catch (e) {
        emit(M01TT11Error(message: e.toString()));
      }
    });
  }
}
