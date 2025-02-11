import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/core/services/auth_service.dart';
import 'package:ttld/core/utils/toast_utils.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_event.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/features/auth/bloc/login_bloc.dart';
import 'package:ttld/features/auth/bloc/login_event.dart';
import 'package:ttld/features/auth/bloc/login_state.dart';
import 'package:ttld/features/auth/enums/user_type.dart';
import 'package:ttld/pages/signup/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  UserType _selectedUserType = UserType.admin; // Default value

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      debugPrint('📝 Login form submitted');
      context.read<LoginBloc>().add(
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
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            debugPrint('👂 Login state changed: ${state.runtimeType}');

            if (state is LoginSuccess) {
              debugPrint('🎉 Login successful in page');
              ToastUtils.showSuccessToast(
                context,
                message: 'Welcome back, ${state.userName}!',
              );
            } else if (state is LoginFailure) {
              debugPrint('❌ Login failed in page: ${state.error}');
              ToastUtils.showErrorToast(
                context,
                message: state.error,
              );
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            debugPrint('👂 Auth state changed: ${state.runtimeType}');

            if (state is AuthAuthenticated) {
              debugPrint('🔐 Auth state is authenticated, navigating...');
              if (state.isAdmin) {
                context.go('/admin/dashboard');
              } else {
                context.go('/dashboard');
              }
            }
          },
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Welcome Back',
                  style: theme.textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to continue',
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                SegmentedButton<UserType>(
                  segments: UserType.values.map((type) {
                    return ButtonSegment<UserType>(
                      value: type,
                      label: Text(type.displayName),
                      // icon: _getUserTypeIcon(type),
                    );
                  }).toList(),
                  selected: {_selectedUserType},
                  onSelectionChanged: (Set<UserType> newSelection) {
                    setState(() {
                      _selectedUserType = newSelection.first;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.selected)) {
                          return theme.colorScheme.primary;
                        }
                        return theme.colorScheme.surface;
                      },
                    ),
                    foregroundColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.selected)) {
                          return theme.colorScheme.onPrimary;
                        }
                        return theme.colorScheme.onSurface;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _userNameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(FontAwesomeIcons.user),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(FontAwesomeIcons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
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
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Add forgot password navigation
                          },
                          child: const Text('Forgot Password?'),
                        ),
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed:
                                state is LoginLoading ? null : _handleLogin,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: state is LoginLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(fontSize: 16),
                                  ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: theme.textTheme.bodyMedium,
                          ),
                          TextButton(
                            onPressed: () async {
                              try {
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const SignupPage(),
                                  ),
                                );
                              } catch (e) {
                                print('Navigation error: $e');
                              }
                            },
                            child: const Text('Sign Up'),
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
    );
  }
}
