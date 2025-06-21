import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/utils/toast_utils.dart';
import 'package:ttld/features/auth/bloc/login_bloc.dart';
import 'package:ttld/features/auth/bloc/login_event.dart';
import 'package:ttld/core/enums/region.dart'; // Import Region enum
import 'package:ttld/features/auth/bloc/login_state.dart';
import 'package:ttld/features/auth/enums/user_type.dart';
import 'package:ttld/helppers/help.dart';
import 'package:ttld/pages/signup/signup.dart';
import 'package:ttld/core/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

// Remove local Region enum definition

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  UserType _selectedUserType = UserType.ntd;
  Region _selectedRegion = Region.lamDong;

  @override
  void initState() {
    super.initState();
    debugPrint('LoginPage initState called.');
    _checkSession();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    final loginTimestamp = prefs.getInt('login_timestamp') ?? 0;
    final sessionDuration = Duration(hours: 24); // 24 hours

    debugPrint('[_checkSession] Retrieved isLoggedIn: $isLoggedIn');
    debugPrint('[_checkSession] Retrieved loginTimestamp: $loginTimestamp');
    debugPrint(
        '[_checkSession] Current time: ${DateTime.now().millisecondsSinceEpoch}');
    debugPrint(
        '[_checkSession] Session duration (ms): ${sessionDuration.inMilliseconds}');

    if (isLoggedIn) {
      final now = DateTime.now().millisecondsSinceEpoch;
      if (now - loginTimestamp < sessionDuration.inMilliseconds) {
        debugPrint('[_checkSession] Session is valid. Attempting navigation.');
        // Session is still valid, navigate to home
        final userId = prefs.getString('userId');
        final userType = prefs.getString('userType');
        final region = prefs.getString('selected_region');
        if (mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/home', extra: {
              'userId': userId,
              'userType': userType,
              'region': region,
            });
            debugPrint(
                '[_checkSession] Navigation to /home triggered via post-frame callback.');
          });
        } else {
          debugPrint('[_checkSession] Widget not mounted, cannot navigate.');
        }
      } else {
        debugPrint('[_checkSession] Session expired. Clearing preferences.');
        // Session expired, clear session
        await prefs.clear();
      }
    } else {
      debugPrint('[_checkSession] Not logged in (isLoggedIn is false).');
    }
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      debugPrint('📝 Login form submitted');
      // Set API base URL based on region
      String baseUrl;
      switch (_selectedRegion) {
        case Region.lamDong:
          baseUrl = getEnv('API_LAMDONG');
          break;
        case Region.binhThuan:
          baseUrl = getEnv('API_BINHTHUAN');
          break;
        case Region.binhDinh:
          baseUrl = getEnv('API_BINHDINH');
          break;
      }
      // Optionally, set the base URL in your ApiClient here
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

  Future<void> _forgotPassword(String userNameOrEmail) async {
    try {
      final response = await locator<ApiClient>().post(
        '/auth/forgot-password',
        data: {
          'userNameOrEmail': userNameOrEmail,
        },
      );

      if (response.statusCode == 200) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Yêu cầu đặt lại mật khẩu đã được gửi. Vui lòng kiểm tra email của bạn.'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        throw Exception('Không thể gửi yêu cầu đặt lại mật khẩu');
      }
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

  void _showForgotPasswordDialog() {
    final TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Dialog(
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
                'Quên Mật Khẩu',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Nhập tên đăng nhập hoặc email của bạn để nhận hướng dẫn đặt lại mật khẩu',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Tên đăng nhập hoặc Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
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
                      if (emailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Vui lòng nhập tên đăng nhập hoặc email'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
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
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text('Đang gửi yêu cầu...'),
                              ],
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }

                      // Call forgot password
                      await _forgotPassword(emailController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Gửi Yêu Cầu'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          bloc: locator<LoginBloc>(),
          listener: (context, state) async {
            debugPrint('👂 Login state changed: ${state.runtimeType}');

            if (state is LoginSuccess) {
              debugPrint(
                  '🎉 Login successful in page, navigating to /home with userId:  [38;5;246m${state.userId} [0m');
              ToastUtils.showToastSuccess(
                context,
                description: 'Welcome back!',
                message: '',
              );
              try {
                // Save region and session info to SharedPreferences
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('selected_region', _selectedRegion.name);
                await prefs.setBool('is_logged_in', true);
                await prefs.setInt(
                    'login_timestamp', DateTime.now().millisecondsSinceEpoch);
                await prefs.setString('userId', state.userId?.toString() ?? '');
                await prefs.setString(
                    'userType', state.userType?.toString() ?? '');
                context.go('/home', extra: {
                  'userId': state.userId,
                  'userType': state.userType,
                  'region': _selectedRegion,
                });
                debugPrint('🚀 Navigation to /home triggered');
              } catch (e) {
                debugPrint('❌ Navigation error: $e');
              }
            } else if (state is LoginFailure) {
              debugPrint('❌ Login failed in page: ${state.error}');
              ToastUtils.showToastOops(
                context,
                description: state.error,
              );
            }
          },
        ),
      ],
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
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
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Welcome Section
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withAlpha(25),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/icon/icon.png',
                              width: 48,
                              height: 48,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Chào mừng bạn đến với sàn giao dịch việc làm (Swork)',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Đăng nhập để tiếp tục hành trình của bạn',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color:
                                    theme.colorScheme.onSurface.withAlpha(179),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Region Dropdown
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: DropdownButtonFormField<Region>(
                          value: _selectedRegion,
                          decoration: InputDecoration(
                            labelText: 'Chọn khu vực',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          items: Region.values.map((region) {
                            return DropdownMenuItem<Region>(
                              value: region,
                              child: Text(region.displayName),
                            );
                          }).toList(),
                          onChanged: (region) {
                            if (region != null) {
                              setState(() {
                                _selectedRegion = region;
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 16),

                      // User Type Selection
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.shadow.withAlpha(13),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Chọn Loại Người Dùng',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            Center(
                              child: SizedBox(
                                width: 300, // Fixed width for the button
                                child: SegmentedButton<UserType>(
                                  segments: UserType.values
                                      .where((type) => type != UserType.admin)
                                      .map((type) {
                                    return ButtonSegment<UserType>(
                                      value: type,
                                      label: Text(
                                        type.tooltip,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  selected: {_selectedUserType},
                                  onSelectionChanged:
                                      (Set<UserType> newSelection) {
                                    setState(() {
                                      _selectedUserType = newSelection.first;
                                    });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return theme.colorScheme.primary;
                                        }
                                        return theme.colorScheme.surface;
                                      },
                                    ),
                                    foregroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return theme.colorScheme.onPrimary;
                                        }
                                        return theme.colorScheme.onSurface;
                                      },
                                    ),
                                    padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(vertical: 12),
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Login Form
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Username Field
                            Container(
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        theme.colorScheme.shadow.withAlpha(13),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: _userNameController,
                                decoration: InputDecoration(
                                  labelText: 'Tên đăng nhập',
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.user,
                                    color: theme.colorScheme.primary,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: theme.colorScheme.primary,
                                      width: 2,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: theme.colorScheme.surface,
                                  labelStyle: TextStyle(
                                    color: theme.colorScheme.onSurface
                                        .withAlpha(179),
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your username';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Password Field
                            Container(
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        theme.colorScheme.shadow.withAlpha(13),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: !_isPasswordVisible,
                                decoration: InputDecoration(
                                  labelText: 'Mật khẩu',
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.lock,
                                    color: theme.colorScheme.primary,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: theme.colorScheme.primary,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
                                      });
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: theme.colorScheme.primary,
                                      width: 2,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: theme.colorScheme.surface,
                                  labelStyle: TextStyle(
                                    color: theme.colorScheme.onSurface
                                        .withAlpha(179),
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Forgot Password
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: _showForgotPasswordDialog,
                                child: Text(
                                  'Quên mật khẩu?',
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Login Button
                            BlocBuilder<LoginBloc, LoginState>(
                              bloc: locator<LoginBloc>(),
                              builder: (context, state) {
                                return Container(
                                  height: 56,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: LinearGradient(
                                      colors: [
                                        theme.colorScheme.primary,
                                        theme.colorScheme.primary
                                            .withAlpha(204),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: theme.colorScheme.primary
                                            .withAlpha(33),
                                        blurRadius: 12,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    onPressed: state is LoginLoading
                                        ? null
                                        : _handleLogin,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: state is LoginLoading
                                        ? const SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.white),
                                            ),
                                          )
                                        : const Text(
                                            'Đăng nhập',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 24),

                            // Sign Up Link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Bạn chưa có tài khoản? ",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withAlpha(179),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    try {
                                      await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SignupPage(),
                                        ),
                                      );
                                    } catch (e) {
                                      print('Navigation error: $e');
                                    }
                                  },
                                  child: Text(
                                    'Đăng ký',
                                    style: TextStyle(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
