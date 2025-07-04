part of 'tuyendung_bloc.dart';

@freezed
class TuyenDungEvent with _$TuyenDungEvent {
  const factory TuyenDungEvent.fetchList(
    String? ntdId, {
    String? idUv,
    int? limit,
    int? page,
    String? search,
    String? status,
    String? duyet,
    String? id,
  }) = FetchTuyenDungList;
  const factory TuyenDungEvent.create(NTDTuyenDung tuyenDung) = CreateTuyenDung;
  const factory TuyenDungEvent.update(NTDTuyenDung tuyenDung) = UpdateTuyenDung;
  const factory TuyenDungEvent.updateForm(NTDTuyenDung tuyenDung) =
      UpdateTuyenDungForm;
  const factory TuyenDungEvent.delete(String idTuyenDung, String? userId) =
      DeleteTuyenDung;
}
