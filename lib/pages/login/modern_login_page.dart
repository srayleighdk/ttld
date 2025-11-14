import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/core/design_system/app_colors.dart';
import 'package:ttld/core/design_system/app_radius.dart';
import 'package:ttld/core/design_system/app_shadows.dart';
import 'package:ttld/core/design_system/app_spacing.dart';
import 'package:ttld/core/design_system/app_typography.dart';
import 'package:ttld/core/design_system/widgets/app_button.dart';
import 'package:ttld/core/design_system/widgets/app_text_field.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/enums/region.dart';
import 'package:ttld/core/utils/toast_utils.dart';
import 'package:ttld/features/auth/bloc/login_bloc.dart';
import 'package:ttld/features/auth/bloc/login_event.dart';
import 'package:ttld/features/auth/bloc/login_state.dart';
import 'package:ttld/features/auth/enums/user_type.dart';
import 'package:ttld/features/auth/repositories/auth_repository.dart';
import 'package:ttld/helppers/help.dart';
import 'package:ttld/core/api_client.dart';

class ModernLoginPage extends StatefulWidget {
  const ModernLoginPage({super.key});

  @override
  State<ModernLoginPage> createState() => _ModernLoginPageState();
}

class _ModernLoginPageState extends State<ModernLoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  UserType _selectedUserType = UserType.ntd;
  Region _selectedRegion = Region.lamDong;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _checkSession();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _checkSession() async {
    final authRepository = locator<AuthRepository>();
    final sessionDuration = Duration(hours: 24);

    if (authRepository.hasValidSession(sessionDuration: sessionDuration)) {
      final userId = authRepository.getUserId();
      final userType = authRepository.prefs.getString('userType');
      final region = authRepository.prefs.getString('selected_region');

      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go('/home', extra: {
            'userId': userId,
            'userType': userType,
            'region': region,
          });
        });
      }
    }
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      // Determine base URL based on environment
      final appEnv = getEnv('APP_ENV');
      final isDevelopment = appEnv == 'developing';

      String baseUrl;
      if (isDevelopment) {
        // Development: Always use localhost
        baseUrl = 'http://localhost:3003/api';
      } else {
        // Production: Use selected region
        switch (_selectedRegion) {
          case Region.lamDong:
            baseUrl = getEnv('API_LAMDONG');
            break;
          case Region.giaLai:
            baseUrl = getEnv('API_GIALAI');
            break;
        }
      }

      locator<ApiClient>().setBaseUrl(baseUrl);
      setEnv('API_BASE_URL', baseUrl);
      locator<LoginBloc>().add(
        LoginSubmitted(
          userName: _userNameController.text,
          password: _passwordController.text,
          userType: _selectedUserType.name,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<LoginBloc, LoginState>(
      bloc: locator<LoginBloc>(),
      listener: (context, state) async {
        if (state is LoginSuccess) {
          // Silent success - just navigate (modern UX pattern)
          final authRepository = locator<AuthRepository>();
          await authRepository.prefs
              .setString('selected_region', _selectedRegion.name);
          context.go('/home', extra: {
            'userId': state.userId,
            'userType': state.userType,
            'region': _selectedRegion,
          });
        } else if (state is LoginFailure) {
          // Show error notification - user needs to know what went wrong
          ToastUtils.showToastOops(
            context,
            description: state.error,
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA), // Match home page background
        body: Container(
          height: size.height,
          width: size.width,
          child: SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.screenPadding),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildHeader(),
                          SizedBox(height: AppSpacing.huge),
                          _buildLoginForm(),
                          SizedBox(height: AppSpacing.xxl),
                          _buildFooter(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            'assets/icon/icon.png',
            width: 64,
            height: 64,
          ),
        ),
        SizedBox(height: AppSpacing.xxl),
        Text(
          'Chào mừng trở lại',
          style: AppTypography.headlineLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppSpacing.sm),
        Text(
          'Đăng nhập để tiếp tục',
          style: AppTypography.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Container(
      padding: EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.card,
        boxShadow: AppShadows.card,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildRegionSelector(),
            SizedBox(height: AppSpacing.lg),
            _buildUserTypeSelector(),
            SizedBox(height: AppSpacing.xxl),
            AppTextField(
              controller: _userNameController,
              label: 'Tên đăng nhập',
              hint: 'Nhập tên đăng nhập',
              prefixIcon: Icon(Icons.person_outline, color: AppColors.neutral500),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập tên đăng nhập';
                }
                return null;
              },
            ),
            SizedBox(height: AppSpacing.lg),
            AppTextField.password(
              controller: _passwordController,
              label: 'Mật khẩu',
              hint: 'Nhập mật khẩu',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập mật khẩu';
                }
                if (value.length < 6) {
                  return 'Mật khẩu phải có ít nhất 6 ký tự';
                }
                return null;
              },
            ),
            SizedBox(height: AppSpacing.sm),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // TODO: Implement forgot password
                },
                child: Text(
                  'Quên mật khẩu?',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSpacing.xxl),
            BlocBuilder<LoginBloc, LoginState>(
              bloc: locator<LoginBloc>(),
              builder: (context, state) {
                return AppButton.primary(
                  text: 'Đăng nhập',
                  onPressed: _handleLogin,
                  isLoading: state is LoginLoading,
                  isFullWidth: true,
                  size: AppButtonSize.large,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegionSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Khu vực',
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: AppRadius.input,
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonFormField<Region>(
            value: _selectedRegion,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
            ),
            items: Region.values.map((region) {
              return DropdownMenuItem<Region>(
                value: region,
                child: Text(
                  region.displayName,
                  style: AppTypography.bodyMedium,
                ),
              );
            }).toList(),
            onChanged: (region) {
              if (region != null) {
                setState(() => _selectedRegion = region);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUserTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Loại người dùng',
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        Row(
          children: UserType.values
              .where((type) => type != UserType.admin)
              .map((type) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: type == UserType.ntd ? AppSpacing.sm : 0,
                        left: type == UserType.ntv ? AppSpacing.sm : 0,
                      ),
                      child: _buildUserTypeCard(type),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildUserTypeCard(UserType type) {
    final isSelected = _selectedUserType == type;
    return InkWell(
      onTap: () => setState(() => _selectedUserType = type),
      borderRadius: AppRadius.button,
      child: Container(
        padding: EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surfaceLight,
          borderRadius: AppRadius.button,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              type == UserType.ntd ? Icons.business : Icons.person,
              color: isSelected ? AppColors.textOnPrimary : AppColors.neutral500,
              size: 32,
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              type.tooltip,
              style: AppTypography.labelMedium.copyWith(
                color: isSelected ? AppColors.textOnPrimary : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Chưa có tài khoản? ',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            TextButton(
              onPressed: () => context.go('/signup'),
              child: Text(
                'Đăng ký ngay',
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.lg),
        Text(
          'Sàn giao dịch việc làm (Swork)',
          style: AppTypography.caption.copyWith(
            color: AppColors.textTertiary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
