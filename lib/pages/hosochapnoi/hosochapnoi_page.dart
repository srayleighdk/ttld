import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ttld/bloc/chapnoi/chapnoi_bloc.dart';
import 'package:ttld/helppers/map_help.dart';
import 'package:ttld/models/chapnoi/chapnoi_model.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/kieuchapnoi_model.dart';
import 'package:ttld/widgets/field/custom_pick_datetime_grok.dart';
import 'package:ttld/widgets/field/custom_picker_map.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';
import 'package:ttld/repositories/tblNhaTuyenDung/ntd_repository.dart';
import 'package:ttld/models/tblNhaTuyenDung/ntd_picker_model.dart';
import 'package:ttld/bloc/tblHoSoUngVien/tblHoSoUngVien_bloc.dart';
import 'package:ttld/bloc/tblHoSoUngVien/tblHoSoUngVien_event.dart';
import 'package:ttld/bloc/tblHoSoUngVien/tblHoSoUngVien_state.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/bloc/tuyendung/tuyendung_bloc.dart';
import 'package:ttld/models/ntd_tuyendung/ntd_tuyendung_model.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class HoSoUngVienPickerItem extends GenericPickerItem {
  final TblHoSoUngVienModel hoSoUngVien;

  HoSoUngVienPickerItem(this.hoSoUngVien)
      : super(
          id: hoSoUngVien.id,
          displayName: hoSoUngVien.uvHoten ?? hoSoUngVien.uvUsername ?? '',
        );
}

class TuyenDungPickerItem extends GenericPickerItem {
  final NTDTuyenDung tuyenDung;

