import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/m02tt11/m02tt11_model.dart';
import 'package:ttld/models/muc_luong_mm.dart';
import 'package:ttld/models/ky_nang_mem_model.dart';
import 'package:ttld/models/kinh_nghiem_lam_viec.dart';
import 'package:ttld/models/loai_hop_dong_lao_dong_model.dart';
import 'package:ttld/models/hinh_thuc_tuyen_dung_model.dart';
import 'package:ttld/models/hinh_thuc_lam_viec_model.dart';
import 'package:ttld/models/muc_dich_lam_viec_model.dart';
import 'package:ttld/models/quocgia/quocgia_model.dart';
import 'package:ttld/models/ca_lam_viec_model.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class Step3JobConditions extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final M02TT11 formData;
  final Function(M02TT11) onDataChanged;

  const Step3JobConditions({
    super.key,
    required this.formKey,
    required this.formData,
    required this.onDataChanged,
  });

  @override
  _Step3JobConditionsState createState() => _Step3JobConditionsState();
}

class _Step3JobConditionsState extends State<Step3JobConditions> {
  // Text Controllers
  late TextEditingController _softSkillOtherController;
  late TextEditingController _moneyAllowanceController;
  late TextEditingController _otherBenefitsController;
  late TextEditingController _readyToWorkMonthsController;

  // Checkboxes - Work conditions
  bool _chkGt = false;  // Giao tiếp
  bool _chkNs = false;  // Ngoại trời
  bool _chkNhom = false; // Hẹn hợp
  bool _chkGs = false;  // Giải stress
  bool _chkKhac = false;  // Khác
  bool _chkTtr = false;  // Thị trực
  bool _chkTh = false;  // Trong nhà
  bool _chkDl = false;  // Đi lại
  bool _chkPb = false;  // Phân biệt
  bool _chkQltg = false;  // Quản lý thời gian
  bool _chkTu = false;  // Tư duy
  bool _chkApl = false;  // Áp lực

  // Benefits checkboxes
  bool _chkPl01 = false;
  bool _chkPl02 = false;
  bool _chkPl03 = false;
  bool _chkPl04 = false;
  bool _chkPl05 = false;
  bool _chkPl06 = false;
  bool _chkPl07 = false;
  bool _chkPl08 = false;
  bool _chkPl09 = false;
  bool _chkPl10 = false;
  bool _chkPl11 = false;
  bool _chkPl12 = false;
  bool _chkPl13 = false;
  bool _chkPl14 = false;
  bool _chkPl15 = false;
  bool _chkPl16 = false;
  bool _chkPl17 = false;

  // Weight/physical requirements
  bool _chkNl1 = false;
  bool _chkNl2 = false;
  bool _chkNl3 = false;

  // Movement requirements
  bool _chkTl1 = false;
  bool _chkTl2 = false;
  bool _chkTl3 = false;

  // Hearing/speech requirements
  bool _chkDl1 = false;
  bool _chkDl2 = false;
  bool _chkDl3 = false;

  // Vision requirements
  bool _chkNn1 = false;
  bool _chkNn2 = false;

  // Hand operation requirements
  bool _chkY01 = false;
  bool _chkY02 = false;
  bool _chkY03 = false;

  // Two hands usage
  bool _chkTy1 = false;
  bool _chkTy2 = false;
  bool _chkTy3 = false;
  bool _chkTy4 = false;  // Left
  bool _chkTy5 = false;  // Right

  // 2-day requirements
  bool _chk2T1 = false;
  bool _chk2T2 = false;
  bool _chk2T3 = false;
  bool _chk2T4 = false;
  bool _chk2T5 = false;

  // Work readiness
  bool _sslv1 = false;

  // Worked abroad
  bool _workedAbroad = false;
  int? _workedAbroadCountryId;

  // Dropdowns
  dynamic _idKynang;  // Best soft skill (can be int or String)
  String? _idKinhnghiem;  // Work experience
  String? _idLoaiDhld;  // Contract type
  int? _idCalamviec;  // Work shift (Ca làm việc)
  String? _idHinhthucTd;  // Recruitment form
  String? _idHinhthuc;  // Work form
  String? _idMucdich;  // Work purpose
  int? _idMucluong;  // Salary

