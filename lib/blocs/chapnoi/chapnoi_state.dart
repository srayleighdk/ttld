part of 'chapnoi_bloc.dart';

@immutable
sealed class ChapNoiState {}

final class ChapNoiInitial extends ChapNoiState {}

final class ChapNoiLoading extends ChapNoiState {}

final class ChapNoiListLoaded extends ChapNoiState {
  final List<ChapNoiModel> chapNoiList;
  final int total;

  ChapNoiListLoaded(this.chapNoiList, this.total);
}

final class ChapNoiCreated extends ChapNoiState {
   final ChapNoiModel createdChapNoi;
   final String message;

   ChapNoiCreated(this.createdChapNoi, this.message);
}

final class ChapNoiDeleted extends ChapNoiState {
   final String message;

   ChapNoiDeleted(this.message);
}

final class ChapNoiError extends ChapNoiState {
  final String message;

  ChapNoiError(this.message);
}
