import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';

abstract class NTVEvent extends Equatable {
  const NTVEvent();

  @override
  List<Object> get props => [];
}

class LoadTblHoSoUngViens extends NTVEvent {}

class LoadTblHoSoUngViensByIdDn extends NTVEvent {
  final String idDn;
  const LoadTblHoSoUngViensByIdDn(this.idDn);
  @override
  List<Object> get props => [idDn];
}

class LoadTblHoSoUngVien extends NTVEvent {
  final int id;
  const LoadTblHoSoUngVien(this.id);
  @override
  List<Object> get props => [id];
}

class LoadTblHoSoUngVienByUvId extends NTVEvent {
  final String uvId;
  const LoadTblHoSoUngVienByUvId(this.uvId);
  @override
  List<Object> get props => [uvId];
}

class AddTblHoSoUngVien extends NTVEvent {
  final TblHoSoUngVienModel tblHoSoUngVien;

  const AddTblHoSoUngVien(this.tblHoSoUngVien);

  @override
  List<Object> get props => [tblHoSoUngVien];
}

class UpdateTblHoSoUngVien extends NTVEvent {
  // final TblHoSoUngVienModel tblHoSoUngVien;
  final String id;
  final FormData formData;

  const UpdateTblHoSoUngVien(this.id, this.formData);

  @override
  List<Object> get props => [formData];
}

class DeleteTblHoSoUngVien extends NTVEvent {
  final int id;

  const DeleteTblHoSoUngVien(this.id);

  @override
  List<Object> get props => [id];
}
