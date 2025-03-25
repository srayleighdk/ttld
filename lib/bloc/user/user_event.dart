part of 'user_bloc.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.fetchAllUsers() = FetchAllUsers;
  const factory UserEvent.fetchUserById(String userId) = FetchUserById;
  const factory UserEvent.createUser(UserModel user) = CreateUser;
  const factory UserEvent.updateUser(UserModel user) = UpdateUser;
  const factory UserEvent.deleteUser(String userId) = DeleteUser;
  const factory UserEvent.fetchUserByManv(String manv) = FetchUserByManv;
}
