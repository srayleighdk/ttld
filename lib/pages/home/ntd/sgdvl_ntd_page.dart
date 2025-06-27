import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/blocs/dn_dk_pgd/dn_dk_pgd_bloc.dart';
import 'package:ttld/blocs/dn_dk_pgd/dn_dk_pgd_event.dart';
import 'package:ttld/blocs/dn_dk_pgd/dn_dk_pgd_state.dart';
import 'package:ttld/blocs/sgdvl/sgdvl_bloc.dart';
import 'package:ttld/blocs/sgdvl/sgdvl_event.dart';
import 'package:ttld/blocs/sgdvl/sgdvl_state.dart';
import 'package:ttld/blocs/tblNhaTuyenDung/ntd_bloc.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/models/dn_dk_pgd/dn_dk_pgd_model.dart';
import 'package:ttld/models/sgdvl/sgdvl_model.dart';
import 'package:ttld/widgets/logout_button.dart';

class SGDVLNTDPage extends StatefulWidget {
  const SGDVLNTDPage({super.key});

  static const String routePath = '/sgdvl';

  @override
  State<SGDVLNTDPage> createState() => _SGDVLNTDPageState();
}

class _SGDVLNTDPageState extends State<SGDVLNTDPage> {
  late final SGDVLBloc _sgdvlBloc;
  late final DnDkPgdBloc _dnDkPgdBloc;
  late final NTDBloc _ntdBloc;
  late final AuthBloc _authBloc;
  String? currentUserId;
  List<SGDVL> availableSessions = [];
  List<DnDkPgd> registeredSessions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _sgdvlBloc = locator<SGDVLBloc>();
    _dnDkPgdBloc = locator<DnDkPgdBloc>();
    _ntdBloc = locator<NTDBloc>();
    _authBloc = locator<AuthBloc>();

