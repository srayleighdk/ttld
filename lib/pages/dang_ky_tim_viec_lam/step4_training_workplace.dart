import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/m02tt11/m02tt11_model.dart';
import 'package:ttld/models/nguyen_nhan_that_nghiep_model.dart';
import 'package:ttld/models/nguon_thuthap_model.dart';
import 'package:ttld/models/ve_tinh_model.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';
import 'package:ttld/widgets/cascade_kcn_picker_simple.dart';

class Step4TrainingWorkplace extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final M02TT11 formData;
  final Function(M02TT11) onDataChanged;

  const Step4TrainingWorkplace({
    super.key,
    required this.formKey,
    required this.formData,
    required this.onDataChanged,
  });

  @override
  _Step4TrainingWorkplaceState createState() => _Step4TrainingWorkplaceState();
}

class _Step4TrainingWorkplaceState extends State<Step4TrainingWorkplace> {
  // Text Controllers
  late TextEditingController _dieukienLamViecController;
  late TextEditingController _khanangNoitroiController;
  late TextEditingController _mucLuongTruocTnController;
  late TextEditingController _lienHeTimViecController;

  // Dropdowns
  String? _noiLvTinh1;
  int? _noiLvkcn1;
  String? _noiLvTinh2;
  int? _noiLvkcn2;
  int? _idNguyennhanTn;
  String? _idNguonThuThap;
  String? _idVetinh;

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    _dieukienLamViecController =
        TextEditingController(text: widget.formData.dieukienlamviec);
    _khanangNoitroiController =
        TextEditingController(text: widget.formData.khanangNoitroi);
    _mucLuongTruocTnController = TextEditingController(
        text: widget.formData.mucLuongTruocThatNghiep?.toString() ?? '0');
    _lienHeTimViecController =
        TextEditingController(text: widget.formData.lienHeTimViec);

