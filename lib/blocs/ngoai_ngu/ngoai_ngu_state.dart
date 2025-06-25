part of 'ngoai_ngu_cubit.dart';

class NgoaiNguState {}

class NgoaiNguInitial extends NgoaiNguState {}

class NgoaiNguLoading extends NgoaiNguState {}

class NgoaiNguLoaded extends NgoaiNguState {
  final List<NgoaiNgu> ngoaiNgus;
  NgoaiNguLoaded(this.ngoaiNgus);

}

class NgoaiNguError extends NgoaiNguState {
  final String message;
  NgoaiNguError(this.message);

}

