import 'package:freezed_annotation/freezed_annotation.dart';

part 'tuyendung_event.freezed.dart';

@freezed
class TuyenDungEvent with _$TuyenDungEvent {
  const factory TuyenDungEvent.fetchList() = FetchTuyenDungList;
  const factory TuyenDungEvent.create(NTDTuyenDung tuyenDung) = CreateTuyenDung;
  const factory TuyenDungEvent.update(NTDTuyenDung tuyenDung) = UpdateTuyenDung;
  const factory TuyenDungEvent.delete(String idTuyenDung) = DeleteTuyenDung;
}
