import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/features/ds-ld/repositories/ld_repository.dart';
import 'package:ttld/pages/baocaohoatdong/baocaohoatdong_page.dart';
import 'package:ttld/pages/danhmuc/danhmuc_page.dart';
import 'package:ttld/pages/doisoatmau/doisoatmau_page.dart';
import 'package:ttld/pages/error/error.dart';
import 'package:ttld/pages/forgot_password/forgot_password.dart';
import 'package:ttld/pages/giaiquyetvieclam/giaiquyetvieclam_page.dart';
import 'package:ttld/pages/home/admin/admin_home.dart';
import 'package:ttld/pages/home/admin/system/manager_groups.dart';
import 'package:ttld/pages/home/home_page.dart';
import 'package:ttld/pages/home/ntd/ntd_home.dart';
import 'package:ttld/pages/home/ntd/update_ntd/update_ntd_page.dart';
import 'package:ttld/pages/home/ntv/ntv_form_screen.dart';
import 'package:ttld/pages/home/ntv/ntv_home.dart';
import 'package:ttld/pages/hosochapnoi/hosochapnoi_page.dart';
import 'package:ttld/pages/hosocoquan/hosocoquan_page.dart';
import 'package:ttld/pages/hosodoangnghiep/hosodoangnghiep_page.dart';
import 'package:ttld/pages/hosonguoilaodong/hosonguoilaodong_page.dart';
import 'package:ttld/pages/hosonhatuyendung/hosontd_page.dart';
import 'package:ttld/pages/hosoungvien/hosoungvien_page.dart';
import 'package:ttld/pages/laodongkhuyettat/laodongkhuyettat_page.dart';
import 'package:ttld/pages/loghethong/loghethong_page.dart';
import 'package:ttld/pages/login/login_page.dart';
import 'package:ttld/pages/phanquyen/phanquyen_page.dart';
import 'package:ttld/pages/quantridulieu/quantridulieu_page.dart';
import 'package:ttld/pages/quantringuoidung/quantringuoidung_page.dart';
import 'package:ttld/pages/signup/signup.dart';
import 'package:ttld/pages/splash/spash_page.dart';
import 'package:ttld/pages/theodoivieclam/theodoivieclam_page.dart';

class AppRouter {
  final AuthBloc authBloc;
  final LdRepository ldRepository;

  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  AppRouter({required this.authBloc, required this.ldRepository});

