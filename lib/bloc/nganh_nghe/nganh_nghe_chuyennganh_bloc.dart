import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/nganh_nghe_chuyennganh.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_chuyennganh_repository.dart';

part 'nganh_nghe_chuyennganh_event.dart';
part 'nganh_nghe_chuyennganh_state.dart';

class NganhNgheChuyenNganhBloc extends Bloc<NganhNgheChuyenNganhEvent, NganhNgheChuyenNganhState> {
  final NganhNgheChuyenNganhRepository nganhNgheChuyenNganhRepository;

  NganhNgheChuyenNganhBloc({required this.nganhNgheChuyenNganhRepository}) : super(NganhNgheChuyenNganhInitial()) {
    on<LoadNganhNgheChuyenNganhs>(_onLoadNganhNgheChuyenNganhs);
    on<AddNganhNgheChuyenNganh>(_onAddNganhNgheChuyenNganh);
    on<UpdateNganhNgheChuyenNganh>(_onUpdateNganhNgheChuyenNganh);
    on<DeleteNganhNgheChuyenNganh>(_onDeleteNganhNgheChuyenNganh);
  }

  Future<void> _onLoadNganhNgheChuyenNganhs(LoadNganhNgheChuyenNganhs event, Emitter<NganhNgheChuyenNganhState> emit) async {
    emit(NganhNgheChuyenNganhLoading());
    try {
      final nganhNgheChuyenNganhs = await nganhNgheChuyenNganhRepository.getNganhNgheChuyenNganhs();
      emit(NganhNgheChuyenNganhLoaded(nganhNgheChuyenNganhs: nganhNgheChuyenNganhs));
    } catch (e) {
      emit(NganhNgheChuyenNganhError(message: e.toString()));
    }
  }

  Future<void> _onAddNganhNgheChuyenNganh(AddNganhNgheChuyenNganh event, Emitter<NganhNgheChuyenNganhState> emit) async {
    try {
      final nganhNgheChuyenNganh = await nganhNgheChuyenNganhRepository.addNganhNgheChuyenNganh(event.nganhNgheChuyenNganh);
      if (state is NganhNgheChuyenNganhLoaded) {
        final updatedNganhNgheChuyenNganhs = List<NganhNgheChuyenNganh>.from((state as NganhNgheChuyenNganhLoaded).nganhNgheChuyenNganhs)..add(nganhNgheChuyenNganh);
        emit(NganhNgheChuyenNganhLoaded(nganhNgheChuyenNganhs: updatedNganhNgheChuyenNganhs));
      }
    } catch (e) {
      emit(NganhNgheChuyenNganhError(message: e.toString()));
    }
  }

  Future<void> _onUpdateNganhNgheChuyenNganh(UpdateNganhNgheChuyenNganh event, Emitter<NganhNgheChuyenNganhState> emit) async {
    try {
      final nganhNgheChuyenNganh = await nganhNgheChuyenNganhRepository.updateNganhNgheChuyenNganh(event.nganhNgheChuyenNganh);
      if (state is NganhNgheChuyenNganhLoaded) {
        final updatedNganhNgheChuyenNganhs = (state as NganhNgheChuyenNganhLoaded).nganhNgheChuyenNganhs.map((q) => q.ma == nganhNgheChuyenNganh.ma ? nganhNgheChuyenNganh : q).toList();
        emit(NganhNgheChuyenNganhLoaded(nganhNgheChuyenNganhs: updatedNganhNgheChuyenNganhs));
      }
    } catch (e) {
      emit(NganhNgheChuyenNganhError(message: e.toString()));
    }
  }

  Future<void> _onDeleteNganhNgheChuyenNganh(DeleteNganhNgheChuyenNganh event, Emitter<NganhNgheChuyenNganhState> emit) async {
    try {
      await nganhNgheChuyenNganhRepository.deleteNganhNgheChuyenNganh(event.ma.toString());
      if (state is NganhNgheChuyenNganhLoaded) {
        final updatedNganhNgheChuyenNganhs = (state as NganhNgheChuyenNganhLoaded).nganhNgheChuyenNganhs.where((q) => q.ma != event.ma).toList();
        emit(NganhNgheChuyenNganhLoaded(nganhNgheChuyenNganhs: updatedNganhNgheChuyenNganhs));
      }
    } catch (e) {
      emit(NganhNgheChuyenNganhError(message: e.toString()));
    }
  }
}
