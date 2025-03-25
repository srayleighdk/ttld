part of 'biendong_bloc.dart';

@freezed
class BienDongState with _$BienDongState {
  const factory BienDongState.initial() = BienDongInitial;
  const factory BienDongState.loading() = BienDongLoading;
  const factory BienDongState.loaded(List<NhanVien> nhanVienList) =
      BienDongLoaded;
  const factory BienDongState.error(String message) = BienDongError;
}