    // Initialize dropdowns
    _noiLvTinh1 = widget.formData.noiLvTinh1;
    _noiLvkcn1 = widget.formData.noiLvkcn1;
    _noiLvTinh2 = widget.formData.noiLvTinh2;
    _noiLvkcn2 = widget.formData.noiLvkcn2;
    _idNguyennhanTn = widget.formData.idNguyennhanTn;
    _idNguonThuThap = widget.formData.idNguonThuThap;
    _idVetinh = widget.formData.idVetinh;
  }

  @override
  void dispose() {
    _dieukienLamViecController.dispose();
    _khanangNoitroiController.dispose();
    _mucLuongTruocTnController.dispose();
    _lienHeTimViecController.dispose();
    super.dispose();
  }

  void _updateFormData() {
    final updatedData = widget.formData.copyWith(
      dieukienlamviec: _dieukienLamViecController.text,
      khanangNoitroi: _khanangNoitroiController.text,
      mucLuongTruocThatNghiep: double.tryParse(_mucLuongTruocTnController.text),
      lienHeTimViec: _lienHeTimViecController.text,
      noiLvTinh1: _noiLvTinh1,
      noiLvkcn1: _noiLvkcn1,
      noiLvTinh2: _noiLvTinh2,
      noiLvkcn2: _noiLvkcn2,
      idNguyennhanTn: _idNguyennhanTn,
      idNguonThuThap: _idNguonThuThap,
      idVetinh: _idVetinh,
    );
    widget.onDataChanged(updatedData);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quá trình đào tạo - Nơi làm việc',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),

            // Row 1: Work Location 1 - Cascade Picker
            CascadeKcnPicker(
              initialTinhId: _noiLvTinh1,
              initialKcnId: _noiLvkcn1,
              tinhLabel: 'Nơi làm việc ưu tiên',
              kcnLabel: 'Khu CN/KKT',
              onTinhChanged: (value) {
                setState(() {
                  _noiLvTinh1 = value;
                  _updateFormData();
                });
              },
              onKcnChanged: (value) {
                setState(() {
                  _noiLvkcn1 = value;
                  _updateFormData();
                });
              },
            ),
            const SizedBox(height: 16),

            // Row 2: Work Location 2 - Cascade Picker
            CascadeKcnPicker(
              initialTinhId: _noiLvTinh2,
              initialKcnId: _noiLvkcn2,
              tinhLabel: 'Nơi làm việc 2',
              kcnLabel: 'Khu CN/KKT',
              onTinhChanged: (value) {
                setState(() {
                  _noiLvTinh2 = value;
                  _updateFormData();
                });
              },
              onKcnChanged: (value) {
                setState(() {
                  _noiLvkcn2 = value;
                  _updateFormData();
                });
              },
            ),
            const SizedBox(height: 16),

            // Row 3: Work Conditions
            CustomTextField(
              labelText: 'Điều kiện làm việc',
              hintText: 'Nhập điều kiện làm việc mong muốn',
              controller: _dieukienLamViecController,
              maxLines: 3,
              onChanged: (_) => _updateFormData(),
            ),
            const SizedBox(height: 16),

            // Row 4: Outstanding Abilities
            CustomTextField(
              labelText: 'Khả năng nổi trội',
              hintText: 'Nhập khả năng nổi trội của bạn',
              controller: _khanangNoitroiController,
              maxLines: 3,
              onChanged: (_) => _updateFormData(),
            ),
            const SizedBox(height: 16),

            // Row 5: Unemployment reason
            GenericPicker<NguyenNhanThatNghiep>(
              label: 'Lý do thất nghiệp gần nhất',
              hintText: 'Chọn',
              items: locator<List<NguyenNhanThatNghiep>>(),
              initialValue: _idNguyennhanTn,
              onChanged: (value) {
                setState(() {
                  _idNguyennhanTn = value?.id;
                  _updateFormData();
                });
              },
            ),
            const SizedBox(height: 16),

            // Row 5b: Mức lương trước TN
            CustomTextField(
              labelText: 'Mức lương trước TN',
              hintText: '0',
              controller: _mucLuongTruocTnController,
              keyboardType: TextInputType.number,
              onChanged: (_) => _updateFormData(),
            ),
            const SizedBox(height: 16),

            // Row 6: Job search contact
            CustomTextField(
              labelText: 'Đã liên hệ tìm việc làm ở đơn vị nào:',
              hintText: 'Nhập tên đơn vị đã liên hệ',
              controller: _lienHeTimViecController,
              onChanged: (_) => _updateFormData(),
            ),
            const SizedBox(height: 16),

            // Row 7: Income source and location
            GenericPicker<NguonThuThap>(
              label: 'Nguồn thu nhập',
              hintText: 'Chọn',
              items: locator<List<NguonThuThap>>(),
              initialValue: _idNguonThuThap,
              onChanged: (value) {
                setState(() {
                  _idNguonThuThap = value?.id?.toString();
                  _updateFormData();
                });
              },
            ),
            const SizedBox(height: 16),

            // Row 8: Về tính
            GenericPicker<VeTinh>(
              label: 'Vệ tinh',
              hintText: 'Chọn',
              items: locator<List<VeTinh>>(),
              initialValue: _idVetinh,
              onChanged: (value) {
                setState(() {
                  _idVetinh = value?.id?.toString();
                  _updateFormData();
                });
              },
            ),
            const SizedBox(height: 32),

            // Work Experience Section
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Center(
                child: Text(
                  'KINH NGHIỆM LÀM VIỆC',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Work Experience Table
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Công ty',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Vị trí',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Từ',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Đến',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: const Center(
                      child: Text(
                        'Chưa có dữ liệu',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Training Section
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Center(
                child: Text(
                  'QUÁ TRÌNH ĐÀO TẠO',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Training History Table
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Trường/Cơ sở',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Chuyên ngành',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Từ',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Đến',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: const Center(
                      child: Text(
                        'Chưa có dữ liệu',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Info card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Hoàn tất đăng ký',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Bạn đã hoàn thành tất cả các thông tin cần thiết. Kiểm tra lại thông tin và nhấn "Thêm mới" để hoàn tất đăng ký.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
