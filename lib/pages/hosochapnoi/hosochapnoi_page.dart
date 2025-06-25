import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ttld/blocs/chapnoi/chapnoi_bloc.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_bloc.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_event.dart';
import 'package:ttld/models/chapnoi/chapnoi_model.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/kieuchapnoi_model.dart';
import 'package:ttld/repositories/tblNhaTuyenDung/ntd_repository.dart';
import 'package:ttld/models/tblNhaTuyenDung/ntd_picker_model.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/blocs/tuyendung/tuyendung_bloc.dart';
import 'package:ttld/pages/hosochapnoi/create_hosochapnoi_page.dart'; // Import the new page

class HoSoChapNoiPage extends StatefulWidget {
  final String? id;
  final String? uvUsername;
  final String? ntdUsername;
  const HoSoChapNoiPage(
      {super.key, this.id, this.uvUsername, this.ntdUsername});

  @override
  State<HoSoChapNoiPage> createState() => _HoSoChapNoiPageState();
}

class _HoSoChapNoiPageState extends State<HoSoChapNoiPage> {
  late TextEditingController uvUsernameController;
  late TextEditingController ntdUsernameController;
  late final ChapNoiBloc _chapNoiBloc;
  late final NTDRepository _ntdRepository;
  late final NTVBloc _ntvBloc;
  late final TuyenDungBloc _tuyenDungBloc;
  late List<ChapNoiModel> chapNoiList = [];
  late List<NTDPickerItem> ntdPickerList = [];
  int? ketQua;
  String? ngayMuonHs;
  String? ngayTraHs;
  final kieuChapNoiList = locator<List<KieuChapNoiModel>>();
  String? selectedIdTuyenDung;
  String? selectedIdDoanhNghiep;
  late final AuthBloc _authBloc; // Add AuthBloc instance

