import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/bloc/biendong/biendong_bloc.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/nhanvien/nhanvien_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuanLyNhanVienPage extends StatefulWidget {
  final String? userId;
  const QuanLyNhanVienPage({super.key, this.userId});
  static const routePath = '/ntd_home/quan-ly-nhan-vien';

  @override
  State<QuanLyNhanVienPage> createState() => _QuanLyNhanVienPageState();
}

class _QuanLyNhanVienPageState extends State<QuanLyNhanVienPage> {
  late final BienDongBloc _bienDongBloc;
  late List<NhanVien> nhanVienList = [];

  @override
  void initState() {
    super.initState();
    _bienDongBloc = locator<BienDongBloc>();
    _bienDongBloc.add(BienDongEvent.fetchList(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'Quản lý nhân viên',
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
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(theme),
                const SizedBox(height: 24),
                Expanded(
                  child: Container(
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BlocBuilder<BienDongBloc, BienDongState>(
                        bloc: _bienDongBloc,
                        builder: (context, state) {
                          if (state is BienDongLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          if (state is BienDongError) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: 48,
                                    color: theme.colorScheme.error,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    state.message,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: theme.colorScheme.error,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          if (state is BienDongLoaded) {
                            return _buildDataTable(state.nhanVienList);
                          }

                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.people_outline,
                                  size: 48,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Chưa có nhân viên nào',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.shadow.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.people,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Danh sách nhân viên',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Quản lý thông tin nhân viên của bạn',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Thêm mới'),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => context.push('/ntd_home/quan-ly-nhan-vien/create-nhan-vien'),
        ),
      ],
    );
  }

  Widget _buildDataTable(List<NhanVien> nhanVienList) {
    final theme = Theme.of(context);

    if (nhanVienList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 48,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'Chưa có nhân viên nào',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return Theme(
      data: Theme.of(context).copyWith(
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        dividerTheme: DividerThemeData(
          color: theme.colorScheme.outlineVariant.withOpacity(0.5),
        ),
      ),
      child: DataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: 1000,
        headingRowColor: MaterialStateProperty.all(
          theme.colorScheme.surfaceVariant.withOpacity(0.3),
        ),
        columns: [
          DataColumn2(
            label: Text(
              'STT',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text(
              'Họ và tên',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            size: ColumnSize.L,
          ),
          DataColumn2(
            label: Text(
              'Ngày sinh',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            size: ColumnSize.M,
          ),
          DataColumn2(
            label: Text(
              'Dân tộc',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text(
              'CMND/CCCD',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            size: ColumnSize.M,
          ),
          DataColumn2(
            label: Text(
              'Vị trí',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            size: ColumnSize.L,
          ),
          DataColumn2(
            label: Text(
              'Loại HĐLĐ',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            size: ColumnSize.M,
          ),
          DataColumn2(
            label: Text(
              'Tình trạng HĐ',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            size: ColumnSize.M,
          ),
          DataColumn2(
            label: Text(
              'Trạng thái',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text(
              'Thao tác',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            size: ColumnSize.M,
          ),
        ],
        rows: nhanVienList.asMap().entries.map((entry) {
          final index = entry.key + 1;
          final nhanVien = entry.value;
          return DataRow(
            cells: [
              DataCell(Text(
                index.toString(),
                style: theme.textTheme.bodyMedium,
              )),
              DataCell(Text(
                nhanVien.hoTenUv ?? '',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              )),
              DataCell(Text(
                nhanVien.ngaySinhUv ?? '',
                style: theme.textTheme.bodyMedium,
              )),
              DataCell(Text(
                nhanVien.danTocUv ?? '',
                style: theme.textTheme.bodyMedium,
              )),
              DataCell(Text(
                nhanVien.soCmndUv ?? '',
                style: theme.textTheme.bodyMedium,
              )),
              DataCell(Text(
                nhanVien.tenChucdanh ?? '',
                style: theme.textTheme.bodyMedium,
              )),
              DataCell(Text(
                nhanVien.loaiHDLD ?? '',
                style: theme.textTheme.bodyMedium,
              )),
              DataCell(Text(
                nhanVien.tinhtrangHd ?? '',
                style: theme.textTheme.bodyMedium,
              )),
              DataCell(
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(nhanVien.tinhtrangHd ?? '').withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    nhanVien.tinhtrangHd ?? '',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _getStatusColor(nhanVien.tinhtrangHd ?? ''),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              DataCell(Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.edit_outlined,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                    onPressed: () => _showEditDialog(context, nhanVien),
                    tooltip: 'Chỉnh sửa',
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: theme.colorScheme.error,
                      size: 20,
                    ),
                    onPressed: () => _showDeleteDialog(context, nhanVien),
                    tooltip: 'Xóa',
                  ),
                ],
              )),
            ],
          );
        }).toList(),
      ),
    );
  }

  Color _getStatusColor(String status) {
    final theme = Theme.of(context);
    switch (status.toLowerCase()) {
      case 'đang làm việc':
        return theme.colorScheme.primary;
      case 'đã nghỉ việc':
        return theme.colorScheme.error;
      case 'tạm nghỉ':
        return theme.colorScheme.tertiary;
      default:
        return theme.colorScheme.secondary;
    }
  }

  void _showEditDialog(BuildContext context, NhanVien nhanVien) {
    // TODO: Implement edit dialog
  }

  void _showDeleteDialog(BuildContext context, NhanVien nhanVien) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Xác nhận xóa',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Bạn có chắc chắn muốn xóa nhân viên này?',
          style: theme.textTheme.bodyLarge,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Hủy',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _deleteNhanVien(nhanVien.idphieu!);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
              foregroundColor: theme.colorScheme.onError,
            ),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }

  void _deleteNhanVien(String id) {
    _bienDongBloc.add(BienDongEvent.delete(id));
  }
}
