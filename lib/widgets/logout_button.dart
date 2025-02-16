import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttld/core/services/auth_service.dart';
import 'package:ttld/core/utils/toast_utils.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_event.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  Future<void> _handleLogout(BuildContext context) async {
    try {
      ToastUtils.showToastSuccess(context, description: '', message: '');

      await AuthService.clearAuth();

      if (context.mounted) {
        context.read<AuthBloc>().add(AuthLogout());
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
