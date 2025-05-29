import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';
import 'package:ttld/models/chapnoi/chapnoi_picker_items.dart'; // Import picker items

class CreateHoSoChapNoiPage extends StatefulWidget {
  final String? id;
  final String? uvUsername;
  final String? ntdUsername;

  const CreateHoSoChapNoiPage({
    super.key,
    this.id,
    this.uvUsername,
    this.ntdUsername,
  });

  @override
  State<CreateHoSoChapNoiPage> createState() => _CreateHoSoChapNoiPageState();
}

class _CreateHoSoChapNoiPageState extends State<CreateHoSoChapNoiPage> {
  late TextEditingController uvUsernameController;
  late TextEditingController ntdUsernameController;
  late TextEditingController ghiChuController;

  late final ChapNoiBloc _chapNoiBloc;
  late final NTDRepository _ntdRepository;
  late final NTVBloc _ntvBloc;
  late final TuyenDungBloc _tuyenDungBloc;
  late final AuthBloc _authBloc;

  KieuChapNoiModel? selectedKieuChapNoi;
  NTDPickerItem? selectedNTD;
  TblHoSoUngVienModel? selectedHoSoUngVien;
  String? selectedNgayMuonHs;
  String? selectedNgayTraHs;
  int? ketQua;

  late final List<KieuChapNoiModel> kieuChapNoiList;
  List<NTDPickerItem> ntdPickerList = [];
  String? selectedIdTuyenDung;
  String? selectedIdDoanhNghiep;

  @override
  void initState() {
    super.initState();
    _chapNoiBloc = locator<ChapNoiBloc>();
    _ntdRepository = locator<NTDRepository>();
    _ntvBloc = locator<NTVBloc>();
    _tuyenDungBloc = locator<TuyenDungBloc>();
    _authBloc = locator<AuthBloc>();

    uvUsernameController = TextEditingController(text: widget.uvUsername ?? '');
    ntdUsernameController =
        TextEditingController(text: widget.ntdUsername ?? '');
    ghiChuController = TextEditingController();

    kieuChapNoiList = locator<List<KieuChapNoiModel>>();

    final authState = _authBloc.state;
    if (authState is AuthAuthenticated) {
      if (authState.userType == 'ntd') {
        ntdUsernameController.text = authState.userName;
        if (!_ntvBloc.isClosed) {
          _ntvBloc.add(LoadTblHoSoUngViens());
        }
        _tuyenDungBloc.add(TuyenDungEvent.fetchList(authState.userId));
      } else if (authState.userType == 'ntv') {
        // Populate uvUsernameController with authenticated NTV's username if not already set
        if (widget.uvUsername == null || widget.uvUsername!.isEmpty) {
          uvUsernameController.text = authState.userName;
        }
        _fetchNtdList();
      }
    }
  }

