import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/services/bhtn_khoadaotao_api_service.dart';
import 'package:ttld/core/services/dky_hoc_nghe_api_service.dart';
import 'package:ttld/core/services/nganh_nghe_daotao_api_service.dart';
import 'package:ttld/core/utils/toast_utils.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/models/bhtn_khoadaotao/bhtn_khoadaotao_model.dart';
import 'package:ttld/models/dky_hoc_nghe/dky_hoc_nghe_model.dart';
import 'package:ttld/models/nganh_nghe_daotao.dart';
import 'package:ttld/widgets/common/custom_app_bar.dart';

class DangKyHocNgheListPage extends StatefulWidget {
  const DangKyHocNgheListPage({super.key});

  static const String routePath = '/ntv_home/dang-ky-hoc-nghe-list';

  @override
  State<DangKyHocNgheListPage> createState() => _DangKyHocNgheListPageState();
}

class _DangKyHocNgheListPageState extends State<DangKyHocNgheListPage> {
  final DkyHocNgheApiService _dkyHocNgheService =
      locator<DkyHocNgheApiService>();
  final NganhNgheDaoTaoApiService _nganhNgheService =
      locator<NganhNgheDaoTaoApiService>();
  final BhtnKhoadaotaoApiService _khoaDaoTaoService =
      locator<BhtnKhoadaotaoApiService>();

  List<DkyHocNghe> _registrations = [];
  List<NganhNgheDaoTao> _nganhNgheList = [];
  List<BhtnKhoadaotao> _khoaDaoTaoList = [];
  bool _isLoading = true;
  int _currentPage = 1;
  final int _rowsPerPage = 10;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Get user ID
      final authState = locator<AuthBloc>().state;
      if (authState is AuthAuthenticated) {
        _userId = authState.userId;
      }

