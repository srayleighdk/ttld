import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/features/ds-ld/repositories/ld_repository.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';
import 'package:ttld/pages/baocaohoatdong/baocaohoatdong_page.dart';
import 'package:ttld/pages/danhmuc/danhmuc_page.dart';
import 'package:ttld/pages/doisoatmau/doisoatmau_page.dart';
import 'package:ttld/pages/error/error.dart';
import 'package:ttld/pages/forgot_password/forgot_password.dart';
import 'package:ttld/pages/giaiquyetvieclam/giaiquyetvieclam_page.dart';
import 'package:ttld/pages/home/admin/admin_home.dart';
import 'package:ttld/pages/home/home_page.dart';
import 'package:ttld/pages/home/ntd/ntd_home.dart';
import 'package:ttld/pages/home/ntd/update_ntd/update_ntd_page.dart';
import 'package:ttld/pages/home/ntv/ntv_home.dart';
import 'package:ttld/pages/home/ntv/update_ntv/update_ntv_page.dart';
import 'package:ttld/pages/hosochapnoi/hosochapnoi_page.dart';
import 'package:ttld/pages/hosocoquan/hosocoquan_page.dart';
import 'package:ttld/pages/hosodoangnghiep/hosodoangnghiep_page.dart';
import 'package:ttld/pages/hosonguoilaodong/hosonguoilaodong_page.dart';
import 'package:ttld/pages/hosonhatuyendung/hosontd_page.dart';
import 'package:ttld/pages/hosoungvien/create_hoso_ungvien.dart';
import 'package:ttld/pages/hosoungvien/hosoungvien_page.dart';
import 'package:ttld/pages/laodongkhuyettat/laodongkhuyettat_page.dart';
import 'package:ttld/pages/loghethong/loghethong_page.dart';
import 'package:ttld/pages/login/login_page.dart';
import 'package:ttld/pages/m01tt11/m01tt11.dart';
import 'package:ttld/pages/phanquyen/phanquyen_page.dart';
import 'package:ttld/pages/quantridulieu/quantridulieu_page.dart';
import 'package:ttld/pages/quantringuoidung/quantringuoidung_page.dart';
import 'package:ttld/pages/signup/signup.dart';
import 'package:ttld/pages/splash/spash_page.dart';
import 'package:ttld/pages/theodoivieclam/theodoivieclam_page.dart';
import 'package:ttld/pages/thuThapCauLaoDong/m03pli.dart';

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
    // redirect: (context, state) {
    //   if (authBloc.state is! AuthAuthenticated) {
    //     return '/login';
    //   }
    //   return null;
    // },
    redirect: (context, state) {
      final authState = authBloc.state;
      debugPrint(
          '🔄 Redirect check: ${authState.runtimeType}, Location: ${state.uri}');
      if (authState is AuthUnauthenticated &&
          state.uri.toString() != '/login') {
        return '/login';
      }
      if (authState is AuthAuthenticated && state.uri.toString() == '/login') {
        return '/home';
      }
      return null;
    },
    routes: [
      // Root route with redirect
      GoRoute(
        path: '/',
        redirect: (context, state) => '/login',
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
        routes: [
          GoRoute(
            path: '/create-hoso-ungvien',
            builder: (context, state) => const CreateHoSoUngVienPage(),
          )
        ],
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
              NTVHomePage(), // Create NtvHomePage widget
          routes: [
            GoRoute(
              path: '/update_ntv',
              builder: (context, state) => UpdateNTVPage(
                hoSoUngVien: state.extra as TblHoSoUngVienModel?,
              ),
            ),
          ]),

      GoRoute(
        path: '/ntd_home',
        builder: (BuildContext context, GoRouterState state) =>
            const NTDHomePage(),
        routes: [
          GoRoute(
            path: '/update_ntd',
            builder: (context, state) => const UpdateNTDPage(),
          ),
          GoRoute(
            path: DangKySuDungLaoDong03PLI.routePath,
            builder: (context, state) => DangKySuDungLaoDong03PLI(
              ntd: state.extra as Ntd?,
            ),
          ),
          GoRoute(
              path: '/m01tt11',
              builder: (context, state) => M01TT11Page(
                    ntd: state.extra as Ntd?,
                  ))
        ],
      ),
      GoRoute(
        path: '/update_ntd',
        builder: (context, state) => const UpdateNTDPage(),
      ),
      GoRoute(
          path: '/home',
          builder: (BuildContext context, GoRouterState state) {
            debugPrint('🏠 Navigating to Home with extra: ${state.extra}');

            final userId = state.extra as String?;
            return HomePage(userId: userId);
          }),
      GoRoute(
        path: '/error', // Default home route
        builder: (BuildContext context, GoRouterState state) =>
            const ErrorPage(),
      ),
    ],
  );
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
