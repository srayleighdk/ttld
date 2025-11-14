import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http_parser/http_parser.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_bloc.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_state.dart';
import 'package:ttld/blocs/tblNhaTuyenDung/ntd_bloc.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/utils/toast_utils.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/widgets/common/letter_avatar.dart';
import 'package:ttld/features/auth/bloc/auth_event.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/features/auth/repositories/auth_repository.dart';
import 'package:ttld/helppers/help.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

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
    final colorScheme = theme.colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primary.withValues(alpha: 0.1),
              colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 117.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildModernProfileHeader(theme),
                const SizedBox(height: 24),
                _buildUserInfoSection(),
                // const SizedBox(height: 24),
                // _buildQuickActionsSection(theme),
                const SizedBox(height: 24),
                _buildSettingsSection(theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernProfileHeader(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            colorScheme.primary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Center(
        child: _buildAvatarSection(theme),
      ),
    );
  }

  Widget _buildAvatarSection(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    final authState = locator<AuthBloc>().state;
    String? avatarUrl;

    // Get avatar URL
    if (authState is AuthAuthenticated) {
      avatarUrl = _avatarImage != null 
          ? null  // Use local file if available
          : (authState.avatarUrl != null 
              ? '${getEnv('URL_AVATAR')}${authState.avatarUrl}' 
              : null);
    }

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 4,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: _avatarImage != null 
              ? CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  backgroundImage: FileImage(_avatarImage!),
                )
              : _buildDynamicLetterAvatar(avatarUrl),
        ),
        Positioned(
          bottom: 4,
          right: 4,
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.camera,
                color: Colors.white,
                size: 16,
              ),
              onPressed: _pickAvatar,
              constraints: const BoxConstraints.tightFor(width: 40, height: 40),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDynamicLetterAvatar(String? avatarUrl) {
    if (widget.userType.toLowerCase() == 'ntv') {
      return BlocBuilder<NTVBloc, NTVState>(
        bloc: BlocProvider.of<NTVBloc>(context),
        builder: (context, state) {
          String userName = 'Ứng Viên';
          if (state is NTVLoadedById && state.tblHoSoUngVien != null) {
            userName = state.tblHoSoUngVien!.uvHoten ?? 'Ứng Viên';
          }
          return NetworkLetterAvatar(
            name: userName,
            imageUrl: avatarUrl,
            size: 120,
            textStyle: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 1.0,
            ),
          );
        },
      );
    } else if (widget.userType.toLowerCase() == 'ntd') {
      return BlocBuilder<NTDBloc, NTDState>(
        bloc: BlocProvider.of<NTDBloc>(context),
        builder: (context, state) {
          String userName = 'Nhà Tuyển Dụng';
          if (state is NTDLoadedById) {
            userName = state.ntd.ntdTen ?? 'Nhà Tuyển Dụng';
          }
          return NetworkLetterAvatar(
            name: userName,
            imageUrl: avatarUrl,
            size: 120,
            textStyle: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 1.0,
            ),
          );
        },
      );
    } else {
      // Admin case
      return NetworkLetterAvatar(
        name: 'Quản Trị Viên',
        imageUrl: avatarUrl,
        size: 120,
        textStyle: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: 1.0,
        ),
      );
    }
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
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: FaIcon(
                  FontAwesomeIcons.idCard,
                  color: colorScheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thông Tin Tài Khoản',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      'Chi tiết thông tin cá nhân',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildModernInfoRow(FontAwesomeIcons.user, 'Họ và tên', name, theme),
          const SizedBox(height: 16),
          _buildModernInfoRow(FontAwesomeIcons.envelope, 'Email', email, theme),
          const SizedBox(height: 16),
          _buildModernInfoRow(
              FontAwesomeIcons.userTag, 'Loại tài khoản', type, theme),
          const SizedBox(height: 16),
          _buildModernInfoRow(FontAwesomeIcons.hashtag, 'ID', id, theme),
        ],
      ),
    );
  }

  Widget _buildModernInfoRow(
      IconData icon, String label, String value, ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: FaIcon(
              icon,
              size: 16,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.secondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: FaIcon(
                  FontAwesomeIcons.bolt,
                  color: colorScheme.secondary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thao Tác Nhanh',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      'Các tính năng thường dùng',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionButton(
                  theme,
                  'Cập Nhật\nHồ Sơ',
                  FontAwesomeIcons.userEdit,
                  Colors.blue,
                  () {
                    // Navigate to profile update
                    if (widget.userType.toLowerCase() == 'ntv') {
                      context.push('/update_ntv/${widget.userId}');
                    } else if (widget.userType.toLowerCase() == 'ntd') {
                      context.push('/update_ntd/${widget.userId}');
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionButton(
                  theme,
                  'Đổi Mật\nKhẩu',
                  FontAwesomeIcons.lock,
                  Colors.orange,
                  () {
                    context.push(
                      '/change_password',
                      extra: {
                        'userId': widget.userId,
                        'userType': widget.userType,
                      },
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionButton(
                  theme,
                  'Thông Báo',
                  FontAwesomeIcons.bell,
                  Colors.green,
                  () {
                    // Navigate to notifications settings
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(
    ThemeData theme,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: FaIcon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.tertiary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: FaIcon(
                  FontAwesomeIcons.gear,
                  color: colorScheme.tertiary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cài Đặt & Hỗ Trợ',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      'Quản lý tài khoản và hỗ trợ',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildModernSettingItem(
            theme,
            FontAwesomeIcons.userGear,
            'Cài Đặt Tài Khoản',
            'Quản lý thông tin cá nhân',
            Colors.blue,
            () {
              if (widget.userType.toLowerCase() == 'ntv') {
                context.push('/update_ntv/${widget.userId}');
              } else if (widget.userType.toLowerCase() == 'ntd') {
                context.push('/update_ntd/${widget.userId}');
              }
            },
          ),
          const SizedBox(height: 12),
          _buildModernSettingItem(
            theme,
            FontAwesomeIcons.shield,
            'Bảo Mật',
            'Đổi mật khẩu và cài đặt bảo mật',
            Colors.orange,
            () {
              context.push(
                '/change_password',
                extra: {
                  'userId': widget.userId,
                  'userType': widget.userType,
                },
              );
            },
          ),
          const SizedBox(height: 12),
          _buildModernSettingItem(
            theme,
            FontAwesomeIcons.bell,
            'Thông Báo',
            'Cài đặt thông báo và nhắc nhở',
            Colors.green,
            () {
              // Navigate to notification settings
            },
          ),
          const SizedBox(height: 12),
          _buildModernSettingItem(
            theme,
            FontAwesomeIcons.circleQuestion,
            'Trợ Giúp & Hỗ Trợ',
            'Hướng dẫn sử dụng và liên hệ hỗ trợ',
            Colors.purple,
            () {
              // Navigate to help & support
            },
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 12),
          _buildModernSettingItem(
            theme,
            FontAwesomeIcons.rightFromBracket,
            'Đăng Xuất',
            'Thoát khỏi tài khoản hiện tại',
            Colors.red,
            () => _showLogoutDialog(context),
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildModernSettingItem(
    ThemeData theme,
    IconData icon,
    String title,
    String subtitle,
    Color color,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDestructive
              ? color.withValues(alpha: 0.05)
              : colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDestructive
                ? color.withValues(alpha: 0.2)
                : colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: FaIcon(
                icon,
                size: 18,
                color: color,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDestructive ? color : colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDestructive
                          ? color.withValues(alpha: 0.7)
                          : colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              size: 14,
              color: isDestructive
                  ? color
                  : colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const FaIcon(
                  FontAwesomeIcons.rightFromBracket,
                  color: Colors.red,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text('Đăng Xuất'),
            ],
          ),
          content: const Text(
            'Bạn có chắc chắn muốn đăng xuất khỏi tài khoản không?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Hủy',
                style: TextStyle(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _handleLogout(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Đăng Xuất'),
            ),
          ],
        );
      },
    );
  }
}