  @override
  void initState() {
    super.initState();

    // Initialize text controllers
    _softSkillOtherController = TextEditingController(text: widget.formData.kynangkhac);
    _moneyAllowanceController = TextEditingController(text: widget.formData.tienPhucloi?.toString() ?? '0');
    _otherBenefitsController = TextEditingController(text: widget.formData.phucloikhac);
    _readyToWorkMonthsController = TextEditingController(text: widget.formData.sslv2 == true ? '0' : '');

    // Initialize checkboxes
    _chkGt = widget.formData.chkGt ?? false;
    _chkNs = widget.formData.chkNs ?? false;
    _chkNhom = widget.formData.chkNhom ?? false;
    _chkGs = widget.formData.chkGs ?? false;
    _chkKhac = widget.formData.chkKhac ?? false;
    _chkTtr = widget.formData.chkTtr ?? false;
    _chkTh = widget.formData.chkTh ?? false;
    _chkDl = widget.formData.chkDl ?? false;
    _chkPb = widget.formData.chkPb ?? false;
    _chkQltg = widget.formData.chkQltg ?? false;
    _chkTu = widget.formData.chkTu ?? false;
    _chkApl = widget.formData.chkApl ?? false;

    // Benefits
    _chkPl01 = widget.formData.chkPl01 ?? false;
    _chkPl02 = widget.formData.chkPl02 ?? false;
    _chkPl03 = widget.formData.chkPl03 ?? false;
    _chkPl04 = widget.formData.chkPl04 ?? false;
    _chkPl05 = widget.formData.chkPl05 ?? false;
    _chkPl06 = widget.formData.chkPl06 ?? false;
    _chkPl07 = widget.formData.chkPl07 ?? false;
    _chkPl08 = widget.formData.chkPl08 ?? false;
    _chkPl09 = widget.formData.chkPl09 ?? false;
    _chkPl10 = widget.formData.chkPl10 ?? false;
    _chkPl11 = widget.formData.chkPl11 ?? false;
    _chkPl12 = widget.formData.chkPl12 ?? false;
    _chkPl13 = widget.formData.chkPl13 ?? false;
    _chkPl14 = widget.formData.chkPl14 ?? false;
    _chkPl15 = widget.formData.chkPl15 ?? false;
    _chkPl16 = widget.formData.chkPl16 ?? false;
    _chkPl17 = widget.formData.chkPl17 ?? false;

    // Physical requirements
    _chkNl1 = widget.formData.chkNl1 ?? false;
    _chkNl2 = widget.formData.chkNl2 ?? false;
    _chkNl3 = widget.formData.chkNl3 ?? false;
    _chkTl1 = widget.formData.chkTl1 ?? false;
    _chkTl2 = widget.formData.chkTl2 ?? false;
    _chkTl3 = widget.formData.chkTl3 ?? false;
    _chkDl1 = widget.formData.chkDl1 ?? false;
    _chkDl2 = widget.formData.chkDl2 ?? false;
    _chkDl3 = widget.formData.chkDl3 ?? false;
    _chkNn1 = widget.formData.chkNn1 ?? false;
    _chkNn2 = widget.formData.chkNn2 ?? false;
    _chkY01 = widget.formData.chkY01 ?? false;
    _chkY02 = widget.formData.chkY02 ?? false;
    _chkTy1 = widget.formData.chkTy1 ?? false;
    _chkTy2 = widget.formData.chkTy2 ?? false;
    _chkTy3 = widget.formData.chkTy3 ?? false;
    _chk2T1 = widget.formData.chk2T1 ?? false;
    _chk2T2 = widget.formData.chk2T2 ?? false;
    _chk2T3 = widget.formData.chk2T3 ?? false;
    _chk2T4 = widget.formData.chk2T4 ?? false;
    _chk2T5 = widget.formData.chk2T5 ?? false;
    _sslv1 = widget.formData.sslv1 ?? false;
    _workedAbroad = widget.formData.lvNuocngoai ?? false;

    // Initialize dropdowns
    _idKynang = widget.formData.idKynang;
    _idKinhnghiem = widget.formData.idKinhnghiem;
    _idLoaiDhld = widget.formData.idLoaiDhld;
    _idCalamviec = widget.formData.idCalamviec;
    _idHinhthucTd = widget.formData.idHinhthucTd;
    _idHinhthuc = widget.formData.idHinhthuc;
    _idMucdich = widget.formData.idMucdich;
    _idMucluong = widget.formData.idMucluong;
  }

