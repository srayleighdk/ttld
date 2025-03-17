part of 'tuyendung_bloc.dart';

@freezed
class TuyenDungEvent with _$TuyenDungEvent {
  const factory TuyenDungEvent.fetchList(String? ntdId) = FetchTuyenDungList;
  const factory TuyenDungEvent.create(NTDTuyenDung tuyenDung) = CreateTuyenDung;
  const factory TuyenDungEvent.update(NTDTuyenDung tuyenDung) = UpdateTuyenDung;
  const factory TuyenDungEvent.delete(String idTuyenDung) = DeleteTuyenDung;
}
