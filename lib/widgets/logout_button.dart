import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/utils/toast_utils.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_event.dart';
import 'package:ttld/features/auth/repositories/auth_repository.dart';

class LogoutButton extends StatelessWidget {
  final getIt = GetIt.instance;

  LogoutButton({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    try {
      ToastUtils.showToastSuccess(context, description: '', message: '');

      await getIt<AuthRepository>().logout();

      if (context.mounted) {
        locator<AuthBloc>().add(AuthLogout());
      }
    } catch (e) {
      if (context.mounted) {
        ToastUtils.showToastOops(
          context,
          description: e.toString(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const FaIcon(FontAwesomeIcons.rightFromBracket),
      onPressed: () => _handleLogout(context),
    );
  }
}
