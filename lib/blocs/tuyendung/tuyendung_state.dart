part of 'tuyendung_bloc.dart';

@freezed
class TuyenDungState with _$TuyenDungState {
  const factory TuyenDungState.initial() = TuyenDungInitial;
  const factory TuyenDungState.loading() = TuyenDungLoading;
  const factory TuyenDungState.loaded(
    List<NTDTuyenDung> tuyenDungList, {
    @Default(1) int currentPage,
    @Default(1) int totalPages,
    @Default(0) int totalItems,
    @Default(10) int limit,
  }) = TuyenDungLoaded;
  const factory TuyenDungState.error(String message) = TuyenDungError;
  const factory TuyenDungState.creating(NTDTuyenDung tuyenDung, { @Default(false) bool isValidated }) = CreateTuyenDungState;
}