    _loadUserData();
    _loadSGDVLData();
  }

  void _loadUserData() {
    final authState = _authBloc.state;
    if (authState is AuthAuthenticated && authState.userType == 'ntd') {
      currentUserId = authState.userId;
      _ntdBloc.add(NTDFetchById(int.parse(currentUserId!)));
    }
  }

  void _loadSGDVLData() {
    _sgdvlBloc.add(LoadSGDVLs());
    _dnDkPgdBloc.add(GetDnDkPgdList());
  }

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'Chưa có';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    } catch (e) {
      return 'Chưa có';
    }
  }

  String _getStatusText(bool? isApproved) {
    if (isApproved == null) return 'Chờ xử lý';
    return isApproved ? 'Đã duyệt' : 'Chờ duyệt';
  }

  Color _getStatusColor(bool? isApproved) {
    if (isApproved == null) return Colors.orange;
    return isApproved ? Colors.green : Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'Sàn Giao Dịch Việc Làm',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: theme.colorScheme.surface,
        scrolledUnderElevation: 1.0,
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
        actions: [
          LogoutButton(),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF4A6FFF).withAlpha(25),
              theme.colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              _loadSGDVLData();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeaderCard(theme),
                    const SizedBox(height: 16),
                    _buildActionButtons(theme),
                    const SizedBox(height: 16),
                    _buildAvailableSessionsSection(theme),
                    const SizedBox(height: 24),
                    _buildRegisteredSessionsSection(theme),
                    const SizedBox(height: 100), // Bottom padding for navbar
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4A6FFF), Color(0xFF2E5CFF)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A6FFF).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
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
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  FontAwesomeIcons.buildingUser,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sàn Giao Dịch Việc Làm',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tham gia các phiên giao dịch việc làm',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          BlocBuilder<NTDBloc, NTDState>(
            bloc: _ntdBloc,
            builder: (context, state) {
              if (state is NTDLoadedById && state.ntd != null) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.building,
                        color: Colors.white.withOpacity(0.8),
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Doanh nghiệp: ${state.ntd!.ntdTen ?? 'Chưa có tên'}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            theme,
            'Làm Mới Dữ Liệu',
            FontAwesomeIcons.arrowsRotate,
            Colors.blue,
            () {
              _loadSGDVLData();
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionButton(
            theme,
            'Quản Lý Tuyển Dụng',
            FontAwesomeIcons.briefcase,
            Colors.green,
            () {
              context.push('/ntd_home/quan-ly-tuyen-dung');
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
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
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
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
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableSessionsSection(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.calendar,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Phiên Giao Dịch Hiện Có',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<SGDVLBloc, SGDVLState>(
            bloc: _sgdvlBloc,
            builder: (context, state) {
              if (state is SGDVLLoading) {
                return const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state is SGDVLError) {
                return _buildErrorSection(
                    theme, 'Có lỗi xảy ra', state.message);
              }

              if (state is SGDVLLoaded) {
                availableSessions = state.sgdvls;

                if (availableSessions.isEmpty) {
                  return _buildEmptySection(
                    theme,
                    'Chưa có phiên giao dịch',
                    'Hiện tại chưa có phiên giao dịch việc làm nào được tổ chức.',
                    FontAwesomeIcons.calendar,
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: availableSessions.length,
                  itemBuilder: (context, index) {
                    final session = availableSessions[index];
                    return _buildSessionCard(theme, session, false);
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRegisteredSessionsSection(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.listCheck,
                  color: theme.colorScheme.secondary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Phiên Đã Đăng Ký',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<DnDkPgdBloc, DnDkPgdState>(
            bloc: _dnDkPgdBloc,
            builder: (context, state) {
              if (state is DnDkPgdLoading) {
                return const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state is DnDkPgdError) {
                return _buildErrorSection(
                    theme, 'Có lỗi xảy ra', state.message);
              }

              if (state is DnDkPgdListLoaded) {
                // Filter registrations for current user
                registeredSessions = state.dnDkPgdList.where((registration) {
                  return registration.idDoanhnghiep == currentUserId;
                }).toList();

                if (registeredSessions.isEmpty) {
                  return _buildEmptySection(
                    theme,
                    'Chưa đăng ký phiên nào',
                    'Bạn chưa đăng ký tham gia phiên giao dịch việc làm nào.',
                    FontAwesomeIcons.handshake,
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: registeredSessions.length,
                  itemBuilder: (context, index) {
                    final registration = registeredSessions[index];
                    return _buildRegistrationCard(theme, registration);
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSessionCard(ThemeData theme, SGDVL session, bool isRegistered) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  FontAwesomeIcons.calendar,
                  color: theme.colorScheme.primary,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  session.pgdTen,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                FontAwesomeIcons.clock,
                size: 14,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(width: 8),
              Text(
                'Ngày: ${_formatDate(session.pgdNgay)}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(width: 16),
              Icon(
                FontAwesomeIcons.clock,
                size: 14,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(width: 8),
              Text(
                'Giờ: ${session.pgdGio}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
          if (session.pgdDiadiem.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.locationDot,
                  size: 14,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Địa chỉ: ${session.pgdDiadiem}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (!isRegistered) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  _showRegistrationDialog(session);
                },
                icon: const Icon(FontAwesomeIcons.plus, size: 16),
                label: const Text('Đăng Ký Tham Gia'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRegistrationCard(ThemeData theme, DnDkPgd registration) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getStatusColor(registration.dksgdDuyet).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color:
                      _getStatusColor(registration.dksgdDuyet).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  _getStatusText(registration.dksgdDuyet),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: _getStatusColor(registration.dksgdDuyet),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                _formatDate(registration.createdDate?.toString()),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (registration.dksgdTen != null) ...[
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.building,
                  size: 14,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    registration.dksgdTen!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
          if (registration.dksgdNguoilienhe != null) ...[
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.user,
                  size: 14,
                  color: theme.colorScheme.secondary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Người liên hệ: ${registration.dksgdNguoilienhe}',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
          if (registration.dksgdDienthoai != null) ...[
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.phone,
                  size: 14,
                  color: theme.colorScheme.tertiary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Điện thoại: ${registration.dksgdDienthoai}',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptySection(
    ThemeData theme,
    String title,
    String message,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 48,
            color: theme.colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorSection(ThemeData theme, String title, String message) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.triangleExclamation,
            size: 48,
            color: theme.colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showRegistrationDialog(SGDVL session) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Đăng Ký Tham Gia'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bạn có muốn đăng ký tham gia phiên giao dịch:'),
              const SizedBox(height: 8),
              Text(
                session.pgdTen,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Ngày: ${_formatDate(session.pgdNgay)}'),
              Text('Giờ: ${session.pgdGio}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _registerForSession(session);
              },
              child: Text('Đăng Ký'),
            ),
          ],
        );
      },
    );
  }

  void _registerForSession(SGDVL session) {
    final authState = _authBloc.state;
    if (authState is AuthAuthenticated) {
      // Create a new DnDkPgd registration
      final registration = DnDkPgd(
        idDoanhnghiep: authState.userId,
        dksgdHienthi: true,
        dksgdDuyet: false,
        // dksgdUsername: authState.userName,
        // dksgdDuyet: false, // Initially not approved
        // Add other required fields based on your model
      );

      _dnDkPgdBloc.add(CreateDnDkPgd(registration));

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã gửi đăng ký tham gia phiên giao dịch'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
