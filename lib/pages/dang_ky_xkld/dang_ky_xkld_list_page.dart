import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/services/hoso_xkld_api_service.dart';
import 'package:ttld/core/utils/toast_utils.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/models/hoso_xkld/hoso_xkld_model.dart';
import 'package:ttld/widgets/common/custom_app_bar.dart';

class DangKyXkldListPage extends StatefulWidget {
  const DangKyXkldListPage({super.key});

  static const String routePath = '/ntv_home/dang-ky-xkld-list';

  @override
  State<DangKyXkldListPage> createState() => _DangKyXkldListPageState();
}

class _DangKyXkldListPageState extends State<DangKyXkldListPage> {
  final HosoXkldApiService _hosoXkldService = locator<HosoXkldApiService>();

  List<HosoXKLDModel> _registrations = [];
  bool _isLoading = true;
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

      // Load registrations
      await _loadRegistrations();
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
      final result = await _hosoXkldService.getHosoXkldList(
        idUv: _userId,
        limit: 100, // Load more items for card view
        page: 1,
      );
      setState(() {
        _registrations = result['data'] as List<HosoXKLDModel>;
      });
    } catch (e) {
      print('Error loading registrations: $e');
    }
  }

  Future<void> _navigateToCreate() async {
    // Navigate to create form
    context.push('/ntv_home/dang-ky-xuat-khao-lao-dong',
        extra: _loadRegistrations);
  }

  void _navigateToEdit(HosoXKLDModel item) {
    // For now, just show details. Could navigate to edit form later
    _viewDetails(item);
  }

  void _confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc chắn muốn xóa hồ sơ XKLD này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteRegistration(id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteRegistration(String id) async {
    try {
      await _hosoXkldService.deleteHosoXkld(id);
      if (mounted) {
        ToastUtils.showSuccessToast(context, 'Xóa thành công');
        _loadRegistrations();
      }
    } catch (e) {
      if (mounted) {
        ToastUtils.showErrorToast(context, 'Lỗi xóa hồ sơ: $e');
      }
    }
  }

  void _viewDetails(HosoXKLDModel registration) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chi tiết hồ sơ XKLD'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Họ tên: ${registration.dkxkldHoten ?? 'N/A'}'),
              Text(
                  'Ngày đăng ký: ${registration.dkxkldNgay != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(registration.dkxkldNgay!)) : 'N/A'}'),
              Text(
                  'Quốc gia: ${registration.dkxklddmQuocgia?.toString() ?? 'N/A'}'),
              Text(
                  'Ngành nghề: ${registration.dkxkldNganhnghemongmuon ?? 'N/A'}'),
              Text('Điện thoại: ${registration.dkxkldDienthoai ?? 'N/A'}'),
              Text('Email: ${registration.dkxkldEmail ?? 'N/A'}'),
              Text(
                  'Đã xuất cảnh: ${registration.daXuatCanh == true ? 'Có' : 'Không'}'),
              Text(
                  'Duyệt hồ sơ: ${registration.dkxkldDuyet == true ? 'Đã duyệt' : 'Chờ duyệt'}'),
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Đăng ký XKLD',
        useGradient: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _registrations.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.fileCirclePlus,
                        size: 80,
                        color: theme.colorScheme.primary.withOpacity(0.5),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Chưa có hồ sơ XKLD nào',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Nhấn nút bên dưới để tạo hồ sơ mới',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadRegistrations,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _registrations.length,
                    itemBuilder: (context, index) {
                      final item = _registrations[index];
                      return _buildRegistrationCard(context, item, theme);
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToCreate,
        icon: const Icon(FontAwesomeIcons.plus),
        label: const Text('Tạo hồ sơ mới'),
      ),
    );
  }

  Widget _buildRegistrationCard(
      BuildContext context, HosoXKLDModel item, ThemeData theme) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _navigateToEdit(item),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      FontAwesomeIcons.plane,
                      color: theme.colorScheme.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.dkxkldHoten ?? 'Không có tên',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'ID: ${item.id ?? 'N/A'}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _navigateToEdit(item);
                      } else if (value == 'delete') {
                        _confirmDelete(item.id ?? '');
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 20),
                            SizedBox(width: 8),
                            Text('Chi tiết'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 20, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Xóa', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(height: 24),
              _buildInfoRow(
                context,
                FontAwesomeIcons.calendarDays,
                'Ngày đăng ký',
                item.dkxkldNgay != null
                    ? DateFormat('dd/MM/yyyy')
                        .format(DateTime.parse(item.dkxkldNgay!))
                    : 'Chưa có',
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                context,
                FontAwesomeIcons.globe,
                'Quốc gia',
                item.dkxklddmQuocgia?.toString() ?? 'Chưa có',
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                context,
                FontAwesomeIcons.briefcase,
                'Ngành nghề',
                item.dkxkldNganhnghemongmuon ?? 'Chưa có',
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                context,
                FontAwesomeIcons.phone,
                'Điện thoại',
                item.dkxkldDienthoai ?? 'Chưa có',
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.checkCircle,
                    size: 16,
                    color:
                        item.dkxkldDuyet == true ? Colors.green : Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Trạng thái: ',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    item.dkxkldDuyet == true ? 'Đã duyệt' : 'Chờ duyệt',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: item.dkxkldDuyet == true
                          ? Colors.green
                          : Colors.orange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      BuildContext context, IconData icon, String label, String value) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