  String? _formatDate(String? dateString) {
    if (dateString == null) return null;
    try {
      final date = DateTime.parse(dateString);
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _chapNoiBloc = locator<ChapNoiBloc>();
    _ntdRepository = locator<NTDRepository>();
    _ntvBloc = locator<NTVBloc>();
    _tuyenDungBloc = locator<TuyenDungBloc>();
    _authBloc = locator<AuthBloc>(); // Initialize AuthBloc

    // Initialize controllers with empty strings by default
    uvUsernameController = TextEditingController(text: widget.uvUsername ?? '');
    ntdUsernameController =
        TextEditingController(text: widget.ntdUsername ?? '');

    // Check user type and load appropriate data
    final authState = _authBloc.state; // Use the initialized _authBloc
    if (authState is AuthAuthenticated) {
      if (authState.userType == 'ntd') {
        // If NTD is logged in, set the NTD username and load HoSoUngVien list
        ntdUsernameController.text = authState.userName;
        if (!_ntvBloc.isClosed) {
          _ntvBloc.add(LoadTblHoSoUngViens());
        }
        // Load TuyenDung list for NTD
        _tuyenDungBloc.add(TuyenDungEvent.fetchList(authState.userId));
      } else if (authState.userType == 'ntv' && widget.id != null) {
        // If NTV is logged in, load NTD list
        _fetchNtdList();
      }
    }

    // Load ChapNoi list
    _chapNoiBloc.add(ChapNoiFetchList(
      limit: 10,
      page: 1,
      status: null,
      idTuyenDung: null,
      idDoanhNghiep: null,
    ));
  }

  Future<void> _fetchNtdList() async {
    try {
      final ntds = await _ntdRepository.getNtdList(
        idUv: widget.id != null ? int.tryParse(widget.id!) : null,
      );
      setState(() {
        ntdPickerList = ntds.map((ntd) => NTDPickerItem.fromNtd(ntd)).toList();
      });
    } catch (e) {
      print('Error fetching NTD list: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authState = _authBloc.state; // Get current auth state
    final isNTD = authState is AuthAuthenticated && authState.userType == 'ntd';

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'Hồ sơ chắp nối',
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
        // actions: [
        //   LogoutButton(),
        // ],
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(theme, isNTD), // Pass isNTD to _buildHeader
                const SizedBox(height: 12.0),
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
                      child: BlocBuilder<ChapNoiBloc, ChapNoiState>(
                        bloc: _chapNoiBloc,
                        builder: (context, state) {
                          if (state is ChapNoiLoading && chapNoiList.isEmpty) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (state is ChapNoiError) {
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

                          if (state is ChapNoiListLoaded) {
                            chapNoiList = state.chapNoiList;
                          }

                          if (chapNoiList.isEmpty) {
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
                                    'Không có dữ liệu',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return Column(
                            children: [
                              Expanded(
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    cardTheme: CardThemeData(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                    ),
                                    dividerTheme: DividerThemeData(
                                      color: theme.colorScheme.outlineVariant
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                  child: DataTable2(
                                    columnSpacing: 8,
                                    horizontalMargin: 8,
                                    minWidth: 1000,
                                    headingRowColor: MaterialStateProperty.all(
                                      theme.colorScheme.surfaceVariant
                                          .withOpacity(0.3),
                                    ),
                                    columns: [
                                      DataColumn2(
                                        label: Text(
                                          'Ngày giới thiệu',
                                          style: theme.textTheme.titleSmall
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        size: ColumnSize.S,
                                      ),
                                      DataColumn2(
                                        label: Text(
                                          'Kiểu chắp nối',
                                          style: theme.textTheme.titleSmall
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        size: ColumnSize.S,
                                      ),
                                      DataColumn2(
                                        label: Text(
                                          'Ngày trả hồ sơ',
                                          style: theme.textTheme.titleSmall
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        size: ColumnSize.S,
                                      ),
                                      DataColumn2(
                                        label: Text(
                                          'Ghi chú',
                                          style: theme.textTheme.titleSmall
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        size: ColumnSize.S,
                                      ),
                                      DataColumn2(
                                        label: Text(
                                          'Kết quả',
                                          style: theme.textTheme.titleSmall
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        size: ColumnSize.S,
                                      ),
                                      DataColumn2(
                                        label: Text(
                                          'Tùy chọn',
                                          style: theme.textTheme.titleSmall
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        size: ColumnSize.S,
                                      ),
                                    ],
                                    rows: chapNoiList
                                        .map((chapNoi) => DataRow(
                                              cells: [
                                                DataCell(Text(
                                                  '${_formatDate(chapNoi.ngayMuonHs) ?? 'Chưa có'}',
                                                  style: theme
                                                      .textTheme.bodyMedium,
                                                )),
                                                DataCell(Text(
                                                  '${chapNoi.idKieuChapNoi ?? 'Chưa có'}',
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )),
                                                DataCell(Text(
                                                  '${_formatDate(chapNoi.ngayTraHs) ?? 'Chưa có'}',
                                                  style: theme
                                                      .textTheme.bodyMedium,
                                                )),
                                                DataCell(Text(
                                                  '${chapNoi.ghiChu ?? 'Không có'}',
                                                  style: theme
                                                      .textTheme.bodyMedium,
                                                )),
                                                DataCell(
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12,
                                                        vertical: 6),
                                                    decoration: BoxDecoration(
                                                      color: theme
                                                          .colorScheme.primary
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Text(
                                                      chapNoi.idKetQua == 1
                                                          ? 'Thành công'
                                                          : 'Thất bại',
                                                      style: theme
                                                          .textTheme.bodySmall
                                                          ?.copyWith(
                                                        color:
                                                            chapNoi.idKetQua ==
                                                                    1
                                                                ? theme
                                                                    .colorScheme
                                                                    .primary
                                                                : theme
                                                                    .colorScheme
                                                                    .error,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons
                                                            .visibility_outlined,
                                                        color: theme.colorScheme
                                                            .primary,
                                                        size: 20,
                                                      ),
                                                      onPressed: () =>
                                                          _showDetailsDialog(
                                                              context, chapNoi),
                                                      tooltip: 'Xem chi tiết',
                                                    ),
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.delete_outline,
                                                        color: theme
                                                            .colorScheme.error,
                                                        size: 20,
                                                      ),
                                                      onPressed: () =>
                                                          _showDeleteDialog(
                                                              context, chapNoi),
                                                      tooltip: 'Xóa',
                                                    ),
                                                  ],
                                                )),
                                              ],
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                            ],
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

  Widget _buildHeader(ThemeData theme, bool isNTD) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;

        if (isSmallScreen) {
          // Stack layout for small screens
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                      Icons.person_outline,
                      color: theme.colorScheme.primary,
                      size: 20, // Slightly smaller icon for mobile
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Danh sách hồ sơ chắp nối',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Quản lý các hồ sơ đã giới thiệu',
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
              const SizedBox(height: 12),
              if (isNTD) // Only show if NTD
                ElevatedButton.icon(
                  onPressed: () => _navigateToCreatePage(
                      context), // Navigate to the new page
                  icon: const Icon(Icons.add),
                  label: const Text('Tạo mới'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
            ],
          );
        }

        // Original layout for larger screens
        return Row(
          children: [
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                      Icons.person_outline,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Danh sách hồ sơ chắp nối',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Quản lý các hồ sơ đã giới thiệu',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            if (isNTD) // Only show if NTD
              ElevatedButton.icon(
                onPressed: () =>
                    _navigateToCreatePage(context), // Navigate to the new page
                icon: const Icon(Icons.add),
                label: const Text('Tạo mới'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void _navigateToCreatePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateHoSoChapNoiPage(
          id: widget.id,
          uvUsername: widget.uvUsername,
          ntdUsername: widget.ntdUsername,
        ),
      ),
    );
  }

  void _showDetailsDialog(BuildContext context, ChapNoiModel chapNoi) {
    // TODO: Implement details dialog
  }

  void _showDeleteDialog(BuildContext context, ChapNoiModel chapNoi) {
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
          'Bạn có chắc chắn muốn xóa hồ sơ này?',
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
              context
                  .read<ChapNoiBloc>()
                  .add(ChapNoiDelete(chapNoi.idTuyenDung));
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
}
