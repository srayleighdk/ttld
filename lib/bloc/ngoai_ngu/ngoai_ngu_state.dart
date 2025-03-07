part of 'ngoai_ngu_cubit.dart';

@freezed
class NgoaiNguState with _$NgoaiNguState {
  const factory NgoaiNguState.initial() = NgoaiNguInitial;
  const factory NgoaiNguState.loading() = NgoaiNguLoading;
  const factory NgoaiNguState.loaded(List<NgoaiNgu> data) = NgoaiNguLoaded;
  const factory NgoaiNguState.error(String message) = NgoaiNguError;
}