  late final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (BuildContext context, GoRouterState state) {
      debugPrint('🚦 Redirect - Current location: ${state.matchedLocation}');
      debugPrint('🚦 Auth State: ${authBloc.state.runtimeType}');

      final authState = authBloc.state;
      final isGoingToLogin = state.matchedLocation == '/login';
      final isGoingToSignup = state.matchedLocation == '/signup';
      final isGoingToSplash = state.matchedLocation == '/splash';
      final isGoingToForgotPassword =
          state.matchedLocation == '/forgot_password';

      // If not authenticated and not going to auth pages, redirect to login
      if (authState is! AuthAuthenticated &&
          !isGoingToLogin &&
          !isGoingToSignup &&
          !isGoingToSplash &&
          !isGoingToForgotPassword) {
        debugPrint('🔄 Redirecting to login - Not authenticated');
        return '/login';
      }

      // If authenticated and going to auth pages, redirect to appropriate dashboard
      if (authState is AuthAuthenticated &&
          (isGoingToLogin || isGoingToSignup)) {
        debugPrint('🔄 Redirecting to dashboard - Already authenticated');
        print(authState.userType);
        if (authState.isAdmin) {
          return AdminHomePage.routePath;
        } else if (!authState.isAdmin && authState.userType == 'ntv') {
          return NTVHomePage.routePath;
        } else if (!authState.isAdmin && authState.userType == 'ntd') {
          return NTDHomePage.routePath;
        }
        return ErrorPage.routePath;
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
            AdminHomePage.routePath;
          }
          return '/login';
        },
      ),
      GoRoute(
        path: '/log-he-thong',
        builder: (context, state) =>
            const LogHeThongPage(), // Replace with your page
      ),
      GoRoute(
        path: '/phan-quyen',
        builder: (context, state) =>
            const PhanQuyenPage(), // Replace with your page
      ),
      GoRoute(
        path: '/quan-tri-du-lieu',
        builder: (context, state) =>
            const QuanTriDuLieuPage(), // Replace with your page
      ),
      GoRoute(
        path: '/quan-tri-nguoi-dung',
        builder: (context, state) =>
            const QuanTriNguoiDungPage(), // Replace with your page
      ),
      GoRoute(
        path: '/danh-muc-1',
        builder: (context, state) =>
            const DanhMuc1Page(), // Replace with your page
      ),
      GoRoute(
        path: '/danh-muc-2',
        builder: (context, state) =>
            const DanhMuc2Page(), // Replace with your page
      ),
      GoRoute(
        path: '/ho-so-co-quan',
        builder: (context, state) =>
            const HoSoCoQuanPage(), // Replace with your page
      ),
      GoRoute(
        path: '/ho-so-nguoi-lao-dong',
        builder: (context, state) =>
            const HoSoNguoiLaoDongPage(), // Replace with your page
      ),
      GoRoute(
        path: '/ho-so-nha-tuyen-dung',
        builder: (context, state) =>
            const HoSoNTDPage(), // Replace with your page
      ),
      GoRoute(
        path: '/theo-doi-viec-lam',
        builder: (context, state) =>
            const TheoDoiViecLamPage(), // Replace with your page
      ),
      GoRoute(
        path: '/lao-dong-khuyet-tat',
        builder: (context, state) =>
            const LaoDongKhuyetTatPage(), // Replace with your page
      ),
      GoRoute(
        path: '/doi-soat-mau',
        builder: (context, state) =>
            const DoiSoatMauPage(), // Replace with your page
      ),
      GoRoute(
        path: '/bao-cao-hoat-dong',
        builder: (context, state) =>
            const BaoCaoHoatDongPage(), // Replace with your page
      ),
      GoRoute(
        path: '/ho-so-ung-vien',
        builder: (context, state) =>
            const HoSoUngVienPage(), // Replace with your page
      ),
      GoRoute(
        path: '/ho-so-doanh-nghiep',
        builder: (context, state) =>
            const HoSoDoanhNghiepPage(), // Replace with your page
      ),
      GoRoute(
        path: '/ho-so-chap-noi',
        builder: (context, state) =>
            const HoSoChapNoiPage(), // Replace with your page
      ),
      GoRoute(
        path: '/giai-quyet-viec-lam',
        builder: (context, state) =>
            const GiaiQuyetViecLamPage(), // Replace with your page
      ),
      // Auth routes
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/forgot_password',
        name: 'forgot_password',
        builder: (context, state) => const ForgetPasswordScreen(),
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
      GoRoute(
          path: '/ntv_home',
          builder: (BuildContext context, GoRouterState state) =>
              const NTVHomePage(), // Create NtvHomePage widget
          routes: [
            GoRoute(
              path: '/manager-group',
              builder: (context, state) => const NTVFormScreen(),
            ),
          ]),

      GoRoute(
        path: '/ntd_home',
        builder: (BuildContext context, GoRouterState state) =>
            const NTDHomePage(),
      ),
      GoRoute(
        path: UpdateNTDPage.routePath,
        builder: (context, state) => UpdateNTDPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) =>
            const HomePage(),
      ),
      GoRoute(
        path: '/error', // Default home route
        builder: (BuildContext context, GoRouterState state) =>
            const ErrorPage(),
      ),
    ],
  );

  // static void navigateBasedOnUserType(BuildContext context, UserType userType) {
  //   switch (userType) {
  //     case UserType.admin:
  //       context.go(AdminHomePage.routePath);
  //       break;
  //     case UserType.ntv:
  //     case UserType.ntd:
  //       context.go('/home');
  //       break;
  //   }
  // }
}

// class HoSoNguoiLaoDongPage {
//   const HoSoNguoiLaoDongPage();
// }
//
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