  TuyenDungPickerItem(this.tuyenDung)
      : super(
          id: tuyenDung.idTuyenDung ?? '',
          displayName: tuyenDung.tdTieude ?? '',
        );
}

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

    // Initialize controllers with empty strings by default
    uvUsernameController = TextEditingController(text: widget.uvUsername ?? '');
    ntdUsernameController =
        TextEditingController(text: widget.ntdUsername ?? '');

    // Check user type and load appropriate data
    final authState = locator<AuthBloc>().state;
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
                _buildHeader(theme),
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
                                    cardTheme: CardTheme(
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

  Widget _buildHeader(ThemeData theme) {
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
              ElevatedButton.icon(
                onPressed: () => _showCreateDialog(context),
                icon: const Icon(Icons.add, size: 20),
                label: const Text('Tạo mới'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            ElevatedButton.icon(
              onPressed: () => _showCreateDialog(context),
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

  void _showCreateDialog(BuildContext context) {
    final theme = Theme.of(context);
    final TextEditingController ghiChuController = TextEditingController();
    KieuChapNoiModel? selectedKieuChapNoi;
    NTDPickerItem? selectedNTD;
    TblHoSoUngVienModel? selectedHoSoUngVien;
    String? selectedNgayMuonHs;
    String? selectedNgayTraHs;

    // Get user type from auth state
    final authState = locator<AuthBloc>().state;
    final isNTD = authState is AuthAuthenticated && authState.userType == 'ntd';

    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        child: Container(
          width: 800,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.add, color: theme.colorScheme.primary),
                  const SizedBox(width: 10),
                  Text(
                    'Tạo hồ sơ chấp nhận mới',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      elevation: 0,
                      color: Colors.grey[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Thông tin cơ bản',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            if (isNTD) ...[
                              // For NTD login
                              CustomTextField(
                                labelText: 'Doanh nghiệp',
                                controller: ntdUsernameController,
                                hintText: 'Nhập tên doanh nghiệp',
                                prefixIcon: const Icon(Icons.business),
                              ),
                              const SizedBox(height: 16),
                              BlocBuilder<NTVBloc, NTVState>(
                                bloc: _ntvBloc,
                                builder: (context, state) {
                                  if (state is NTVLoaded) {
                                    final pickerItems = state.tblHoSoUngViens
                                        .map((item) =>
                                            HoSoUngVienPickerItem(item))
                                        .toList();
                                    return GenericPicker<HoSoUngVienPickerItem>(
                                      label: 'Ứng viên',
                                      hintText: 'Chọn ứng viên',
                                      items: pickerItems,
                                      onChanged: (value) {
                                        selectedHoSoUngVien =
                                            value?.hoSoUngVien;
                                        if (value != null) {
                                          uvUsernameController.text =
                                              value.hoSoUngVien.uvUsername ??
                                                  '';
                                        }
                                      },
                                    );
                                  }
                                  return const Center(
                                      child: CircularProgressIndicator());
                                },
                              ),
                            ] else ...[
                              // For NTV login
                              CustomTextField(
                                labelText: 'Ứng viên',
                                controller: uvUsernameController,
                                hintText: 'Nhập tên ứng viên',
                                prefixIcon: const Icon(Icons.person),
                              ),
                              const SizedBox(height: 16),
                              GenericPicker<NTDPickerItem>(
                                label: 'Doanh nghiệp',
                                hintText: 'Nhập tên doanh nghiệp',
                                items: ntdPickerList,
                                onChanged: (value) {
                                  print(
                                      'NTD Picker onChanged called with value: ${value?.id} - ${value?.displayName}'); // Debug NTD selection
                                  selectedNTD = value;
                                  selectedIdDoanhNghiep = value
                                      ?.id; // Set the selectedIdDoanhNghiep
                                  print(
                                      'selectedNTD after change: ${selectedNTD?.id}'); // Debug NTD selection
                                  // Load TuyenDung list for selected NTD
                                  if (value != null) {
                                    print(
                                        'Fetching TuyenDung list for NTD ID: ${value.id}'); // Debug API call
                                    _tuyenDungBloc.add(
                                        TuyenDungEvent.fetchList(value.id));
                                  }
                                },
                              ),
                            ],
                            const SizedBox(height: 16),
                            BlocBuilder<TuyenDungBloc, TuyenDungState>(
                              bloc: _tuyenDungBloc,
                              builder: (context, state) {
                                print('TuyenDung State: $state'); // Debug state

                                // For NTV users, show empty picker initially
                                if (authState is AuthAuthenticated &&
                                    authState.userType == 'ntv') {
                                  if (selectedIdDoanhNghiep == null) {
                                    return GenericPicker<TuyenDungPickerItem>(
                                      label: 'HS tuyển dụng',
                                      hintText:
                                          'Vui lòng chọn doanh nghiệp trước',
                                      items: const [],
                                      onChanged:
                                          (_) {}, // Empty handler for disabled state
                                    );
                                  }
                                }

                                if (state is TuyenDungLoaded) {
                                  print(
                                      'TuyenDung List Length: ${state.tuyenDungList.length}'); // Debug list length
                                  if (state.tuyenDungList.isEmpty) {
                                    print(
                                        'TuyenDung List is Empty'); // Debug empty list
                                    return GenericPicker<TuyenDungPickerItem>(
                                      label: 'HS tuyển dụng',
                                      hintText: 'Không có dữ liệu',
                                      items: const [],
                                      onChanged: (value) {
                                        print(
                                            'Empty TuyenDung Picker onChanged called with value: ${value?.id}'); // Debug empty selection
                                        selectedIdTuyenDung = value?.id;
                                        print(
                                            'selectedIdTuyenDung after change: $selectedIdTuyenDung'); // Debug selection
                                      },
                                    );
                                  }
                                  final pickerItems = state.tuyenDungList
                                      .map((item) => TuyenDungPickerItem(item))
                                      .toList();
                                  print(
                                      'Picker Items: ${pickerItems.map((e) => '${e.id}: ${e.displayName}').join(', ')}'); // Debug items
                                  return GenericPicker<TuyenDungPickerItem>(
                                    label: 'HS tuyển dụng',
                                    hintText: 'Chọn hồ sơ tuyển dụng',
                                    items: pickerItems,
                                    onChanged: (value) {
                                      print(
                                          'TuyenDung Picker onChanged called with value: ${value?.id} - ${value?.displayName}'); // Debug selection
                                      selectedIdTuyenDung = value?.id;
                                      print(
                                          'selectedIdTuyenDung after change: $selectedIdTuyenDung'); // Debug selection
                                    },
                                  );
                                }

                                // Only show loading indicator when actively fetching data
                                if (state is TuyenDungLoading &&
                                    selectedIdDoanhNghiep != null) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                // Default case: show empty picker
                                return GenericPicker<TuyenDungPickerItem>(
                                  label: 'HS tuyển dụng',
                                  hintText: 'Chọn hồ sơ tuyển dụng',
                                  items: const [],
                                  onChanged:
                                      (_) {}, // Empty handler for disabled state
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 0,
                      color: Colors.grey[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Thông tin bổ sung',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            GenericPicker<KieuChapNoiModel>(
                              label: 'Kiểu chắp nối',
                              hintText: 'Chọn kiểu chắp nối',
                              items: kieuChapNoiList,
                              onChanged: (value) {
                                selectedKieuChapNoi = value;
                              },
                            ),
                            const SizedBox(height: 16),
                            CustomPickerMap(
                              label: Text('Kết quả'),
                              items: ketQuangOptions,
                              selectedItem: ketQua,
                              onChanged: (value) {
                                ketQua = value;
                              },
                            ),
                            const SizedBox(height: 16),
                            CustomPickDateTimeGrok(
                              labelText: 'Ngày giới thiệu',
                              onChanged: (value) {
                                selectedNgayMuonHs = value;
                              },
                            ),
                            const SizedBox(height: 16),
                            CustomPickDateTimeGrok(
                              labelText: 'Ngày trả hồ sơ',
                              onChanged: (value) {
                                selectedNgayTraHs = value;
                              },
                            ),
                            const SizedBox(height: 16),
                            CustomTextField.textArea(
                              labelText: 'Ghi chú',
                              hintText: 'Nhập ghi chú',
                              minLines: 3,
                              maxLines: 5,
                              controller: ghiChuController,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.cancel),
                    label: const Text('Hủy'),
                    onPressed: () => Navigator.pop(dialogContext),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Tạo'),
                    onPressed: () {
                      print('Validating form...'); // Debug validation start
                      print(
                          'selectedKieuChapNoi: ${selectedKieuChapNoi?.id}'); // Debug kieu chap noi
                      print('isNTD: $isNTD'); // Debug user type
                      print(
                          'selectedHoSoUngVien: ${selectedHoSoUngVien?.id}'); // Debug ho so ung vien
                      print('selectedNTD: ${selectedNTD?.id}'); // Debug NTD
                      print(
                          'selectedIdTuyenDung: $selectedIdTuyenDung'); // Debug tuyen dung
                      print('selectedKetQua: $ketQua'); // Debug ket qua
                      print(
                          'selectedNgayMuonHs: $selectedNgayMuonHs'); // Debug ngay muon

                      if (selectedKieuChapNoi == null ||
                          (isNTD
                              ? selectedHoSoUngVien == null
                              : selectedNTD == null) ||
                          selectedIdTuyenDung == null ||
                          ketQua == null ||
                          selectedNgayMuonHs == null) {
                        print('Validation failed:'); // Debug validation failure
                        if (selectedKieuChapNoi == null)
                          print('- Kiểu chắp nối is missing');
                        if (isNTD && selectedHoSoUngVien == null)
                          print('- Hồ sơ ứng viên is missing');
                        if (!isNTD && selectedNTD == null)
                          print('- Nhà tuyển dụng is missing');
                        if (selectedIdTuyenDung == null)
                          print('- Hồ sơ tuyển dụng is missing');
                        if (ketQua == null) print('- Kết quả is missing');
                        if (selectedNgayMuonHs == null)
                          print('- Ngày mượn hồ sơ is missing');

                        ScaffoldMessenger.of(dialogContext).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Vui lòng điền đầy đủ thông tin bắt buộc'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      final newChapNoi = ChapNoiModel(
                        idKieuChapNoi: selectedKieuChapNoi!.id,
                        idUngVien:
                            isNTD ? selectedHoSoUngVien!.id : widget.id ?? '',
                        idDoanhNghiep:
                            isNTD ? widget.id ?? '' : selectedNTD!.id,
                        idTuyenDung: selectedIdTuyenDung!,
                        ngayMuonHs: selectedNgayMuonHs!,
                        ngayTraHs: selectedNgayTraHs,
                        ghiChu: ghiChuController.text,
                        idKetQua: ketQua ?? 0,
                      );

                      print(
                          'Creating new ChapNoi with data:'); // Debug new ChapNoi data
                      print('idKieuChapNoi: ${newChapNoi.idKieuChapNoi}');
                      print('idUngVien: ${newChapNoi.idUngVien}');
                      print('idDoanhNghiep: ${newChapNoi.idDoanhNghiep}');
                      print('idTuyenDung: ${newChapNoi.idTuyenDung}');
                      print('ngayMuonHs: ${newChapNoi.ngayMuonHs}');
                      print('ngayTraHs: ${newChapNoi.ngayTraHs}');
                      print('ghiChu: ${newChapNoi.ghiChu}');
                      print('idKetQua: ${newChapNoi.idKetQua}');

                      _chapNoiBloc.add(ChapNoiCreate(newChapNoi));
                      Navigator.pop(dialogContext);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
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
}
