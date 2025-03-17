part of 'tuyendung_bloc.dart';

@freezed
class TuyenDungState with _$TuyenDungState {
  const factory TuyenDungState.initial() = TuyenDungInitial;
  const factory TuyenDungState.loading() = TuyenDungLoading;
  const factory TuyenDungState.loaded(List<NTDTuyenDung> tuyenDungList) = TuyenDungLoaded;
  const factory TuyenDungState.error(String message) = TuyenDungError;
}
