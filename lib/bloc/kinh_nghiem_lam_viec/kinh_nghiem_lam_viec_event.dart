part of 'kinh_nghiem_lam_viec_bloc.dart';

@freezed
class KinhNghiemLamViecEvent with _$KinhNghiemLamViecEvent {
  const factory KinhNghiemLamViecEvent.fetchList() = FetchKinhNghiemLamViecList;
  const factory KinhNghiemLamViecEvent.load() = LoadKinhNghiem;
  const factory KinhNghiemLamViecEvent.add(KinhNghiemLamViec kinhNghiem) = AddKinhNghiem;
  const factory KinhNghiemLamViecEvent.update(KinhNghiemLamViec kinhNghiem) = UpdateKinhNghiem;
  const factory KinhNghiemLamViecEvent.delete(String id) = DeleteKinhNghiem;
}
