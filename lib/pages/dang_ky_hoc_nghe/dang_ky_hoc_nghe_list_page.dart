import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
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
import 'package:ttld/core/design_system/widgets/app_button.dart';
import 'package:ttld/core/design_system/widgets/app_card.dart';
import 'package:ttld/core/design_system/app_spacing.dart';

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
    if (_isLoading) {
      return Scaffold(
        appBar: CustomAppBar(title: 'DANH SÁCH ĐĂNG KÝ HỌC NGHỀ'),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(
        title: 'DANH SÁCH ĐĂNG KÝ HỌC NGHỀ',
        actions: [
          Flexible(
            child: AppButton.primary(
              text: 'Đăng ký',
              size: AppButtonSize.small,
              leadingIcon: const Icon(Icons.add, size: 18),
              onPressed: _navigateToRegister,
              isFullWidth: false,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: AppButton.outline(
              text: 'Trở về',
              size: AppButtonSize.small,
              leadingIcon: const Icon(Icons.home, size: 18),
              onPressed: () => context.pop(),
              isFullWidth: false,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Use responsive layout: stack on small screens, row on large screens
          if (constraints.maxWidth < 1200) {
            // Stack layout for smaller screens
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Main content first
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: _buildMainContent(isScrollable: true),
                  ),
                  // Sidebars below
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 16, right: 8, bottom: 16),
                          child: _buildNganhNgheList(isScrollable: true),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 8, right: 16, bottom: 16),
                          child: _buildKhoaDaoTaoList(isScrollable: true),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            // Row layout for larger screens
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left sidebar - Training Occupations
                Flexible(
                  flex: 1,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 300),
                    margin: const EdgeInsets.all(16),
                    child: _buildNganhNgheList(),
                  ),
                ),
                // Main content - Table
                Expanded(
                  flex: 3,
                  child: Container(
                    margin:
                        const EdgeInsets.only(top: 16, right: 16, bottom: 16),
                    child: _buildMainContent(),
                  ),
                ),
                // Right sidebar - Training Courses
                Flexible(
                  flex: 1,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 300),
                    margin: const EdgeInsets.all(16),
                    child: _buildKhoaDaoTaoList(),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildNganhNgheList({bool isScrollable = false}) {
    return AppCard.elevated(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: isScrollable ? MainAxisSize.min : MainAxisSize.max,
        children: [
          Text(
            'DANH SÁCH NGÀNH NGHỀ ĐÀO TẠO',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.red[700],
                ),
          ),
          const SizedBox(height: AppSpacing.lg),
          isScrollable
              ? SizedBox(
                  height: 300,
                  child: _nganhNgheList.isEmpty
                      ? const Center(child: Text('Không có dữ liệu'))
                      : ListView.separated(
                          itemCount: _nganhNgheList.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final item = _nganhNgheList[index];
                            return ListTile(
                              dense: true,
                              title: Text(
                                item.nnTen,
                                style: const TextStyle(fontSize: 14),
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  item.bachoc,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            );
                          },
                        ),
                )
              : Expanded(
                  child: _nganhNgheList.isEmpty
                      ? const Center(child: Text('Không có dữ liệu'))
                      : ListView.separated(
                          itemCount: _nganhNgheList.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final item = _nganhNgheList[index];
                            return ListTile(
                              dense: true,
                              title: Text(
                                item.nnTen,
                                style: const TextStyle(fontSize: 14),
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  item.bachoc,
                                  style: const TextStyle(fontSize: 12),
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

  Widget _buildKhoaDaoTaoList({bool isScrollable = false}) {
    return AppCard.elevated(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: isScrollable ? MainAxisSize.min : MainAxisSize.max,
        children: [
          Text(
            'DANH SÁCH KHÓA ĐÀO TẠO',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.red[700],
                ),
          ),
          const SizedBox(height: AppSpacing.lg),
          isScrollable
              ? SizedBox(
                  height: 300,
                  child: _khoaDaoTaoList.isEmpty
                      ? const Center(child: Text('Không có dữ liệu'))
                      : ListView.separated(
                          itemCount: _khoaDaoTaoList.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final item = _khoaDaoTaoList[index];
                            return ListTile(
                              dense: true,
                              title: Text(
                                item.name ?? 'N/A',
                                style: const TextStyle(fontSize: 14),
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Trung tâm',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            );
                          },
                        ),
                )
              : Expanded(
                  child: _khoaDaoTaoList.isEmpty
                      ? const Center(child: Text('Không có dữ liệu'))
                      : ListView.separated(
                          itemCount: _khoaDaoTaoList.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final item = _khoaDaoTaoList[index];
                            return ListTile(
                              dense: true,
                              title: Text(
                                item.name ?? 'N/A',
                                style: const TextStyle(fontSize: 14),
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Trung tâm',
                                  style: TextStyle(fontSize: 12),
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

  Widget _buildMainContent({bool isScrollable = false}) {
    return AppCard.elevated(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: isScrollable ? MainAxisSize.min : MainAxisSize.max,
        children: [
          // Breadcrumb
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Text(
                  'HOME',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(width: 8),
                Icon(Icons.chevron_right, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text(
                  'DANH SÁCH ĐĂNG KÝ HỌC NGHỀ',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Table
          isScrollable
              ? SizedBox(
                  height: 400,
                  child: _registrations.isEmpty
                      ? const Center(child: Text('Không có dữ liệu đăng ký'))
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: PaginatedDataTable2(
                            header: const Text('Danh sách đăng ký học nghề'),
                            rowsPerPage: _rowsPerPage,
                            availableRowsPerPage: const [10, 20, 50],
                            onRowsPerPageChanged: (value) {
                              setState(() {
                                _currentPage = 1;
                              });
                              _loadRegistrations();
                            },
                            onPageChanged: (page) {
                              setState(() {
                                _currentPage = (page ~/ _rowsPerPage) + 1;
                              });
                              _loadRegistrations();
                            },
                            columnSpacing: 12,
                            horizontalMargin: 12,
                            minWidth: 800,
                            columns: const [
                              DataColumn2(
                                label: Text('Ngày'),
                                size: ColumnSize.S,
                              ),
                              DataColumn2(
                                label: Text('Ngành nghề đăng ký'),
                                size: ColumnSize.L,
                              ),
                              DataColumn2(
                                label: Text('Cơ sở đào tạo'),
                                size: ColumnSize.L,
                              ),
                              DataColumn2(
                                label: Text('Trình độ đào tạo'),
                                size: ColumnSize.M,
                              ),
                              DataColumn2(
                                label: Text('Duyệt đăng ký'),
                                size: ColumnSize.M,
                              ),
                              DataColumn2(
                                label: Text('Trạng thái'),
                                size: ColumnSize.M,
                              ),
                              DataColumn2(
                                label: Text('Thao tác'),
                                size: ColumnSize.M,
                              ),
                            ],
                            source: _RegistrationDataSource(
                              _registrations,
                              onViewDetails: _viewDetails,
                              onDelete: _deleteRegistration,
                              formatDate: _formatDate,
                              getStatusText: _getStatusText,
                              getApprovalText: _getApprovalText,
                            ),
                          ),
                        ),
                )
              : Expanded(
                  child: _registrations.isEmpty
                      ? const Center(child: Text('Không có dữ liệu đăng ký'))
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: PaginatedDataTable2(
                            header: const Text('Danh sách đăng ký học nghề'),
                            rowsPerPage: _rowsPerPage,
                            availableRowsPerPage: const [10, 20, 50],
                            onRowsPerPageChanged: (value) {
                              setState(() {
                                _currentPage = 1;
                              });
                              _loadRegistrations();
                            },
                            onPageChanged: (page) {
                              setState(() {
                                _currentPage = (page ~/ _rowsPerPage) + 1;
                              });
                              _loadRegistrations();
                            },
                            columnSpacing: 12,
                            horizontalMargin: 12,
                            minWidth: 800,
                            columns: const [
                              DataColumn2(
                                label: Text('Ngày'),
                                size: ColumnSize.S,
                              ),
                              DataColumn2(
                                label: Text('Ngành nghề đăng ký'),
                                size: ColumnSize.L,
                              ),
                              DataColumn2(
                                label: Text('Cơ sở đào tạo'),
                                size: ColumnSize.L,
                              ),
                              DataColumn2(
                                label: Text('Trình độ đào tạo'),
                                size: ColumnSize.M,
                              ),
                              DataColumn2(
                                label: Text('Duyệt đăng ký'),
                                size: ColumnSize.M,
                              ),
                              DataColumn2(
                                label: Text('Trạng thái'),
                                size: ColumnSize.M,
                              ),
                              DataColumn2(
                                label: Text('Thao tác'),
                                size: ColumnSize.M,
                              ),
                            ],
                            source: _RegistrationDataSource(
                              _registrations,
                              onViewDetails: _viewDetails,
                              onDelete: _deleteRegistration,
                              formatDate: _formatDate,
                              getStatusText: _getStatusText,
                              getApprovalText: _getApprovalText,
                            ),
                          ),
                        ),
                ),
        ],
      ),
    );
  }
}

class _RegistrationDataSource extends DataTableSource {
  final List<DkyHocNghe> registrations;
  final Function(DkyHocNghe) onViewDetails;
  final Function(String) onDelete;
  final String Function(DateTime?) formatDate;
  final String Function(DkyHocNghe) getStatusText;
  final String Function(DkyHocNghe) getApprovalText;

  _RegistrationDataSource(
    this.registrations, {
    required this.onViewDetails,
    required this.onDelete,
    required this.formatDate,
    required this.getStatusText,
    required this.getApprovalText,
  });

  @override
  DataRow getRow(int index) {
    if (index >= registrations.length) {
      return DataRow2(cells: []);
    }
    final registration = registrations[index];

    return DataRow2(
      cells: [
        DataCell(Text(formatDate(registration.ngaydangky))),
        DataCell(Text(registration.tenNghedaotao ?? 'N/A')),
        DataCell(Text(registration.tenCosodaotao ?? 'N/A')),
        DataCell(Text(registration.trinhDoDaoTao ?? 'N/A')),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: registration.duyetdangky
                  ? Colors.green[100]
                  : Colors.orange[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              getApprovalText(registration),
              style: TextStyle(
                color: registration.duyetdangky
                    ? Colors.green[800]
                    : Colors.orange[800],
                fontSize: 12,
              ),
            ),
          ),
        ),
        DataCell(Text(getStatusText(registration))),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButton.primary(
                text: 'Chi tiết',
                size: AppButtonSize.small,
                onPressed: () => onViewDetails(registration),
                isFullWidth: false,
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () => onDelete(registration.id),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                child: const Text('Xóa'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => registrations.length;

  @override
  int get selectedRowCount => 0;
}
