import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:your_app/repository/user/user_repository.dart';
import 'package:your_app/models/user/user_model.dart';

part 'user_bloc.freezed.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const UserState.initial()) {
    on<UserEvent>((event, emit) async {
      await event.map(
        fetchAllUsers: (e) => _fetchAllUsers(emit),
        fetchUserById: (e) => _fetchUserById(e, emit),
        createUser: (e) => _createUser(e, emit),
        updateUser: (e) => _updateUser(e, emit),
        deleteUser: (e) => _deleteUser(e, emit),
        fetchUserByManv: (e) => _fetchUserByManv(e, emit),
      );
    });
  }

  Future<void> _fetchAllUsers(Emitter<UserState> emit) async {
    emit(const UserState.loadInProgress());
    try {
      final users = await _userRepository.getAllUsers();
      emit(UserState.loadSuccess(users));
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }

  Future<void> _fetchUserById(FetchUserById event, Emitter<UserState> emit) async {
    emit(const UserState.loadInProgress());
    try {
      final user = await _userRepository.getUserById(event.userId);
      emit(UserState.userLoaded(user));
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }

  Future<void> _createUser(CreateUser event, Emitter<UserState> emit) async {
    emit(const UserState.loadInProgress());
    try {
      await _userRepository.createUser(event.user);
      emit(const UserState.operationSuccess());
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }

  Future<void> _updateUser(UpdateUser event, Emitter<UserState> emit) async {
    emit(const UserState.loadInProgress());
    try {
      await _userRepository.updateUser(event.user);
      emit(const UserState.operationSuccess());
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }

  Future<void> _deleteUser(DeleteUser event, Emitter<UserState> emit) async {
    emit(const UserState.loadInProgress());
    try {
      await _userRepository.deleteUser(event.userId);
      emit(const UserState.operationSuccess());
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }

  Future<void> _fetchUserByManv(FetchUserByManv event, Emitter<UserState> emit) async {
    emit(const UserState.loadInProgress());
    try {
      final user = await _userRepository.getUserByManv(event.manv);
      emit(UserState.userLoaded(user));
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }
}
