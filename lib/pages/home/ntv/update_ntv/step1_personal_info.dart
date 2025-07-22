import 'package:flutter/material.dart';
import 'package:ttld/models/dan_toc_model.dart';
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

class Step1PersonalInfo extends StatelessWidget {
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
  }) : super(key: key);

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(26),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection(
      ThemeData theme, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionHeader(theme, title),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withAlpha(13),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // _buildFormSection(
          //   theme,
          //   'Thông tin tài khoản',
          //   [
          //     CustomTextField.email(
          //       controller: emailController,
          //       validator: 'email',
          //     ),
          //     const SizedBox(height: 12),
          //     CustomTextField(
          //       labelText: 'Tên đăng nhập',
          //       hintText: 'Tên đăng nhập',
          //       controller: usernameController,
          //       validator: 'not_empty',
          //     ),
          //     // const SizedBox(height: 12),
          //     // CustomTextField.password(
          //     //   controller: passwordController,
          //     //   validator: 'not_empty',
          //     // ),
          //   ],
          // ),
          _buildFormSection(
            theme,
            'Thông tin cá nhân',
            [
              CustomTextField(
                labelText: 'Họ và tên',
                hintText: 'Họ và tên',
                controller: hotenController,
                validator: 'not_empty',
              ),
              const SizedBox(height: 12),
              CustomPickDateTimeGrok(
                hintText: 'Ngày sinh',
                initialValue: uvngaysinhController,
                validator: (DateTime? value) {
                  if (value == null) {
                    return 'Ngày sinh không được để trống';
                  }
                  return null;
                },
                onChanged: onNgaysinhChanged,
              ),
              const SizedBox(height: 12),
              GenericPicker<NguonThuThap>(
                label: 'Nguồn thu thập',
                items: locator<List<NguonThuThap>>(),
                initialValue: idNguonThuThap,
                onChanged: onNguonThuThapChanged,
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Thông tin chi tiết',
            [
              Row(
                children: [
                  Expanded(
                    child: CustomPickerMap(
                      label: Text('Giới tính'),
                      items: gioiTinhOptions,
                      selectedItem: uvGioitinh,
                      onChanged: onGioitinhChanged,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomPickerMap(
                      label: Text('Hôn nhân'),
                      items: hoNhanOptions,
                      selectedItem: uvHonnhanId,
                      onChanged: onHonnhanChanged,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              CustomTextField(
                labelText: 'Số CCCD',
                controller: cmndController,
                validator: 'not_empty',
                hintText: 'Số CCCD',
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: CustomPickDateTimeGrok(
                      initialValue: uvNgaycap,
                      onChanged: onNgaycapChanged,
                      hintText: 'Ngày cấp',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Nơi cấp',
                      hintText: 'Nơi cấp',
                      controller: uvnoicapController,
                      validator: 'not_empty',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              CustomTextField(
                labelText: 'Số điện thoại',
                hintText: 'Số điện thoại',
                controller: dienthoaiController,
                validator: 'not_empty',
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Thông tin bổ sung',
            [
              GenericPicker<DanToc>(
                label: 'Dân Tộc',
                items: locator<List<DanToc>>(),
                initialValue: idDanToc,
                onChanged: onDanTocChanged,
              ),
              const SizedBox(height: 12),
              GenericPicker<TtTantat>(
                label: 'Tình trạng tàn tật',
                items: locator<List<TtTantat>>(),
                initialValue: uvTinhtrangtantatId,
                onChanged: onTinhTrangTanTatChanged,
              ),
              const SizedBox(height: 12),
              GenericPicker<DoiTuong>(
                label: 'Đối tượng chính sách',
                items: locator<List<DoiTuong>>(),
                initialValue: uvDoiTuongChingSachId,
                onChanged: onDoiTuongChinhSachChanged,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Chiều cao (cm)',
                      hintText: 'Chiều cao (cm)',
                      controller: uvchieucaoController,
                      validator: 'not_empty',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Cân nặng (kg)',
                      hintText: 'Cân nặng (kg)',
                      controller: uvcannangController,
                      validator: 'not_empty',
                    ),
                  ),
                ],
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Địa chỉ',
            [
              CascadeLocationPickerGrok(
                initialTinh: idTinhController.text,
                initialHuyen: idHuyenController.text,
                initialXa: idXaController.text,
                onTinhChanged: (tinh) {
                  onLocationChanged(tinh?.id, null, null);
                },
                onHuyenChanged: (huyen) {
                  onLocationChanged(null, huyen?.id, null);
                },
                onXaChanged: (xa) {
                  onLocationChanged(null, null, xa?.maxa);
                },
                isNTD: false,
                addressDetailController: diachichitietController,
              ),
              const SizedBox(height: 12),
              GenericPicker<TinhThanhModel>(
                label: 'Thành phố nơi làm việc',
                items: locator<List<TinhThanhModel>>(),
                initialValue: idThanhPho,
                onChanged: onThanhPhoChanged,
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Trình độ chuyên môn',
            [
              GenericPicker<TrinhDoVanHoa>(
                label: 'Trình độ văn hóa',
                items: locator<List<TrinhDoVanHoa>>(),
                initialValue: uvcmTrinhdoId,
                onChanged: onTrinhDoVanHoaChanged,
              ),
              // Add other fields for professional qualifications if needed
            ],
          ),
        ],
      ),
    );
  }
}
