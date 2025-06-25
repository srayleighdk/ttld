import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/blocs/xa/xa_event.dart';
import 'package:ttld/blocs/xa/xa_state.dart';
import 'package:ttld/models/xa/xa.dart';
import 'package:ttld/repositories/xa/xa_repository.dart';

class XaBloc extends Bloc<XaEvent, XaState> {
  final XaRepository xaRepository;

  XaBloc({required this.xaRepository}) : super(XaInitial()) {
    on<LoadXas>(_onLoadXas);
    on<AddXa>(_onAddXa);
    on<UpdateXa>(_onUpdateXa);
    on<DeleteXa>(_onDeleteXa);
    on<LoadXasByHuyen>(_onLoadXasByHuyen);
  }

  Future<void> _onLoadXas(LoadXas event, Emitter<XaState> emit) async {
    emit(XaLoading());
    try {
      final xas = await xaRepository.getXas();
      emit(XaLoaded(xas: xas));
    } catch (e) {
      emit(XaError(message: e.toString()));
    }
  }

  Future<void> _onLoadXasByHuyen(
      LoadXasByHuyen event, Emitter<XaState> emit) async {
    emit(XaLoading());
    try {
      final xas = await xaRepository.getXasByHuyen(event.mahuyen);
      emit(XaLoadedByHuyen(xas: xas));
    } catch (e) {
      emit(XaError(message: e.toString()));
    }
  }

  Future<void> _onAddXa(AddXa event, Emitter<XaState> emit) async {
    try {
      final xa = await xaRepository.addXa(event.xa);
      if (state is XaLoaded) {
        final List<Xa> updatedXas = List.from((state as XaLoaded).xas)..add(xa);
        emit(XaLoaded(xas: updatedXas));
      }
    } catch (e) {
      emit(XaError(message: e.toString()));
    }
  }

  Future<void> _onUpdateXa(UpdateXa event, Emitter<XaState> emit) async {
    try {
      final xa = await xaRepository.updateXa(event.xa);
      if (state is XaLoaded) {
        final List<Xa> updatedXas = (state as XaLoaded).xas.map((existingXa) {
          return existingXa.maxa == xa.maxa ? xa : existingXa;
        }).toList();
        emit(XaLoaded(xas: updatedXas));
      }
    } catch (e) {
      emit(XaError(message: e.toString()));
    }
  }

  Future<void> _onDeleteXa(DeleteXa event, Emitter<XaState> emit) async {
    try {
      await xaRepository.deleteXa(event.id);
      if (state is XaLoaded) {
        final List<Xa> updatedXas =
            (state as XaLoaded).xas.where((xa) => xa.maxa != event.id).toList();
        emit(XaLoaded(xas: updatedXas));
      }
    } catch (e) {
      emit(XaError(message: e.toString()));
    }
  }
}