  @override
  void dispose() {
    _softSkillOtherController.dispose();
    _moneyAllowanceController.dispose();
    _otherBenefitsController.dispose();
    _readyToWorkMonthsController.dispose();
    super.dispose();
  }

  void _updateFormData() {
    final updatedData = widget.formData.copyWith(
      kynangkhac: _softSkillOtherController.text,
      tienPhucloi: int.tryParse(_moneyAllowanceController.text),
      phucloikhac: _otherBenefitsController.text,
      sslv2: _readyToWorkMonthsController.text.isNotEmpty ? int.tryParse(_readyToWorkMonthsController.text) == 0 : null,
      chkGt: _chkGt,
      chkNs: _chkNs,
      chkNhom: _chkNhom,
      chkGs: _chkGs,
      chkKhac: _chkKhac,
      chkTtr: _chkTtr,
      chkTh: _chkTh,
      chkDl: _chkDl,
      chkPb: _chkPb,
      chkQltg: _chkQltg,
      chkTu: _chkTu,
      chkApl: _chkApl,
      chkPl01: _chkPl01,
      chkPl02: _chkPl02,
      chkPl03: _chkPl03,
      chkPl04: _chkPl04,
      chkPl05: _chkPl05,
      chkPl06: _chkPl06,
      chkPl07: _chkPl07,
      chkPl08: _chkPl08,
      chkPl09: _chkPl09,
      chkPl10: _chkPl10,
      chkPl11: _chkPl11,
      chkPl12: _chkPl12,
      chkPl13: _chkPl13,
      chkPl14: _chkPl14,
      chkPl15: _chkPl15,
      chkPl16: _chkPl16,
      chkPl17: _chkPl17,
      chkNl1: _chkNl1,
      chkNl2: _chkNl2,
      chkNl3: _chkNl3,
      chkTl1: _chkTl1,
      chkTl2: _chkTl2,
      chkTl3: _chkTl3,
      chkDl1: _chkDl1,
      chkDl2: _chkDl2,
      chkDl3: _chkDl3,
      chkNn1: _chkNn1,
      chkNn2: _chkNn2,
      chkY01: _chkY01,
      chkY02: _chkY02,
      chkTy1: _chkTy1,
      chkTy2: _chkTy2,
      chkTy3: _chkTy3,
      chk2T1: _chk2T1,
      chk2T2: _chk2T2,
      chk2T3: _chk2T3,
      chk2T4: _chk2T4,
      chk2T5: _chk2T5,
      sslv1: _sslv1,
      lvNuocngoai: _workedAbroad,
      idKynang: _idKynang,
      idKinhnghiem: _idKinhnghiem,
      idLoaiDhld: _idLoaiDhld,
      idCalamviec: _idCalamviec,
      idHinhthucTd: _idHinhthucTd,
      idHinhthuc: _idHinhthuc,
      idMucdich: _idMucdich,
      idMucluong: _idMucluong,
    );
    widget.onDataChanged(updatedData);
  }

