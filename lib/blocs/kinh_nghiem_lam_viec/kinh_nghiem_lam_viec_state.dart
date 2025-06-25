part of 'kinh_nghiem_lam_viec_bloc.dart';

@freezed
class KinhNghiemLamViecState with _$KinhNghiemLamViecState {
  const factory KinhNghiemLamViecState.initial() = KinhNghiemLamViecInitial;
  const factory KinhNghiemLamViecState.loading() = KinhNghiemLamViecLoading;
  const factory KinhNghiemLamViecState.loaded(List<KinhNghiemLamViec> kinhNghiemList) = KinhNghiemLamViecLoaded;
  const factory KinhNghiemLamViecState.error(String message) = KinhNghiemLamViecError;
  const factory KinhNghiemLamViecState.deleted() = KinhNghiemLamViecDeleted;
}
