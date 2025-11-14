import 'package:flutter/material.dart';
import 'package:ttld/models/dan_toc_model.dart';
import 'package:ttld/models/dmtinhmoi_model.dart';
import 'package:ttld/models/dmxamoi_model.dart';
import 'package:ttld/models/doituong_chinhsach/doituong.dart';
import 'package:ttld/models/nguon_thuthap_model.dart';
import 'package:ttld/models/tinh_thanh_model.dart';
import 'package:ttld/models/trinh_do_van_hoa_model.dart';
import 'package:ttld/models/tttantat/tttantat.dart';
import 'package:ttld/widgets/cascade_location_picker_grok.dart';
import 'package:ttld/widgets/field/custom_pick_datetime_grok.dart';
import 'package:ttld/widgets/field/custom_picker_map.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/helppers/map_help.dart';
import 'package:ttld/core/services/tinh_moi_api_service.dart';
import 'package:ttld/core/services/xa_moi_api_service.dart';

class Step1PersonalInfo extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController hotenController;
  final TextEditingController dienthoaiController;
  final TextEditingController cmndController;
  final TextEditingController uvnoicapController;
  final TextEditingController diachichitietController;
  final TextEditingController uvchieucaoController;
  final TextEditingController uvcannangController;
  final TextEditingController idTinhController;
  final TextEditingController idHuyenController;
  final TextEditingController idXaController;
  final String? uvngaysinhController;
  final String? uvNgaycap;
  final int? uvGioitinh;
  final bool? uvHonnhanId;
  final int? idDanToc;
  final int? uvTinhtrangtantatId;
  final int? uvDoiTuongChingSachId;
  final int? idThanhPho;
  final int? uvcmTrinhdoId;
  final int? idNguonThuThap;
  final int? idTinhMoi;
  final int? idXaMoi;
  final Function(String?) onNgaysinhChanged;
  final Function(String?) onNgaycapChanged;
  final Function(int?) onGioitinhChanged;
  final Function(bool?) onHonnhanChanged;
  final Function(NguonThuThap?) onNguonThuThapChanged;
  final Function(DanToc?) onDanTocChanged;
  final Function(TtTantat?) onTinhTrangTanTatChanged;
  final Function(DoiTuong?) onDoiTuongChinhSachChanged;
  final Function(TinhThanhModel?) onThanhPhoChanged;
  final Function(TrinhDoVanHoa?) onTrinhDoVanHoaChanged;
  final Function(String?, String?, String?) onLocationChanged;
  final Function(DmTinhMoi?) onTinhMoiChanged;
  final Function(DmXaMoi?) onXaMoiChanged;

  const Step1PersonalInfo({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.hotenController,
    required this.dienthoaiController,
    required this.cmndController,
    required this.uvnoicapController,
    required this.diachichitietController,
    required this.uvchieucaoController,
    required this.uvcannangController,
    required this.idTinhController,
    required this.idHuyenController,
    required this.idXaController,
    required this.uvngaysinhController,
    required this.uvNgaycap,
    required this.uvGioitinh,
    required this.uvHonnhanId,
    required this.idDanToc,
    required this.uvTinhtrangtantatId,
    required this.uvDoiTuongChingSachId,
    required this.idThanhPho,
    required this.uvcmTrinhdoId,
    required this.idNguonThuThap,
    required this.onNgaysinhChanged,
    required this.onNgaycapChanged,
    required this.onGioitinhChanged,
    required this.onHonnhanChanged,
    required this.onNguonThuThapChanged,
    required this.onDanTocChanged,
    required this.onTinhTrangTanTatChanged,
    required this.onDoiTuongChinhSachChanged,
    required this.onThanhPhoChanged,
    required this.onTrinhDoVanHoaChanged,
    required this.onLocationChanged,
    required this.onTinhMoiChanged,
    required this.onXaMoiChanged,
    this.idTinhMoi,
    this.idXaMoi,
  }) : super(key: key);

  @override
  State<Step1PersonalInfo> createState() => _Step1PersonalInfoState();
}

class _Step1PersonalInfoState extends State<Step1PersonalInfo> {
  List<DmTinhMoi> _tinhMoiList = [];
  List<DmXaMoi> _xaMoiList = [];
  bool _isLoadingTinhMoi = false;
  bool _isLoadingXaMoi = false;
  int? _selectedTinhMoiId;

  @override
  void initState() {
    super.initState();
    _loadTinhMoi();
    _selectedTinhMoiId = widget.idTinhMoi;
    if (_selectedTinhMoiId != null) {
      _loadXaMoi(_selectedTinhMoiId!);
    }
  }

  Future<void> _loadTinhMoi() async {
    setState(() => _isLoadingTinhMoi = true);
    try {
      final apiService = locator<TinhMoiApiService>();
      final response = await apiService.getTinhMoi(limit: 100);

      if (response != null && response['data'] != null) {
        setState(() {
          _tinhMoiList = (response['data'] as List)
              .map((item) => DmTinhMoi.fromJson(item))
              .toList();
        });
      }
    } catch (e) {
      print('Error loading tinh moi: $e');
    } finally {
      setState(() => _isLoadingTinhMoi = false);
    }
  }