      // Load all data in parallel
      await Future.wait([
        _loadRegistrations(),
        _loadNganhNghe(),
        _loadKhoaDaoTao(),
      ]);
    } catch (e) {
      if (mounted) {
        ToastUtils.showErrorToast(context, 'Lỗi tải dữ liệu: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadRegistrations() async {
    try {
      final result = await _dkyHocNgheService.getDkyHocNgheList(
        idUv: _userId,
        limit: _rowsPerPage,
        page: _currentPage,
      );
      setState(() {
        _registrations = result['data'] as List<DkyHocNghe>;
      });
    } catch (e) {
      print('Error loading registrations: $e');
    }
  }

  Future<void> _loadNganhNghe() async {
    try {
      final response = await _nganhNgheService.getNganhNgheDaoTao();
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        setState(() {
          _nganhNgheList = data
              .map((json) => NganhNgheDaoTao.fromJson(json))
              .where((item) => item.status == true)
              .toList();
        });
      }
    } catch (e) {
      print('Error loading nganh nghe: $e');
    }
  }

  Future<void> _loadKhoaDaoTao() async {
    try {
      final list = await _khoaDaoTaoService.getBhtnKhoadaotaos();
      setState(() {
        _khoaDaoTaoList = list.where((item) => item.status == true).toList();
      });
    } catch (e) {
      print('Error loading khoa dao tao: $e');
    }
  }

  Future<void> _deleteRegistration(String id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc chắn muốn xóa đăng ký này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _dkyHocNgheService.deleteDkyHocNghe(id);
        if (mounted) {
          ToastUtils.showSuccessToast(context, 'Xóa thành công');
          _loadRegistrations();
        }
      } catch (e) {
        if (mounted) {
          ToastUtils.showErrorToast(context, 'Lỗi xóa đăng ký: $e');
        }
      }
    }
  }

  void _navigateToRegister() {
    context.push('/ntv_home/dang-ky-hoc-nghe-create');
  }

  void _viewDetails(DkyHocNghe registration) {
    // TODO: Navigate to details page
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chi tiết đăng ký'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Họ tên: ${registration.hoTen}'),
              Text(
                  'Ngày đăng ký: ${DateFormat('dd/MM/yyyy').format(registration.ngaydangky)}'),
              Text('Ngành nghề: ${registration.tenNghedaotao ?? 'N/A'}'),
              Text('Cơ sở đào tạo: ${registration.tenCosodaotao ?? 'N/A'}'),
              Text('Trình độ: ${registration.trinhDoDaoTao ?? 'N/A'}'),
              Text(
                  'Duyệt đăng ký: ${registration.duyetdangky ? 'Đã duyệt' : 'Chờ duyệt'}'),
              Text(
                  'Trạng thái: ${registration.trangThai ?? 'Chưa trúng tuyển'}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String _getStatusText(DkyHocNghe registration) {
    return registration.trangThai ?? 'Chưa trúng tuyển';
  }

  String _getApprovalText(DkyHocNghe registration) {
    return registration.duyetdangky ? 'Đã duyệt' : 'Chờ duyệt';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    if (_isLoading) {
      return Scaffold(
        appBar: const CustomAppBar(
          title: 'Đăng ký học nghề',
          useGradient: true,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: CustomAppBar(
        title: 'Đăng ký học nghề',
        useGradient: true,
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.plus, size: 18),
            onPressed: _navigateToRegister,
            tooltip: 'Đăng ký mới',
          ),
        ],
      ),
      body: Container(
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 900) {
              return _buildMobileLayout(theme);
            } else {
              return _buildDesktopLayout(theme);
            }
          },
        ),
      ),
    );
  }

  Widget _buildMobileLayout(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildRegistrationsList(theme),
          const SizedBox(height: 16),
          _buildNganhNgheCard(theme),
          const SizedBox(height: 16),
          _buildKhoaDaoTaoCard(theme),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: _buildRegistrationsList(theme),
          ),
        ),
        SizedBox(
          width: 320,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
            child: Column(
              children: [
                _buildNganhNgheCard(theme),
                const SizedBox(height: 16),
                _buildKhoaDaoTaoCard(theme),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNganhNgheCard(ThemeData theme) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withAlpha(204),
                ],
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.graduationCap,
                  color: theme.colorScheme.onPrimary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Ngành nghề đào tạo',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            constraints: const BoxConstraints(maxHeight: 400),
            child: _nganhNgheList.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            FontAwesomeIcons.folderOpen,
                            size: 48,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Không có dữ liệu',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    itemCount: _nganhNgheList.length,
                    separatorBuilder: (_, __) => Divider(
                      height: 1,
                      color: theme.colorScheme.outlineVariant,
                    ),
                    itemBuilder: (context, index) {
                      final item = _nganhNgheList[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        title: Text(
                          item.nnTen,
                          style: theme.textTheme.bodyMedium,
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            item.bachoc,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildKhoaDaoTaoCard(ThemeData theme) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.secondary,
                  theme.colorScheme.secondary.withAlpha(204),
                ],
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.chalkboardTeacher,
                  color: theme.colorScheme.onSecondary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Khóa đào tạo',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            constraints: const BoxConstraints(maxHeight: 400),
            child: _khoaDaoTaoList.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            FontAwesomeIcons.folderOpen,
                            size: 48,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Không có dữ liệu',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    itemCount: _khoaDaoTaoList.length,
                    separatorBuilder: (_, __) => Divider(
                      height: 1,
                      color: theme.colorScheme.outlineVariant,
                    ),
                    itemBuilder: (context, index) {
                      final item = _khoaDaoTaoList[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            FontAwesomeIcons.school,
                            size: 16,
                            color: theme.colorScheme.onSecondaryContainer,
                          ),
                        ),
                        title: Text(
                          item.name ?? 'N/A',
                          style: theme.textTheme.bodyMedium,
                        ),
                        subtitle: Text(
                          item.ngheDaoTao?.nnTen ?? 'Trung tâm đào tạo',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationsList(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          child: Row(
            children: [
              Icon(
                FontAwesomeIcons.clipboardList,
                color: theme.colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Danh sách đăng ký',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${_registrations.length} đăng ký',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (_registrations.isEmpty)
          Container(
            padding: const EdgeInsets.all(48),
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
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    FontAwesomeIcons.folderOpen,
                    size: 64,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Chưa có đăng ký nào',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Nhấn nút "+" để tạo đăng ký mới',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ..._registrations.map((registration) => _buildRegistrationCard(registration, theme)),
      ],
    );
  }

  Widget _buildRegistrationCard(DkyHocNghe registration, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primary.withAlpha(204),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    FontAwesomeIcons.graduationCap,
                    color: theme.colorScheme.onPrimary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        registration.tenNghedaotao ?? 'N/A',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.calendar,
                            size: 12,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _formatDate(registration.ngaydangky),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: registration.duyetdangky
                        ? Colors.green.withAlpha(51)
                        : Colors.orange.withAlpha(51),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        registration.duyetdangky
                            ? FontAwesomeIcons.circleCheck
                            : FontAwesomeIcons.clock,
                        size: 12,
                        color: registration.duyetdangky ? Colors.green : Colors.orange,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _getApprovalText(registration),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: registration.duyetdangky ? Colors.green : Colors.orange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: theme.colorScheme.outlineVariant),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildInfoRow(
                  theme,
                  FontAwesomeIcons.school,
                  'Cơ sở đào tạo',
                  registration.tenCosodaotao ?? 'N/A',
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  theme,
                  FontAwesomeIcons.certificate,
                  'Trình độ',
                  registration.trinhDoDaoTao ?? 'N/A',
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  theme,
                  FontAwesomeIcons.circleInfo,
                  'Trạng thái',
                  _getStatusText(registration),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: theme.colorScheme.outlineVariant),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () => _viewDetails(registration),
                  icon: const Icon(FontAwesomeIcons.eye, size: 14),
                  label: const Text('Chi tiết'),
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () => _deleteRegistration(registration.id),
                  icon: const Icon(FontAwesomeIcons.trash, size: 14),
                  label: const Text('Xóa'),
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.error,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(ThemeData theme, IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer.withAlpha(128),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 14,
            color: theme.colorScheme.onPrimaryContainer,
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
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
