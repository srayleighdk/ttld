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
import 'package:ttld/features/auth/enums/user_type.dart';
import 'package:ttld/pages/signup/bloc/signup_bloc.dart';
import 'package:ttld/pages/signup/bloc/signup_event.dart';
import 'package:ttld/pages/signup/bloc/signup_state.dart';
import 'package:ttld/helppers/help.dart';
import 'package:ttld/core/api_client.dart';

class ModernSignupPage extends StatefulWidget {
  const ModernSignupPage({super.key});

  @override
  State<ModernSignupPage> createState() => _ModernSignupPageState();
}

class _ModernSignupPageState extends State<ModernSignupPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _maSoThueController = TextEditingController();
  
  UserType _selectedUserType = UserType.ntv;
  Region _selectedRegion = Region.lamDong;
  bool _acceptTerms = false;
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final signupBloc = locator<SignupBloc>();

  @override
  void initState() {
    super.initState();
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
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _maSoThueController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleSignup() {
    if (!_acceptTerms) {
      ToastUtils.showToastWarning(
        context,
        description: 'Vui lòng chấp nhận điều khoản và điều kiện',
      );
      return;
    }

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

      signupBloc.add(
        SignupSubmitted(
          userName: _userNameController.text,
          email: _emailController.text,
          name: _nameController.text,
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,
          userType: _selectedUserType.name,
          region: _selectedRegion.name,
          maSoThue: _maSoThueController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<SignupBloc, SignupState>(
      bloc: signupBloc,
      listener: (context, state) {
        if (state is SignupSuccess) {
          ToastUtils.showToastSuccess(
            context,
            description: 'Đăng ký thành công! Vui lòng đăng nhập.',
            message: '',
          );
          context.go('/login');
        } else if (state is SignupFailure) {
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
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.screenPadding),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: AppSpacing.xxl),
                        _buildHeader(),
                        SizedBox(height: AppSpacing.huge),
                        _buildSignupForm(),
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
          'Tạo tài khoản mới',
          style: AppTypography.headlineLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppSpacing.sm),
        Text(
          'Đăng ký để bắt đầu',
          style: AppTypography.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSignupForm() {
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
            
            // Full Name
            AppTextField(
              controller: _nameController,
              label: 'Họ và tên',
              hint: 'Nhập họ và tên đầy đủ',
              prefixIcon: Icon(Icons.person_outline, color: AppColors.neutral500),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập họ và tên';
                }
                return null;
              },
            ),
            SizedBox(height: AppSpacing.lg),
            
            // Username
            AppTextField(
              controller: _userNameController,
              label: 'Tên đăng nhập',
              hint: 'Nhập tên đăng nhập',
              prefixIcon: Icon(Icons.account_circle_outlined, color: AppColors.neutral500),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập tên đăng nhập';
                }
                if (value.length < 3) {
                  return 'Tên đăng nhập phải có ít nhất 3 ký tự';
                }
                return null;
              },
            ),
            SizedBox(height: AppSpacing.lg),
            
            // Email
            AppTextField.email(
              controller: _emailController,
              label: 'Email',
              hint: 'Nhập địa chỉ email',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'Email không hợp lệ';
                }
                return null;
              },
            ),
            SizedBox(height: AppSpacing.lg),
            
            // Tax Code (for NTD only)
            if (_selectedUserType == UserType.ntd) ...[
              AppTextField(
                controller: _maSoThueController,
                label: 'Mã số thuế',
                hint: 'Nhập mã số thuế doanh nghiệp',
                prefixIcon: Icon(Icons.business_outlined, color: AppColors.neutral500),
                validator: (value) {
                  if (_selectedUserType == UserType.ntd) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mã số thuế';
                    }
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSpacing.lg),
            ],
            
            // Password
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
            SizedBox(height: AppSpacing.lg),
            
            // Confirm Password
            AppTextField.password(
              controller: _confirmPasswordController,
              label: 'Xác nhận mật khẩu',
              hint: 'Nhập lại mật khẩu',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng xác nhận mật khẩu';
                }
                if (value != _passwordController.text) {
                  return 'Mật khẩu không khớp';
                }
                return null;
              },
            ),
            SizedBox(height: AppSpacing.lg),
            
            // Terms and Conditions
            Row(
              children: [
                Checkbox(
                  value: _acceptTerms,
                  onChanged: (value) {
                    setState(() => _acceptTerms = value ?? false);
                  },
                  activeColor: AppColors.primary,
                ),
                Expanded(
                  child: Text(
                    'Tôi đồng ý với điều khoản và điều kiện',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.xxl),
            
            // Signup Button
            BlocBuilder<SignupBloc, SignupState>(
              bloc: signupBloc,
              builder: (context, state) {
                return AppButton.primary(
                  text: 'Đăng ký',
                  onPressed: _handleSignup,
                  isLoading: state is SignupLoading,
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
          'Loại tài khoản',
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
              'Đã có tài khoản? ',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            TextButton(
              onPressed: () => context.go('/login'),
              child: Text(
                'Đăng nhập',
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