  Widget _buildCheckboxRow(String label, List<Map<String, dynamic>> checkboxes) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Wrap(
              spacing: 4,
              runSpacing: 4,
              children: checkboxes.map((cb) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      cb['onChanged'](!cb['value']);
                      _updateFormData();
                    });
                  },
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: Checkbox(
                            value: cb['value'],
                            onChanged: (bool? value) {
                              setState(() {
                                cb['onChanged'](value ?? false);
                                _updateFormData();
                              });
                            },
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            cb['label'],
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                  _buildCheckboxRow('Điều kiện: Nơi làm việc:', [
                    {'label': 'Trong nhà', 'value': _chkTh, 'onChanged': (v) => _chkTh = v},
                    {'label': 'Ngoài trời', 'value': _chkNs, 'onChanged': (v) => _chkNs = v},
                    {'label': 'Hẹn hợp', 'value': _chkNhom, 'onChanged': (v) => _chkNhom = v},
                  ]),
                  _buildCheckboxRow('Trọng lượng nâng:', [
                    {'label': 'Dưới 5Kg', 'value': _chkNl1, 'onChanged': (v) => _chkNl1 = v},
                    {'label': '5-20Kg', 'value': _chkNl2, 'onChanged': (v) => _chkNl2 = v},
                    {'label': 'Trên 20Kg', 'value': _chkNl3, 'onChanged': (v) => _chkNl3 = v},
                  ]),
                  _buildCheckboxRow('Dùng hoặc đi lại:', [
                    {'label': 'Hầu như không có', 'value': _chkTl1, 'onChanged': (v) => _chkTl1 = v},
                    {'label': 'Mức trung bình', 'value': _chkTl2, 'onChanged': (v) => _chkTl2 = v},
                    {'label': 'Cần đúng/đi lại nhiều', 'value': _chkTl3, 'onChanged': (v) => _chkTl3 = v},
                  ]),
                  _buildCheckboxRow('Nghe nói:', [
                    {'label': 'Không cần thiết', 'value': _chkDl1, 'onChanged': (v) => _chkDl1 = v},
                    {'label': 'Nghe nói cơ bản', 'value': _chkDl2, 'onChanged': (v) => _chkDl2 = v},
                    {'label': 'Quan trọng', 'value': _chkDl3, 'onChanged': (v) => _chkDl3 = v},
                  ]),
                  _buildCheckboxRow('Thị lực:', [
                    {'label': 'Mức bình thường', 'value': _chkNn1, 'onChanged': (v) => _chkNn1 = v},
                    {'label': 'Nhìn được vật/chi tiết nhỏ', 'value': _chkNn2, 'onChanged': (v) => _chkNn2 = v},
                  ]),
                  _buildCheckboxRow('Thao tác bằng tay:', [
                    {'label': 'Lắp rắp đồ vật lớn', 'value': _chkY01, 'onChanged': (v) => _chkY01 = v},
                    {'label': 'Lắp rắp đồ vật nhỏ', 'value': _chkY02, 'onChanged': (v) => _chkY02 = v},
                    {'label': 'Lắp rắp đồ vật rất nhỏ', 'value': _chkTy1, 'onChanged': (v) => _chkTy1 = v},
                  ]),
                  _buildCheckboxRow('Dùng 2 tay:', [
                    {'label': 'Dùng 2 tay', 'value': _chk2T1, 'onChanged': (v) => _chk2T1 = v},
                    {'label': 'Đôi khi cần 2 tay', 'value': _chk2T2, 'onChanged': (v) => _chk2T2 = v},
                    {'label': 'Chỉ cần 1 tay', 'value': _chk2T3, 'onChanged': (v) => _chk2T3 = v},
                    {'label': 'Trái', 'value': _chk2T4, 'onChanged': (v) => _chk2T4 = v},
                    {'label': 'Phải', 'value': _chk2T5, 'onChanged': (v) => _chk2T5 = v},
                  ]),
                  _buildCheckboxRow('Chế độ phúc lợi: Hỗ trợ ăn:', [
                    {'label': '1 Bữa', 'value': _chkPl01, 'onChanged': (v) => _chkPl01 = v},
                    {'label': '2 Bữa', 'value': _chkPl02, 'onChanged': (v) => _chkPl02 = v},
                    {'label': '2 Bữa', 'value': _chkPl03, 'onChanged': (v) => _chkPl03 = v},
                    {'label': 'Không hỗ trợ', 'value': _chkPl04, 'onChanged': (v) => _chkPl04 = v},
                  ]),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hỗ trợ bằng tiền:',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Checkbox(
                              value: _chkPl05,
                              onChanged: (v) {
                                setState(() {
                                  _chkPl05 = v ?? false;
                                  _updateFormData();
                                });
                              },
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                            ),
                            const Text('Số tiền'),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _moneyAllowanceController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                ),
                                onChanged: (_) => _updateFormData(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  _buildCheckboxRow('Bảo hiểm:', [
                    {'label': 'BHXH|BHYT', 'value': _chkPl06, 'onChanged': (v) => _chkPl06 = v},
                    {'label': 'BH Nhân thọ', 'value': _chkPl07, 'onChanged': (v) => _chkPl07 = v},
                    {'label': 'Trợ cấp thôi việc', 'value': _chkPl08, 'onChanged': (v) => _chkPl08 = v},
                    {'label': 'Nhà trẻ', 'value': _chkPl09, 'onChanged': (v) => _chkPl09 = v},
                  ]),
                  _buildCheckboxRow('Phương tiện:', [
                    {'label': 'Xe đưa đón', 'value': _chkPl10, 'onChanged': (v) => _chkPl10 = v},
                    {'label': 'Hỗ trợ đi lại', 'value': _chkPl11, 'onChanged': (v) => _chkPl11 = v},
                    {'label': 'Ký túc xá', 'value': _chkPl12, 'onChanged': (v) => _chkPl12 = v},
                    {'label': 'Nhà ở', 'value': _chkPl13, 'onChanged': (v) => _chkPl13 = v},
                  ]),
                  _buildCheckboxRow('Đào tạo:', [
                    {'label': 'Đào tạo nghề', 'value': _chkPl14, 'onChanged': (v) => _chkPl14 = v},
                    {'label': 'Thiết bị hỗ trợ người khuyết tật', 'value': _chkPl15, 'onChanged': (v) => _chkPl15 = v},
                    {'label': 'Cơ hội thăng tiến', 'value': _chkPl16, 'onChanged': (v) => _chkPl16 = v},
                  ]),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Phúc lợi khác:',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Checkbox(
                              value: _chkPl17,
                              onChanged: (v) {
                                setState(() {
                                  _chkPl17 = v ?? false;
                                  _updateFormData();
                                });
                              },
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                            ),
                            const Text('Ghi cụ thể'),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _otherBenefitsController,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                ),
                                onChanged: (_) => _updateFormData(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _workedAbroad,
                              onChanged: (v) {
                                setState(() {
                                  _workedAbroad = v ?? false;
                                  if (!_workedAbroad) {
                                    _workedAbroadCountryId = null;
                                  }
                                  _updateFormData();
                                });
                              },
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                            ),
                            const Text('Đã từng làm việc ở nước ngoài'),
                          ],
                        ),
                        if (_workedAbroad) ...[
                          const SizedBox(height: 8),
                          GenericPicker<QuocGia>(
                            label: 'Quốc gia',
                            hintText: 'Chọn quốc gia',
                            items: locator<List<QuocGia>>(),
                            initialValue: _workedAbroadCountryId,
                            onChanged: (value) {
                              setState(() {
                                _workedAbroadCountryId = value?.id is int ? value?.id : int.tryParse(value?.id?.toString() ?? '');
                                _updateFormData();
                              });
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Dropdowns Section
                  Text(
                    'Thông tin công việc',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GenericPicker<KyNangMemModel>(
                    label: 'Kỹ năng mềm tốt nhất',
                    hintText: 'Chọn',
                    items: locator<List<KyNangMemModel>>(),
                    initialValue: _idKynang is int ? _idKynang : int.tryParse(_idKynang?.toString() ?? ''),
                    onChanged: (value) {
                      setState(() {
                        _idKynang = value?.id;
                        _updateFormData();
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Soft Skills Checkboxes (optimized layout)
                  _buildCheckboxRow('', [
                    {'label': 'Giao tiếp', 'value': _chkGt, 'onChanged': (v) => _chkGt = v},
                    {'label': 'Thuyết trình', 'value': _chkTtr, 'onChanged': (v) => _chkTtr = v},
                    {'label': 'Quản lý thời gian', 'value': _chkQltg, 'onChanged': (v) => _chkQltg = v},
                  ]),
                  _buildCheckboxRow('', [
                    {'label': 'Quản lý nhân sự', 'value': _chkNs, 'onChanged': (v) => _chkNs = v},
                    {'label': 'Tổng hợp, báo cáo', 'value': _chkNhom, 'onChanged': (v) => _chkNhom = v},
                    {'label': 'Thích ứng', 'value': _chkTh, 'onChanged': (v) => _chkTh = v},
                  ]),
                  _buildCheckboxRow('', [
                    {'label': 'Làm việc nhóm', 'value': _chkGs, 'onChanged': (v) => _chkGs = v},
                    {'label': 'Làm việc độc lập', 'value': _chkDl, 'onChanged': (v) => _chkDl = v},
                    {'label': 'Chịu áp lực', 'value': _chkApl, 'onChanged': (v) => _chkApl = v},
                  ]),
                  _buildCheckboxRow('', [
                    {'label': 'Theo dõi giám sát', 'value': _chkPb, 'onChanged': (v) => _chkPb = v},
                    {'label': 'Tư duy phản biện', 'value': _chkTu, 'onChanged': (v) => _chkTu = v},
                  ]),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: Checkbox(
                            value: _chkKhac,
                            onChanged: (v) {
                              setState(() {
                                _chkKhac = v ?? false;
                                _updateFormData();
                              });
                            },
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text('Kỹ năng mềm khác', style: TextStyle(fontSize: 12)),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _softSkillOtherController,
                            decoration: const InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            ),
                            onChanged: (_) => _updateFormData(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  GenericPicker<KinhNghiemLamViec>(
                    label: 'Kinh nghiệm',
                    hintText: 'Chọn',
                    items: locator<List<KinhNghiemLamViec>>(),
                    initialValue: _idKinhnghiem,
                    onChanged: (value) {
                      setState(() {
                        _idKinhnghiem = value?.id?.toString();
                        _updateFormData();
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  GenericPicker<LoaiHopDongLaoDong>(
                    label: 'Loại hợp đồng',
                    hintText: 'Chọn',
                    items: locator<List<LoaiHopDongLaoDong>>(),
                    initialValue: _idLoaiDhld,
                    onChanged: (value) {
                      setState(() {
                        _idLoaiDhld = value?.id?.toString();
                        _updateFormData();
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  GenericPicker<CaLamViec>(
                    label: 'Khả năng đáp ứng',
                    hintText: 'Chọn',
                    items: locator<List<CaLamViec>>(),
                    initialValue: _idCalamviec,
                    onChanged: (value) {
                      setState(() {
                        _idCalamviec = value?.id is int ? value?.id : int.tryParse(value?.id?.toString() ?? '');
                        _updateFormData();
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  GenericPicker<HinhThucTuyenDung>(
                    label: 'Hình thức tuyển dụng',
                    hintText: 'Chọn',
                    items: locator<List<HinhThucTuyenDung>>(),
                    initialValue: _idHinhthucTd,
                    onChanged: (value) {
                      setState(() {
                        _idHinhthucTd = value?.id?.toString();
                        _updateFormData();
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  GenericPicker<HinhThucLamViecModel>(
                    label: 'Hình thức làm việc',
                    hintText: 'Chọn',
                    items: locator<List<HinhThucLamViecModel>>(),
                    initialValue: _idHinhthuc,
                    onChanged: (value) {
                      setState(() {
                        _idHinhthuc = value?.id?.toString();
                        _updateFormData();
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  GenericPicker<MucDichLamViec>(
                    label: 'Mục đích làm việc',
                    hintText: 'Chọn',
                    items: locator<List<MucDichLamViec>>(),
                    initialValue: _idMucdich,
                    onChanged: (value) {
                      setState(() {
                        _idMucdich = value?.id?.toString();
                        _updateFormData();
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  GenericPicker<MucLuongMM>(
                    label: 'Mức lương',
                    hintText: 'Thỏa thuận',
                    items: locator<List<MucLuongMM>>(),
                    initialValue: _idMucluong,
                    onChanged: (value) {
                      setState(() {
                        _idMucluong = value?.id is int ? value?.id : int.tryParse(value?.id?.toString() ?? '');
                        _updateFormData();
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _sslv1,
                            onChanged: (v) {
                              setState(() {
                                _sslv1 = v ?? false;
                                _updateFormData();
                              });
                            },
                          ),
                          const Flexible(
                            child: Text(
                              'Sẵn sàng làm việc',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Làm việc sau'),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 60,
                            child: TextField(
                              controller: _readyToWorkMonthsController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                isDense: true,
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (_) => _updateFormData(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text('tháng'),
                        ],
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
