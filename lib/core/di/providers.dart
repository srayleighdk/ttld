import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/login_bloc.dart';
import 'package:ttld/features/auth/repositories/auth_repository.dart';
import 'package:ttld/features/ds-ld/bloc/ld_bloc.dart';
import 'package:ttld/features/ds-ld/repositories/ld_repository.dart';
import 'package:ttld/features/ds-ld/repositories/ld_repository_impl.dart';
import 'package:ttld/features/user_group/bloc/group_bloc.dart';
import 'package:ttld/features/user_group/repository/group_repository.dart';
import 'package:ttld/pages/signup/bloc/signup_bloc.dart';

List<RepositoryProvider> getRepositoryProviders() {
  return [
    RepositoryProvider<AuthRepository>(
      create: (context) => AuthRepository(ApiClient().dio),
    ),
    RepositoryProvider<LdRepository>(
      create: (context) => LdRepositoryImpl(ApiClient().dio),
    ),
    RepositoryProvider<GroupRepository>(
      create: (context) => GroupRepository(),
    ),
  ];
}

List<BlocProvider> getBlocProviders() {
  return [
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
    ),
    BlocProvider<SignupBloc>(
      create: (context) => SignupBloc(
        authRepository: context.read<AuthRepository>(),
      ),
    ),
    BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(
        authRepository: context.read<AuthRepository>(),
        authBloc: context.read<AuthBloc>(),
      ),
    ),
    BlocProvider<LdBloc>(
      create: (context) => LdBloc(
        context.read<LdRepository>(),
      ),
    ),
    BlocProvider<GroupBloc>(
      create: (context) => GroupBloc(
        groupRepository: context.read<GroupRepository>(),
      ),
    )
  ];
}
