part of 'user_bloc.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = UserInitial;
  const factory UserState.loadSuccess(List<UserModel> users) = UsersLoadSuccess;
  const factory UserState.userLoaded(UserModel user) = UserLoadSuccess;
  const factory UserState.operationSuccess() = UserOperationSuccess;
  const factory UserState.failure(String message) = UserOperationFailure;
  const factory UserState.loadInProgress() = UsersLoadInProgress;
}
