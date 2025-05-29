import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/utils/toast_utils.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';

class ChangePasswordPage extends StatefulWidget {
  static const String routePath = '/change_password';
  final String userId;
  final String userType; // Not directly used in this page, but passed for consistency

  const ChangePasswordPage({
    super.key,
    required this.userId,
    required this.userType,
  });

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Text(message),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(12),
      ),
    );
  }

  Future<void> _changePassword() async {
    if (_newPasswordController.text.isEmpty ||
        _oldPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ToastUtils.showToastDanger(
        context,
        title: 'Lỗi',
        description: 'Vui lòng điền đầy đủ thông tin',
      );
      return;
    }
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ToastUtils.showToastDanger(
        context,
        title: 'Lỗi',
        description: 'Mật khẩu mới không khớp',
      );
      return;
    }
    if (_newPasswordController.text.length < 6) {
      ToastUtils.showToastDanger(
        context,
        title: 'Lỗi',
        description: 'Mật khẩu mới phải có ít nhất 6 ký tự',
      );
      return;
    }

    try {
      final authState = locator<AuthBloc>().state;
      if (authState is! AuthAuthenticated) {
        throw Exception('Người dùng chưa đăng nhập');
      }

      ToastUtils.showToastInfo(
        context,
        title: 'Đang xử lý',
        description: 'Đang đổi mật khẩu...',
      );

      final response = await locator<ApiClient>().post(
        '/auth/reset-password',
        data: {
          'token': authState.token,
          'oldPassword': _oldPasswordController.text, // Assuming backend needs old password for verification
          'newPassword': _newPasswordController.text,
          'userId': widget.userId,
        },
      );

      if (response.statusCode == 200) {
        if (mounted) {
          _showSuccessSnackbar('Đổi mật khẩu thành công');
          context.pop(); // Go back to the previous page (ProfilePage)
        }
      } else {
        // Handle specific error messages from backend if available
        final errorMessage = response.data['message'] ?? 'Đổi mật khẩu thất bại';
        throw Exception(errorMessage);
      }
    } on DioException catch (e) {
      String errorMessage = 'Lỗi kết nối máy chủ';
      if (e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Yêu cầu đổi mật khẩu đã hết thời gian chờ. Vui lòng thử lại.';
      } else if (e.response != null && e.response!.data != null) {
        errorMessage = e.response!.data['message'] ?? e.response!.statusMessage ?? 'Lỗi không xác định';
      } else {
        errorMessage = e.message ?? 'Lỗi không xác định';
      }
      if (mounted) {
        ToastUtils.showToastDanger(
          context,
          title: 'Lỗi',
          description: errorMessage,
        );
      }
    } catch (e) {
      if (mounted) {
        ToastUtils.showToastDanger(
          context,
          title: 'Lỗi',
          description: e.toString(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Đổi Mật Khẩu',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.colorScheme.onSurface),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Vui lòng nhập mật khẩu hiện tại và mật khẩu mới của bạn.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withAlpha(179),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _oldPasswordController,
              decoration: InputDecoration(
                labelText: 'Mật Khẩu Hiện Tại',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureOldPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureOldPassword = !_obscureOldPassword;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              obscureText: _obscureOldPassword,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                labelText: 'Mật Khẩu Mới',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureNewPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureNewPassword = !_obscureNewPassword;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              obscureText: _obscureNewPassword,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Xác Nhận Mật Khẩu Mới',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              obscureText: _obscureConfirmPassword,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _changePassword,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
              ),
              child: Text(
                'Đổi Mật Khẩu',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.pop(),
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.onSurface.withAlpha(179),
              ),
              child: Text(
                'Hủy',
                style: theme.textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
