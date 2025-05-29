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
import 'package:go_router/go_router.dart'; // Import go_router

class ProfilePage extends StatefulWidget {
  final String userId;
  final String userType;

  const ProfilePage({super.key, required this.userId, required this.userType});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _avatarImage;

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

  @override
  void dispose() {
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
            onTap: () {
              context.push(
                '/change_password',
                extra: {
                  'userId': widget.userId,
                  'userType': widget.userType,
                },
              );
            },
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
                    .withOpacity(0.1), // Corrected from withValues
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
