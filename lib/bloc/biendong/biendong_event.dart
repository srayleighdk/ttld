part of 'biendong_bloc.dart';

@freezed
class BienDongEvent with _$BienDongEvent {
  const factory BienDongEvent.fetchList(String? userId) = FetchBienDongList;
  const factory BienDongEvent.create(NhanVien nhanVien) = CreateBienDong;
  const factory BienDongEvent.update(NhanVien nhanVien) = UpdateBienDong;
  const factory BienDongEvent.delete(String id) = DeleteBienDong;
}
