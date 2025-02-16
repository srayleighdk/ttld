import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/features/auth/enums/user_type.dart';
import 'package:ttld/features/ds-ld/repositories/ld_repository.dart';
import 'package:ttld/pages/home/admin/admin_home.dart';
import 'package:ttld/pages/home/admin/system/manager_groups.dart';
import 'package:ttld/pages/home/home_page.dart';
import 'package:ttld/pages/home/screens/edit_profile.dart';
import 'package:ttld/pages/login/login_page.dart';
import 'package:ttld/pages/signup/signup.dart';
import 'package:ttld/pages/splash/spash_page.dart';

class AppRouter {
  final AuthBloc authBloc;
  final LdRepository ldRepository;

  AppRouter({required this.authBloc, required this.ldRepository});

  late final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (BuildContext context, GoRouterState state) {
      debugPrint('🚦 Redirect - Current location: ${state.matchedLocation}');
      debugPrint('🚦 Auth State: ${authBloc.state.runtimeType}');

      final authState = authBloc.state;
      final isGoingToLogin = state.matchedLocation == '/login';
      final isGoingToSignup = state.matchedLocation == '/signup';
      final isGoingToSplash = state.matchedLocation == '/splash';

      // If not authenticated and not going to auth pages, redirect to login
      if (authState is! AuthAuthenticated &&
          !isGoingToLogin &&
          !isGoingToSignup &&
          !isGoingToSplash) {
        debugPrint('🔄 Redirecting to login - Not authenticated');
        return '/login';
      }

      // If authenticated and going to auth pages, redirect to appropriate dashboard
      if (authState is AuthAuthenticated &&
          (isGoingToLogin || isGoingToSignup)) {
        debugPrint('🔄 Redirecting to dashboard - Already authenticated');
        return authState.isAdmin ? AdminHomePage.routePath : '/dashboard';
      }

      debugPrint('✅ No redirect needed');
      return null;
    },
    routes: [
      // Root route with redirect
      GoRoute(
        path: '/',
        redirect: (context, state) {
          final authState = authBloc.state;
          if (authState is AuthAuthenticated) {
            return authState.isAdmin ? AdminHomePage.routePath : '/home';
          }
          return '/login';
        },
      ),

      // Auth routes
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),

      GoRoute(
        path: AdminHomePage.routePath,
        builder: (context, state) => const AdminHomePage(),
      ),
      // GoRoute(
      //   path: '/ntv_home',
      //   builder: (BuildContext context, GoRouterState state) =>
      //       const NtvHomePage(), // Create NtvHomePage widget
      // ),
      // GoRoute(
      //   path: '/ntd_home',
      //   builder: (BuildContext context, GoRouterState state) =>
      //       const NtdHomePage(), // Create NtdHomePage widget
      // ),
      GoRoute(
        path: '/manager-group',
        builder: (context, state) => const ManagerUserPage(),
      ),
      GoRoute(
        path: '/home', // Default home route
        builder: (BuildContext context, GoRouterState state) =>
            const HomePage(),
      ),
    ],
  );

  static void navigateBasedOnUserType(BuildContext context, UserType userType) {
    switch (userType) {
      case UserType.admin:
        context.go(AdminHomePage.routePath);
        break;
      case UserType.ntv:
      case UserType.ntd:
        context.go('/home');
        break;
    }
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;
  final Stream<dynamic> stream;

  GoRouterRefreshStream(this.stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) {
        debugPrint('🔄 Router refresh triggered');
        notifyListeners();
      },
      onError: (error) {
        debugPrint('❌ Router refresh error: $error');
      },
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

// Add a navigation service for easier debugging
class NavigationService {
  static void goToHome(BuildContext context) {
    debugPrint('🔄 Attempting to navigate to home');
    try {
      context.goNamed('home');
      debugPrint('✅ Navigation to home successful');
    } catch (e) {
      debugPrint('❌ Navigation to home failed: $e');
    }
  }

  static void goToLogin(BuildContext context) {
    debugPrint('🔄 Attempting to navigate to login');
    try {
      context.goNamed('login');
      debugPrint('✅ Navigation to login successful');
    } catch (e) {
      debugPrint('❌ Navigation to login failed: $e');
    }
  }

  static void goToNewProfile(BuildContext context) {
    debugPrint('🔄 Attempting to navigate to new profile');
    try {
      context.goNamed('newProfile');
      debugPrint('✅ Navigation to new profile successful');
    } catch (e) {
      debugPrint('❌ Navigation to new profile failed: $e');
    }
  }

  static void goToEditProfile(BuildContext context, String? profileId) {
    debugPrint('🔄 Attempting to navigate to edit profile');
    try {
      if (profileId != null) {
        context
            .goNamed('editExistingProfile', pathParameters: {'id': profileId});
      } else {
        context.goNamed('editProfile');
      }
      debugPrint('✅ Navigation to edit profile successful');
    } catch (e) {
      debugPrint('❌ Navigation to edit profile failed: $e');
    }
  }
}
