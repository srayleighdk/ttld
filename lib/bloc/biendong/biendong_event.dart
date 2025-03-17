part of 'biendong_bloc.dart';

@freezed
class BienDongEvent with _$BienDongEvent {
  const factory BienDongEvent.fetchList(String? userId) = FetchBienDongList;
  const factory BienDongEvent.create(BienDong bienDong) = CreateBienDong;
  const factory BienDongEvent.update(BienDong bienDong) = UpdateBienDong;
  const factory BienDongEvent.delete(String id) = DeleteBienDong;
}