  Future<void> _loadXaMoi(int tinhId) async {
    setState(() => _isLoadingXaMoi = true);
    try {
      final apiService = locator<XaMoiApiService>();
      final response = await apiService.getXaMoi(matinh: tinhId, limit: 100);

      if (response != null && response['data'] != null) {
        setState(() {
          _xaMoiList = (response['data'] as List)
              .map((item) => DmXaMoi.fromJson(item))
              .toList();
        });
      }
    } catch (e) {
      print('Error loading xa moi: $e');
    } finally {
      setState(() => _isLoadingXaMoi = false);
    }
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionHeader(theme, 'THÔNG TIN LÝ LỊCH'),
          const SizedBox(height: 16),

          // Row 1: Họ tên | Ngày sinh
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  labelText: 'Họ tên (*)',
                  hintText: 'Nhập họ tên',
                  controller: widget.hotenController,
                  validator: 'not_empty',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomPickDateTimeGrok(
                  hintText: 'Ngày sinh(*)',
                  initialValue: widget.uvngaysinhController,
                  validator: (DateTime? value) {
                    if (value == null) {
                      return 'Ngày sinh không được để trống';
                    }
                    return null;
                  },
                  onChanged: widget.onNgaysinhChanged,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Row 2: Giới tính | Hôn nhân
          Row(
            children: [
              Expanded(
                child: CustomPickerMap(
                  label: Text('Giới tính(*)'),
                  items: gioiTinhOptions,
                  selectedItem: widget.uvGioitinh,
                  onChanged: widget.onGioitinhChanged,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomPickerMap(
                  label: Text('Hôn nhân(*)'),
                  items: hoNhanOptions,
                  selectedItem: widget.uvHonnhanId,
                  onChanged: widget.onHonnhanChanged,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Row 3: Điện thoại | Số CMND
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  labelText: 'Điện thoại',
                  hintText: 'Số điện thoại',
                  controller: widget.dienthoaiController,
                  validator: 'not_empty',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomTextField(
                  labelText: 'Số CMND',
                  controller: widget.cmndController,
                  validator: 'not_empty',
                  hintText: 'Số CMND',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Row 4: Dân tộc
          GenericPicker<DanToc>(
            label: 'Dân tộc',
            items: locator<List<DanToc>>(),
            initialValue: widget.idDanToc,
            onChanged: widget.onDanTocChanged,
          ),
          const SizedBox(height: 12),

          // Row 5: Chiều cao | Cân nặng
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  labelText: 'Chiều cao',
                  hintText: '(cm)',
                  controller: widget.uvchieucaoController,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomTextField(
                  labelText: 'Cân nặng',
                  hintText: '(kg)',
                  controller: widget.uvcannangController,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Row 6: Tình trạng tàn tật | Đối tượng chính sách
          Row(
            children: [
              Expanded(
                child: GenericPicker<TtTantat>(
                  label: 'Tình trạng tàn tật',
                  items: locator<List<TtTantat>>(),
                  initialValue: widget.uvTinhtrangtantatId,
                  onChanged: widget.onTinhTrangTanTatChanged,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GenericPicker<DoiTuong>(
                  label: 'Đối tượng chính sách',
                  items: locator<List<DoiTuong>>(),
                  initialValue: widget.uvDoiTuongChingSachId,
                  onChanged: widget.onDoiTuongChinhSachChanged,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Address section with cascade location picker
          // This will provide: Tỉnh/TP, Quận/huyện, Xã/phường, Số nhà/thôn/khối
          CascadeLocationPickerGrok(
            initialTinh: widget.idTinhController.text,
            initialHuyen: widget.idHuyenController.text,
            initialXa: widget.idXaController.text,
            onTinhChanged: (tinh) {
              widget.onLocationChanged(tinh?.id, null, null);
            },
            onHuyenChanged: (huyen) {
              widget.onLocationChanged(null, huyen?.id, null);
            },
            onXaChanged: (xa) {
              widget.onLocationChanged(null, null, xa?.maxa);
            },
            isNTD: false,
            addressDetailController: widget.diachichitietController,
          ),
          const SizedBox(height: 12),

          // Row: Tỉnh mới | Xã mới (using API dropdowns)
          Row(
            children: [
              Expanded(
                child: GenericPicker<DmTinhMoi>(
                  label: 'Tỉnh mới',
                  hintText: 'Chọn tỉnh mới',
                  items: _tinhMoiList,
                  initialValue: widget.idTinhMoi,
                  isLoading: _isLoadingTinhMoi,
                  onChanged: (value) {
                    setState(() {
                      _selectedTinhMoiId = value?.id;
                      _xaMoiList = [];
                    });
                    if (value != null) {
                      _loadXaMoi(value.id);
                    }
                    widget.onTinhMoiChanged(value);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GenericPicker<DmXaMoi>(
                  label: 'Xã mới',
                  hintText: 'Chọn xã mới',
                  items: _xaMoiList,
                  initialValue: widget.idXaMoi,
                  isLoading: _isLoadingXaMoi,
                  onChanged: (value) {
                    widget.onXaMoiChanged(value);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
