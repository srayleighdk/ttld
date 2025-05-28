import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http_parser/http_parser.dart';
import 'package:ttld/bloc/tblHoSoUngVien/tblHoSoUngVien_bloc.dart';
import 'package:ttld/bloc/tblHoSoUngVien/tblHoSoUngVien_state.dart';
import 'package:ttld/bloc/tblNhaTuyenDung/ntd_bloc.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/utils/toast_utils.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_event.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/features/auth/repositories/auth_repository.dart';
import 'package:ttld/helppers/help.dart';
import 'package:dio/dio.dart';

class ProfilePage extends StatefulWidget {
  final String userId;
  final String userType;

  const ProfilePage({super.key, required this.userId, required this.userType});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _avatarImage;
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _loadAvatar();
  }

  Future<void> _loadAvatar() async {
    final directory = await getApplicationDocumentsDirectory();
    final avatarPath = '${directory.path}/avatar_${widget.userId}.jpg';
    if (File(avatarPath).existsSync()) {
      setState(() {
        _avatarImage = File(avatarPath);
      });
    }
  }

  Future<void> _pickAvatar() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      try {
        // Create form data for upload
        final formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(
            pickedFile.path,
            filename: pickedFile.name,
            contentType:
                MediaType.parse('image/${pickedFile.path.split('.').last}'),
          ),
        });

        // Get the current user ID from AuthBloc
        final authState = locator<AuthBloc>().state;
        if (authState is! AuthAuthenticated) {
          throw Exception('User not authenticated');
        }

        // Determine the API endpoint based on user type
        String endpoint;
        if (widget.userType.toLowerCase() == 'ntv') {
          endpoint = '/nghiep-vu/hoso-uv-img/${authState.userId}';
        } else if (widget.userType.toLowerCase() == 'ntd') {
          endpoint = '/tttt/nha-td-img/${authState.userId}';
        } else {
          throw Exception('Invalid user type');
        }

        // Upload the image using the appropriate endpoint
        final response = await locator<ApiClient>().put(
          endpoint,
          data: formData,
        );

        if (response.statusCode == 200) {
          final data = response.data;
          final imagePath = data['imagePath']; // The path returned from backend

          // Update the avatar URL in AuthBloc state
          if (mounted) {
            locator<AuthBloc>().add(AuthUpdateAvatar(imagePath));

            // Verify the state was updated
            final currentState = locator<AuthBloc>().state;
            if (currentState is AuthAuthenticated) {
              debugPrint(
                  'Current auth state avatar URL: ${currentState.avatarUrl}');
            }
          }

          // Save locally for immediate display
          final directory = await getApplicationDocumentsDirectory();
          final avatarPath = '${directory.path}/avatar_${widget.userId}.jpg';
          final savedImage = await File(pickedFile.path).copy(avatarPath);
          setState(() {
            _avatarImage = savedImage;
          });

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Avatar updated successfully'),
                backgroundColor: Colors.green,
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to upload avatar: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  void _showChangePasswordDialog() {
    // Reset controllers and visibility flags
    _oldPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
    setState(() {
      _obscureOldPassword = true;
      _obscureNewPassword = true;
      _obscureConfirmPassword = true;
    });

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Đổi Mật Khẩu',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _oldPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Mật Khẩu Hiện Tại',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureOldPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setStateDialog(() {
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
                          _obscureNewPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setStateDialog(() {
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
                          _obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setStateDialog(() {
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
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Hủy'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () async {
                          if (_newPasswordController.text.isEmpty ||
                              _oldPasswordController.text.isEmpty ||
                              _confirmPasswordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Vui lòng điền đầy đủ thông tin'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          if (_newPasswordController.text !=
                              _confirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Mật khẩu mới không khớp'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          if (_newPasswordController.text.length < 6) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Mật khẩu mới phải có ít nhất 6 ký tự'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          // Verify old password first
                          try {
                            final authState = locator<AuthBloc>().state;
                            if (authState is! AuthAuthenticated) {
                              throw Exception('Người dùng chưa đăng nhập');
                            }

                            // Close dialog first
                            Navigator.pop(context);

                            // Show loading indicator
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Text('Đang đổi mật khẩu...'),
                                    ],
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }

                            // Call change password
                            await _changePassword(
                              widget.userId,
                              _oldPasswordController.text,
                              _newPasswordController.text,
                            );
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Lỗi: ${e.toString()}'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Xác Nhận'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
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

  Future<void> _changePassword(
      String userId, String oldPassword, String newPassword) async {
    try {
      // Get the current user's token from AuthBloc
      final authState = locator<AuthBloc>().state;
      if (authState is! AuthAuthenticated) {
        throw Exception('Người dùng chưa đăng nhập');
      }

      // Make the API call with increased timeout
      final response = await locator<ApiClient>().post(
        '/auth/reset-password',
        data: {
          'token': authState.token,
          'newPassword': newPassword,
          'userId': userId, // Add userId to help backend identify the user
        },
      );

      if (response.statusCode == 200) {
        if (mounted) {
          _showSuccessSnackbar('Đổi mật khẩu thành công');
        }
      } else {
        throw Exception('Đổi mật khẩu thất bại');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception(
            'Yêu cầu đổi mật khẩu đã hết thời gian chờ. Vui lòng thử lại.');
      }
      throw Exception('Lỗi: ${e.message}');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogout(BuildContext context) async {
    try {
      ToastUtils.showToastSuccess(context, description: '', message: '');

      await locator<AuthRepository>().logout();

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
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary.withAlpha(25),
              theme.colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildProfileHeader(),
                const SizedBox(height: 16),
                _buildUserInfoSection(),
                const SizedBox(height: 16),
                _buildSettingsCards(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.primary,
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.shadow.withAlpha(26),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 65,
                  backgroundColor: theme.colorScheme.surface,
                  backgroundImage: _avatarImage != null
                      ? FileImage(_avatarImage!)
                      : (locator<AuthBloc>().state is AuthAuthenticated &&
                              (locator<AuthBloc>().state as AuthAuthenticated)
                                      .avatarUrl !=
                                  null
                          ? NetworkImage(
                              '${getEnv('URL_AVATAR')}${(locator<AuthBloc>().state as AuthAuthenticated).avatarUrl}')
                          : const AssetImage(
                              'assets/default_avatar.png')) as ImageProvider,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.shadow.withAlpha(51),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.camera_alt,
                        color: theme.colorScheme.onPrimary, size: 20),
                    onPressed: _pickAvatar,
                    constraints:
                        const BoxConstraints.tightFor(width: 40, height: 40),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoSection() {
    if (widget.userType.toLowerCase() == 'ntv') {
      return BlocBuilder<NTVBloc, NTVState>(
        // Use BlocProvider.of for NTVBloc as it's provided by HomePage
        bloc: BlocProvider.of<NTVBloc>(context),
        builder: (context, state) {
          if (state is NTVLoadedById && state.tblHoSoUngVien != null) {
            final candidate = state.tblHoSoUngVien!;
            return _buildUserInfoCard(
              name: candidate.uvHoten ?? 'Ứng Viên Chưa Biết',
              email: candidate.uvEmail ?? 'Không có email',
              type: 'Ứng Viên',
              id: widget.userId,
            );
          }
          // Show loading or initial state based on NTVBloc state
          if (state is NTVLoading) {
             return const Center(child: CircularProgressIndicator());
          }
          // Handle other states like initial or error if necessary
          return const SizedBox.shrink(); // Or an error message
        },
      );
    } else if (widget.userType.toLowerCase() == 'ntd') {
      return BlocBuilder<NTDBloc, NTDState>(
        // Use BlocProvider.of for NTDBloc as it's provided by HomePage
        bloc: BlocProvider.of<NTDBloc>(context),
        builder: (context, state) {
          if (state is NTDLoadedById) {
            final employer = state.ntd;
            return _buildUserInfoCard(
              name: employer.ntdTen ?? 'Nhà Tuyển Dụng Chưa Biết',
              email: employer.ntdEmail ?? 'Không có email',
              type: 'Nhà Tuyển Dụng',
              id: widget.userId,
            );
          }
           // Show loading or initial state based on NTDBloc state
          if (state is NTDLoading) {
             return const Center(child: CircularProgressIndicator());
          }
          // Handle other states like initial or error if necessary
          return const SizedBox.shrink(); // Or an error message
        },
      );
    } else {
      // Admin case, no specific bloc needed for user info display
      return _buildUserInfoCard(
        name: 'Quản Trị Viên',
        email: 'admin@example.com',
        type: 'Quản Trị',
        id: widget.userId,
      );
    }
  }

  Widget _buildUserInfoCard({
    required String name,
    required String email,
    required String type,
    required String id,
  }) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(26),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text(
            name,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withAlpha(25),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              type,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          _buildInfoRow(Icons.email_outlined, email),
          _buildInfoRow(Icons.badge_outlined, 'ID: $id'),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 22,
            color: theme.colorScheme.onSurface.withAlpha(179),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withAlpha(179),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCards() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSettingItem(
            icon: Icons.lock_outline,
            title: 'Đổi Mật Khẩu',
            onTap: _showChangePasswordDialog,
          ),
          const Divider(height: 1, indent: 56),
          _buildSettingItem(
            icon: Icons.notifications_outlined,
            title: 'Cài Đặt Thông Báo',
            onTap: () {
              // Navigate to notification settings
            },
          ),
          const Divider(height: 1, indent: 56),
          _buildSettingItem(
            icon: Icons.help_outline,
            title: 'Trợ Giúp & Hỗ Trợ',
            onTap: () {
              // Navigate to help & support
            },
          ),
          const Divider(height: 1, indent: 56),
          _buildSettingItem(
            icon: Icons.logout,
            title: 'Đăng Xuất',
            color: Colors.red,
            onTap: () {
              _handleLogout(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (color ?? Theme.of(context).colorScheme.primary)
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 24,
                color: color ?? Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: color ?? Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
