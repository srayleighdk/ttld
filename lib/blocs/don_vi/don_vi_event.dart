part of 'don_vi_bloc.dart';

sealed class DonViEvent {}

class LoadDonVis extends DonViEvent {}

class AddDonVi extends DonViEvent {
  final DonVi donVi;

  AddDonVi({required this.donVi});
}

class UpdateDonVi extends DonViEvent {
  final DonVi donVi;

  UpdateDonVi({required this.donVi});
}

class DeleteDonVi extends DonViEvent {
  final String madonvi;

  DeleteDonVi({required this.madonvi});
}
