import 'package:your_app_name/models/muc_luong_mm.dart'; // Replace with your actual import

abstract class MucLuongEvent {}

class LoadMucLuongs extends MucLuongEvent {}

class CreateMucLuong extends MucLuongEvent {
  final MucLuongMM mucLuong;

  CreateMucLuong({required this.mucLuong});
}

class UpdateMucLuong extends MucLuongEvent {
  final MucLuongMM mucLuong;

  UpdateMucLuong({required this.mucLuong});
}

class DeleteMucLuong extends MucLuongEvent {
  final int id;

  DeleteMucLuong({required this.id});
}
