import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/ntd_tuyendung/ntd_tuyendung_model.dart';
import 'package:ttld/bloc/tuyendung/tuyendung_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/pages/home/ntd/create_tuyen_dung/create_tuyen_dung.dart';
import 'package:ttld/bloc/tblNhaTuyenDung/ntd_bloc.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';

class QuanLyTuyenDungPage extends StatefulWidget {
  final String? userId;
  QuanLyTuyenDungPage({super.key, this.userId});

  @override
  State<QuanLyTuyenDungPage> createState() => _QuanLyTuyenDungPageState();
}

class _QuanLyTuyenDungPageState extends State<QuanLyTuyenDungPage> {
  late final TuyenDungBloc _tuyenDungBloc;
  late List<NTDTuyenDung> tuyenDungList = [];

  @override
  void initState() {
    super.initState();
    _tuyenDungBloc = locator<TuyenDungBloc>();
    _refreshList();
  }

  void _refreshList() {
    _tuyenDungBloc.add(TuyenDungEvent.fetchList(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'Quản lý tuyển dụng',
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
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshList,
            tooltip: 'Làm mới danh sách',
          ),
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
                      child: BlocConsumer<TuyenDungBloc, TuyenDungState>(
                        bloc: _tuyenDungBloc,
                        listener: (context, state) {
                          state.whenOrNull(
                            loaded: (list) {
                              setState(() {
                                tuyenDungList = list;
                              });
                            },
                          );
                        },
                        builder: (context, state) {
                          return state.when(
                            initial: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            loaded: (list) => _buildDataTable(list),
                            error: (message) => Center(
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
                                    message,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: theme.colorScheme.error,
                                    ),
                                  ),
                                ],
                              ),
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
                  Icons.work_outline,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Danh sách tuyển dụng',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Quản lý các bài đăng tuyển dụng của bạn',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
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
          onPressed: () async {
            final ntdBloc = locator<NTDBloc>();

            // Check if we have the NTD data loaded
            if (ntdBloc.state is NTDLoadedById) {
              final ntd = (ntdBloc.state as NTDLoadedById).ntd;

              // Debug prints
              print(
                  'Using existing NTD data - ID: ${ntd.idDoanhNghiep}, Name: ${ntd.ntdTen}');

              if (ntd.idDoanhNghiep == null || ntd.idDoanhNghiep!.isEmpty) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text('Không tìm thấy thông tin doanh nghiệp của bạn.'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              if (!mounted) return;
              // Navigate to create page
              context.push(
                CreateTuyenDungPage.routePath,
                extra: {
                  'ntd': ntd,
                  'isEdit': false,
                },
              );
            } else {
              // Show error if NTD data is not loaded
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'Vui lòng tải lại trang để lấy thông tin doanh nghiệp.'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildDataTable(List<NTDTuyenDung> tuyenDungList) {
    final theme = Theme.of(context);

    if (tuyenDungList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 48,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'Chưa có bài đăng tuyển dụng nào',
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        dividerTheme: DividerThemeData(
          color: theme.colorScheme.outlineVariant.withOpacity(0.5),
        ),
      ),
      child: DataTable2(
        columnSpacing: 8,
        horizontalMargin: 8,
        minWidth: 600,
        smRatio: 0.5,
        lmRatio: 1.5,
        headingRowHeight: 40,
        dataRowHeight: 48,
        headingRowColor: MaterialStateProperty.all(
          theme.colorScheme.surfaceVariant.withOpacity(0.3),
        ),
        columns: [
          DataColumn2(
            label: Text(
              'Ngày đăng',
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text(
              'Tiêu đề',
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            size: ColumnSize.L,
          ),
          DataColumn2(
            label: Text(
              'Ngành nghề',
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            size: ColumnSize.M,
          ),
          DataColumn2(
            label: Text(
              'Trạng thái',
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text(
              'Thao tác',
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            size: ColumnSize.S,
          ),
        ],
        rows: tuyenDungList.map((tuyenDung) {
          final ngayNhanHoSo = tuyenDung.ngayNhanHoSo ?? '';
          final tdTieude = tuyenDung.tdTieude ?? 'Chưa có tiêu đề';
          final tenNganhnghe = tuyenDung.tenNganhnghe ?? 'Chưa có ngành nghề';
          final tdDuyet = tuyenDung.tdDuyet ?? false;
          final idTuyenDung = tuyenDung.idTuyenDung;

          return DataRow(
            cells: [
              DataCell(Text(
                _formatDate(ngayNhanHoSo),
                style: theme.textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              )),
              DataCell(Text(
                tdTieude,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              )),
              DataCell(Text(
                tenNganhnghe,
                style: theme.textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              )),
              DataCell(
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    color: tdDuyet
                        ? theme.colorScheme.primary.withOpacity(0.1)
                        : theme.colorScheme.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    tdDuyet ? 'Đã duyệt' : 'Chờ duyệt',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: tdDuyet
                          ? theme.colorScheme.primary
                          : theme.colorScheme.error,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              DataCell(Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: IconButton(
                      icon: Icon(
                        Icons.edit_outlined,
                        color: theme.colorScheme.primary,
                        size: 16,
                      ),
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: idTuyenDung != null
                          ? () => _showEditDialog(context, tuyenDung)
                          : null,
                      tooltip: 'Chỉnh sửa',
                    ),
                  ),
                  const SizedBox(width: 2),
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        color: theme.colorScheme.error,
                        size: 16,
                      ),
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: idTuyenDung != null
                          ? () => _showDeleteDialog(context, tuyenDung)
                          : null,
                      tooltip: 'Xóa',
                    ),
                  ),
                ],
              )),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _showEditDialog(BuildContext context, NTDTuyenDung tuyenDung) {
    final ntdBloc = locator<NTDBloc>();
    if (ntdBloc.state is NTDLoaded) {
      final ntdList = (ntdBloc.state as NTDLoaded).ntdList;
      final ntd = ntdList.firstWhere(
        (ntd) => ntd.idDoanhNghiep == widget.userId,
        orElse: () => Ntd(),
      );

      if (ntd.idDoanhNghiep == null || ntd.idDoanhNghiep!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Vui lòng đăng nhập lại để chỉnh sửa bài tuyển dụng.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      context.push(
        CreateTuyenDungPage.routePath,
        extra: {
          'ntd': ntd,
          'tuyenDung': tuyenDung,
          'isEdit': true,
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Không thể tải thông tin doanh nghiệp. Vui lòng thử lại.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showDeleteDialog(BuildContext context, NTDTuyenDung tuyenDung) {
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
          'Bạn có chắc chắn muốn xóa bài đăng tuyển dụng này?',
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
              _deleteTuyenDung(tuyenDung.idTuyenDung!);
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

  void _deleteTuyenDung(String id) {
    _tuyenDungBloc.add(TuyenDungEvent.delete(id, widget.userId));
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return 'Chưa có ngày';
    }
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
    } catch (e) {
      print('Error formatting date: $e');
      return 'Chưa có ngày';
    }
  }
}
