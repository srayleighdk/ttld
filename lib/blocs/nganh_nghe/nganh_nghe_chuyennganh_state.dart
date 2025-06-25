part of 'nganh_nghe_chuyennganh_bloc.dart';

sealed class NganhNgheChuyenNganhState {}

class NganhNgheChuyenNganhInitial extends NganhNgheChuyenNganhState {}

class NganhNgheChuyenNganhLoading extends NganhNgheChuyenNganhState {}

class NganhNgheChuyenNganhLoaded extends NganhNgheChuyenNganhState {
  final List<NganhNgheChuyenNganh> nganhNgheChuyenNganhs;

  NganhNgheChuyenNganhLoaded({required this.nganhNgheChuyenNganhs});
}

class NganhNgheChuyenNganhError extends NganhNgheChuyenNganhState {
  final String message;

  NganhNgheChuyenNganhError({required this.message});
}
