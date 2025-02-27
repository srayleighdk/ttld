import 'package:your_app_name/models/muc_luong_mm.dart'; // Replace with your actual import

abstract class MucLuongState {}

class MucLuongInitial extends MucLuongState {}

class MucLuongLoading extends MucLuongState {}

class MucLuongLoaded extends MucLuongState {
  final List<MucLuongMM> mucLuongs;

  MucLuongLoaded({required this.mucLuongs});
}

class MucLuongError extends MucLuongState {
  final String message;

  MucLuongError({required this.message});
}