  @override
  void dispose() {
    uvUsernameController.dispose();
    ntdUsernameController.dispose();
    ghiChuController.dispose();
    super.dispose();
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

  void _createChapNoi() {
    print('Validating form...'); // Debug validation start
    print(
        'selectedKieuChapNoi: ${selectedKieuChapNoi?.id}'); // Debug kieu chap noi
    final authState = _authBloc.state;
    final isNTD = authState is AuthAuthenticated && authState.userType == 'ntd';
    print('isNTD: $isNTD'); // Debug user type
    print(
        'selectedHoSoUngVien: ${selectedHoSoUngVien?.id}'); // Debug ho so ung vien
    print('selectedNTD: ${selectedNTD?.id}'); // Debug NTD
    print('selectedIdTuyenDung: $selectedIdTuyenDung'); // Debug tuyen dung
    print('selectedKetQua: $ketQua'); // Debug ket qua
    print('selectedNgayMuonHs: $selectedNgayMuonHs'); // Debug ngay muon

    if (selectedKieuChapNoi == null ||
        (isNTD ? selectedHoSoUngVien == null : selectedNTD == null) ||
        selectedIdTuyenDung == null ||
        ketQua == null ||
        selectedNgayMuonHs == null) {
      print('Validation failed:'); // Debug validation failure
      if (selectedKieuChapNoi == null) print('- Kiểu chắp nối is missing');
      if (isNTD && selectedHoSoUngVien == null)
        print('- Hồ sơ ứng viên is missing');
      if (!isNTD && selectedNTD == null) print('- Nhà tuyển dụng is missing');
      if (selectedIdTuyenDung == null) print('- Hồ sơ tuyển dụng is missing');
      if (ketQua == null) print('- Kết quả is missing');
      if (selectedNgayMuonHs == null) print('- Ngày mượn hồ sơ is missing');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng điền đầy đủ thông tin bắt buộc'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final newChapNoi = ChapNoiModel(
      idKieuChapNoi: selectedKieuChapNoi!.id,
      idUngVien: isNTD ? selectedHoSoUngVien!.id : widget.id ?? '',
      idDoanhNghiep: isNTD ? widget.id ?? '' : selectedNTD!.id,
      idTuyenDung: selectedIdTuyenDung!,
      ngayMuonHs: selectedNgayMuonHs!,
      ngayTraHs: selectedNgayTraHs,
      ghiChu: ghiChuController.text,
      idKetQua: ketQua ?? 0,
    );

    print('Creating new ChapNoi with data:'); // Debug new ChapNoi data
    print('idKieuChapNoi: ${newChapNoi.idKieuChapNoi}');
    print('idUngVien: ${newChapNoi.idUngVien}');
    print('idDoanhNghiep: ${newChapNoi.idDoanhNghiep}');
    print('idTuyenDung: ${newChapNoi.idTuyenDung}');
    print('ngayMuonHs: ${newChapNoi.ngayMuonHs}');
    print('ngayTraHs: ${newChapNoi.ngayTraHs}');
    print('ghiChu: ${newChapNoi.ghiChu}');
    print('idKetQua: ${newChapNoi.idKetQua}');

    _chapNoiBloc.add(ChapNoiCreate(newChapNoi));
    Navigator.pop(context); // Navigate back after creation
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authState = _authBloc.state;
    final isNTD = authState is AuthAuthenticated && authState.userType == 'ntd';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tạo hồ sơ chắp nối mới',
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            readOnly: true, // NTD's own business
                            enabled: false, // Make it non-interactive
                          ),
                          const SizedBox(height: 16),
                          BlocBuilder<NTVBloc, NTVState>(
                            bloc: _ntvBloc,
                            builder: (context, state) {
                              if (state is NTVLoaded) {
                                final pickerItems = state.tblHoSoUngViens
                                    .map((item) => HoSoUngVienPickerItem(item))
                                    .toList();
                                return GenericPicker<HoSoUngVienPickerItem>(
                                  label: 'Ứng viên',
                                  hintText: 'Chọn ứng viên',
                                  items: pickerItems,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedHoSoUngVien = value?.hoSoUngVien;
                                      // uvUsernameController.text = value.hoSoUngVien.uvUsername ?? ''; // This line was removed in a previous step
                                    });
                                  },
                                );
                              }
                              // Show empty picker or loading indicator
                              return GenericPicker<HoSoUngVienPickerItem>(
                                label: 'Ứng viên',
                                hintText: 'Đang tải...',
                                items: const [],
                                isLoading: state is NTVLoading,
                                onChanged: (_) {},
                              );
                            },
                          ),
                        ] else ...[
                          // For NTV login
                          CustomTextField(
                            labelText: 'Ứng viên',
                            controller: uvUsernameController,
                            hintText: 'Nhập tên ứng viên',
                            prefixIcon: const Icon(Icons.person),
                            readOnly: true, // NTV's own profile
                            enabled: false, // Make it non-interactive
                          ),
                          const SizedBox(height: 16),
                          GenericPicker<NTDPickerItem>(
                            label: 'Doanh nghiệp',
                            hintText: 'Nhập tên doanh nghiệp',
                            items: ntdPickerList,
                            onChanged: (value) {
                              setState(() {
                                selectedNTD = value;
                                selectedIdDoanhNghiep = value?.id;
                                // Reset TuyenDung selection when NTD changes
                                selectedIdTuyenDung = null;
                              });
                              if (value != null) {
                                _tuyenDungBloc
                                    .add(TuyenDungEvent.fetchList(value.id));
                              } else {
                                // Clear TuyenDung list if no NTD is selected
                                // _tuyenDungBloc.add(TuyenDungEvent.clearList());
                              }
                            },
                          ),
                        ],
                        const SizedBox(height: 16),
                        BlocBuilder<TuyenDungBloc, TuyenDungState>(
                          bloc: _tuyenDungBloc,
                          builder: (context, state) {
                            List<TuyenDungPickerItem> pickerItems = [];
                            bool isLoading = false;
                            String hintText = 'Chọn hồ sơ tuyển dụng';

                            if (state is TuyenDungLoaded) {
                              pickerItems = state.tuyenDungList
                                  .map((item) => TuyenDungPickerItem(item))
                                  .toList();
                              if (pickerItems.isEmpty) {
                                hintText = 'Không có dữ liệu';
                              }
                            } else if (state is TuyenDungLoading) {
                              isLoading = true;
                              hintText = 'Đang tải...';
                            } else if (isNTD) {
                              // If NTD, TuyenDung list is loaded initially
                              // This case should ideally not be reached if initial load is handled
                            } else if (selectedIdDoanhNghiep == null) {
                              hintText = 'Vui lòng chọn doanh nghiệp trước';
                            }

                            return GenericPicker<TuyenDungPickerItem>(
                              label: 'HS tuyển dụng',
                              hintText: hintText,
                              items: pickerItems,
                              isLoading: isLoading,
                              onChanged: (value) {
                                setState(() {
                                  selectedIdTuyenDung = value?.id;
                                });
                              },
                              initialValue:
                                  selectedIdTuyenDung, // Keep selected value
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
                            setState(() {
                              selectedKieuChapNoi = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomPickerMap(
                          label: Text('Kết quả'),
                          items: ketQuangOptions,
                          selectedItem: ketQua,
                          onChanged: (value) {
                            setState(() {
                              ketQua = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomPickDateTimeGrok(
                          labelText: 'Ngày giới thiệu',
                          onChanged: (value) {
                            setState(() {
                              selectedNgayMuonHs = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomPickDateTimeGrok(
                          labelText: 'Ngày trả hồ sơ',
                          onChanged: (value) {
                            setState(() {
                              selectedNgayTraHs = value;
                            });
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
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.cancel),
                      label: const Text('Hủy'),
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Tạo'),
                      onPressed: _createChapNoi,
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
      ),
    );
  }
}
