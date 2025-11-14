import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/m02tt11/m02tt11_model.dart';
import 'package:ttld/models/nganh_nghe_bachoc.dart';
import 'package:ttld/models/nganh_nghe_capdo.dart';
import 'package:ttld/models/chuyenmon/chuyenmon.dart';
import 'package:ttld/models/bac_mon_dao_tao_model.dart';
import 'package:ttld/models/chuyen_nganh_dao_tao_model.dart';
import 'package:ttld/models/chuc_danh_model.dart';
import 'package:ttld/models/loai_hinh_model.dart';
import 'package:ttld/models/nganh_nghe_chuyennganh.dart';
import 'package:ttld/models/trinh_do_hoc_van_model.dart';
import 'package:ttld/models/ngoai_ngu_model.dart';
import 'package:ttld/models/status_dg_model.dart';
import 'package:ttld/models/trinh_do_ngoai_ngu_model.dart';
import 'package:ttld/models/trinh_do_tin_hoc_model.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';
import 'package:ttld/widgets/cascade_level_pick_grok.dart';

class Step2EducationExperience extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final M02TT11 formData;
  final Function(M02TT11) onDataChanged;

  const Step2EducationExperience({
    super.key,
    required this.formKey,
    required this.formData,
    required this.onDataChanged,
  });

  @override
  _Step2EducationExperienceState createState() =>
      _Step2EducationExperienceState();
}

class _Step2EducationExperienceState extends State<Step2EducationExperience> {
  // Text Controllers
  late TextEditingController _trinhDoKhac1Controller;
  late TextEditingController _trinhDoKhac2Controller;
  late TextEditingController _kynangNgheController;
  late TextEditingController _congViecCanTimController;
  late TextEditingController _moTaCongViecController;

  // Cached lists for dropdowns (to ensure proper reactivity)
  late List<BacMonDaoTao> _bacMonDaoTaoList; // For CMKT dropdown
  late List<ChuyenNganhDaoTao>
      _chuyenNganhDaoTaoList; // For Chuyên ngành đào tạo dropdown
  late List<ChuyenMon> _chuyenMonList;
  late List<TrinhDoChuyenMon> _trinhDoChuyenMonList;
  late List<NgoaiNgu> _ngoaiNguList; // For Ngoại ngữ dropdowns
  late List<TrinhDoNgoaiNgu> _trinhDoNgoaiNguList; // For Chứng chỉ ĐT dropdowns
  late List<StatusDg> _statusDgList; // For Mức độ dropdowns

  // Dropdown Values
  int? _idhocvan;
  String? _idBacHoc; // Trình độ CMKT - now uses BacMonDaoTao
  int? _idChuyenmon; // Chuyên ngành đào tạo - now uses ChuyenNganhDaoTao
  int? _idChuyenmonKhac;
  String? _idBacHocKhac;
  int? _backynang;

  // Foreign Language
  int? _idNndt1;
  String? _idTdnn1;
  int? _mucNn1;
  int? _idNndt2;
  String? _idTdnn2;
  int? _mucNn2;

  // Computer Skills
  String? _idTdth;
  int? _mucTh;
  String? _idTdthvp;
  int? _mucThvp;

  // Job Position & Industry
  int? _idChucvu;
  String? _idLhdn;
  int? _nganhId;
  int? _level1;
  int? _level2;
  int? _level3;
  int? _level4;

  @override
  void initState() {
    super.initState();

    // Load dropdown data from locator
    _bacMonDaoTaoList = List.from(locator<List<BacMonDaoTao>>());
    _chuyenNganhDaoTaoList = List.from(locator<List<ChuyenNganhDaoTao>>());
    _chuyenMonList = List.from(locator<List<ChuyenMon>>());
    _trinhDoChuyenMonList = List.from(locator<List<TrinhDoChuyenMon>>());
    _ngoaiNguList = List.from(locator<List<NgoaiNgu>>());
    _trinhDoNgoaiNguList = List.from(locator<List<TrinhDoNgoaiNgu>>());
    _statusDgList = List.from(locator<List<StatusDg>>());
    debugPrint(
        '📊 Step2 initState - BacMonDaoTao items: ${_bacMonDaoTaoList.length}');
    if (_bacMonDaoTaoList.isNotEmpty) {
      debugPrint(
          '📊 First BacMonDaoTao: id=${_bacMonDaoTaoList.first.id}, name=${_bacMonDaoTaoList.first.displayName}');
    }
    debugPrint(
        '📊 Step2 initState - ChuyenNganhDaoTao items: ${_chuyenNganhDaoTaoList.length}');
    debugPrint(
        '📊 Step2 initState - ChuyenMon items: ${_chuyenMonList.length}');
    debugPrint(
        '📊 Step2 initState - TrinhDoChuyenMon items: ${_trinhDoChuyenMonList.length}');
    debugPrint('📊 Step2 initState - NgoaiNgu items: ${_ngoaiNguList.length}');
    debugPrint(
        '📊 Step2 initState - TrinhDoNgoaiNgu items: ${_trinhDoNgoaiNguList.length}');

    // Initialize controllers
    _trinhDoKhac1Controller =
        TextEditingController(text: widget.formData.trinhdok1);
    _trinhDoKhac2Controller =
        TextEditingController(text: widget.formData.trinhdok2);
    _kynangNgheController =
        TextEditingController(text: widget.formData.kynangnghe);
    _congViecCanTimController =
        TextEditingController(text: widget.formData.tenVv);
    _moTaCongViecController =
        TextEditingController(text: widget.formData.motaCv);

    // Initialize dropdown values
    _idhocvan = widget.formData.idhocvan;
    _idBacHoc = widget.formData.idBacHoc; // Trình độ CMKT
    _idChuyenmon = widget.formData.idChuyenmon; // Chuyên ngành đào tạo
    _idChuyenmonKhac = widget.formData.idChuyenmonKhac;
    _idBacHocKhac = widget.formData.idBacHocKhac;
    _backynang = widget.formData.backynang;

    // Foreign language
    _idNndt1 = widget.formData.idNndt1;
    _idTdnn1 = widget.formData.idTdnn1;
    _mucNn1 = widget.formData.mucNn1;
    _idNndt2 = widget.formData.idNndt2;
    _idTdnn2 = widget.formData.idTdnn2;
    _mucNn2 = widget.formData.mucNn2;

    // Computer skills
    _idTdth = widget.formData.idTdth;
    _mucTh = widget.formData.mucTh;
    _idTdthvp = widget.formData.idTdthvp;
    _mucThvp = widget.formData.mucThvp;

    // Job position
    _idChucvu = widget.formData.idChucvu;
    _idLhdn = widget.formData.idLhdn;
    _nganhId = widget.formData.nganhId;
    _level1 = widget.formData.level1;
    _level2 = widget.formData.level2;
    _level3 = widget.formData.level3;
    _level4 = widget.formData.level4;
  }

  @override
  void dispose() {
    _trinhDoKhac1Controller.dispose();
    _trinhDoKhac2Controller.dispose();
    _kynangNgheController.dispose();
    _congViecCanTimController.dispose();
    _moTaCongViecController.dispose();
    super.dispose();
  }

  void _updateFormData() {
    final updatedData = widget.formData.copyWith(
      trinhdok1: _trinhDoKhac1Controller.text,
      trinhdok2: _trinhDoKhac2Controller.text,
      kynangnghe: _kynangNgheController.text,
      tenVv: _congViecCanTimController.text,
      motaCv: _moTaCongViecController.text,
      idhocvan: _idhocvan,
      idBacHoc: _idBacHoc, // Trình độ CMKT
      idChuyenmon: _idChuyenmon, // Chuyên ngành đào tạo
      idChuyenmonKhac: _idChuyenmonKhac,
      idBacHocKhac: _idBacHocKhac,
      backynang: _backynang,
      idNndt1: _idNndt1,
      idTdnn1: _idTdnn1,
      mucNn1: _mucNn1,
      idNndt2: _idNndt2,
      idTdnn2: _idTdnn2,
      mucNn2: _mucNn2,
      idTdth: _idTdth,
      mucTh: _mucTh,
      idTdthvp: _idTdthvp,
      mucThvp: _mucThvp,
      idChucvu: _idChucvu,
      idLhdn: _idLhdn,
      nganhId: _nganhId,
      level1: _level1,
      level2: _level2,
      level3: _level3,
      level4: _level4,
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
              'Trình độ và kinh nghiệm',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),

            // Row 1: Trình độ học vấn | Trình độ CMKT
            Row(
              children: [
                Expanded(
                  child: GenericPicker<TrinhDoHocVan>(
                    label: 'Trình độ học vấn',
                    hintText: 'Chọn',
                    items: locator<List<TrinhDoHocVan>>(),
                    initialValue: _idhocvan,
                    onChanged: (value) {
                      setState(() {
                        _idhocvan = value?.id is int
                            ? value?.id
                            : int.tryParse(value?.id?.toString() ?? '');
                        _updateFormData();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GenericPicker<BacMonDaoTao>(
                    label: 'Trình độ CMKT',
                    hintText: 'Chọn',
                    items: _bacMonDaoTaoList,
                    initialValue: _idBacHoc,
                    onChanged: (value) {
                      setState(() {
                        _idBacHoc = value?.id?.toString();
                        _updateFormData();
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Row 1b: Chuyên ngành đào tạo
            GenericPicker<ChuyenNganhDaoTao>(
              label: 'Chuyên ngành đào tạo',
              hintText: 'Chọn',
              items: _chuyenNganhDaoTaoList,
              initialValue: _idChuyenmon,
              onChanged: (value) {
                setState(() {
                  _idChuyenmon = value?.id is int
                      ? value?.id
                      : int.tryParse(value?.id?.toString() ?? '');
                  _updateFormData();
                });
              },
            ),
            const SizedBox(height: 16),

            // Row 2: Chuyên môn khác
            GenericPicker<ChuyenMon>(
              label: 'Chuyên môn khác',
              hintText: 'Chọn',
              items: _chuyenMonList,
              initialValue: _idChuyenmonKhac,
              onChanged: (value) {
                setState(() {
                  _idChuyenmonKhac = value?.id is int
                      ? value?.id
                      : int.tryParse(value?.id?.toString() ?? '');
                  _updateFormData();
                });
              },
            ),
            const SizedBox(height: 16),

            // Row 2b: Trình độ khác 1 | Trình độ khác 2
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    labelText: 'Trình độ khác 1',
                    hintText: 'Nhập trình độ',
                    controller: _trinhDoKhac1Controller,
                    onChanged: (_) => _updateFormData(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomTextField(
                    labelText: 'Trình độ khác 2',
                    hintText: 'Nhập trình độ',
                    controller: _trinhDoKhac2Controller,
                    onChanged: (_) => _updateFormData(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Row 3: Chuyên ngành khác
            GenericPicker<ChuyenNganhDaoTao>(
              label: 'Chuyên ngành khác',
              hintText: 'Chọn',
              items: _chuyenNganhDaoTaoList,
              initialValue: _idBacHocKhac,
              onChanged: (value) {
                setState(() {
                  _idBacHocKhac = value?.id?.toString();
                  _updateFormData();
                });
              },
            ),
            const SizedBox(height: 16),

            // Row 3b: Kỹ năng nghề | Bậc nghề
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomTextField(
                    labelText: 'Kỹ năng nghề',
                    hintText: 'Nhập kỹ năng',
                    controller: _kynangNgheController,
                    onChanged: (_) => _updateFormData(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Bậc nghề',
                      hintText: '0',
                      border: OutlineInputBorder(),
                    ),
                    controller: TextEditingController(
                        text: _backynang?.toString() ?? '0'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      _backynang = int.tryParse(value);
                      _updateFormData();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Row 4: Foreign Language 1
            Row(
              children: [
                Expanded(
                  child: GenericPicker<NgoaiNgu>(
                    label: 'Ngoại ngữ 1',
                    hintText: 'Chọn',
                    items: _ngoaiNguList,
                    initialValue: _idNndt1,
                    onChanged: (value) {
                      setState(() {
                        _idNndt1 = value?.id is int
                            ? value?.id
                            : int.tryParse(value?.id?.toString() ?? '');
                        _updateFormData();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GenericPicker<TrinhDoNgoaiNgu>(
                    label: 'Chứng chỉ ĐT',
                    hintText: 'Chọn',
                    items: _trinhDoNgoaiNguList,
                    initialValue: _idTdnn1,
                    onChanged: (value) {
                      setState(() {
                        _idTdnn1 = value?.id?.toString();
                        _updateFormData();
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Row 4b: Mức độ
            GenericPicker<StatusDg>(
              label: 'Mức độ',
              hintText: 'Chọn mức độ',
              items: _statusDgList,
              initialValue: _mucNn1,
              onChanged: (value) {
                setState(() {
                  _mucNn1 = value?.id is int
                      ? value?.id
                      : int.tryParse(value?.id?.toString() ?? '');
                  _updateFormData();
                });
              },
            ),
            const SizedBox(height: 16),

            // Row 5: Foreign Language 2
            Row(
              children: [
                Expanded(
                  child: GenericPicker<NgoaiNgu>(
                    label: 'Ngoại ngữ 2',
                    hintText: 'Chọn',
                    items: _ngoaiNguList,
                    initialValue: _idNndt2,
                    onChanged: (value) {
                      setState(() {
                        _idNndt2 = value?.id is int
                            ? value?.id
                            : int.tryParse(value?.id?.toString() ?? '');
                        _updateFormData();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GenericPicker<TrinhDoNgoaiNgu>(
                    label: 'Chứng chỉ ĐT',
                    hintText: 'Chọn',
                    items: _trinhDoNgoaiNguList,
                    initialValue: _idTdnn2,
                    onChanged: (value) {
                      setState(() {
                        _idTdnn2 = value?.id?.toString();
                        _updateFormData();
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Row 5b: Mức độ
            GenericPicker<StatusDg>(
              label: 'Mức độ',
              hintText: 'Chọn mức độ',
              items: _statusDgList,
              initialValue: _mucNn2,
              onChanged: (value) {
                setState(() {
                  _mucNn2 = value?.id is int
                      ? value?.id
                      : int.tryParse(value?.id?.toString() ?? '');
                  _updateFormData();
                });
              },
            ),
            const SizedBox(height: 16),

            // Row 6: Computer Skills
            Row(
              children: [
                Expanded(
                  child: GenericPicker<TrinhDoTinHoc>(
                    label: 'Tin học',
                    hintText: 'Chọn',
                    items: locator<List<TrinhDoTinHoc>>(),
                    initialValue: _idTdth,
                    onChanged: (value) {
                      setState(() {
                        _idTdth = value?.id?.toString();
                        _updateFormData();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GenericPicker<StatusDg>(
                    label: 'Mức độ',
                    hintText: 'Chọn mức độ',
                    items: _statusDgList,
                    initialValue: _mucTh,
                    onChanged: (value) {
                      setState(() {
                        _mucTh = value?.id is int
                            ? value?.id
                            : int.tryParse(value?.id?.toString() ?? '');
                        _updateFormData();
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Row 6b: Ngành nghề
            GenericPicker<NganhNgheChuyenNganh>(
              label: 'Ngành nghề',
              hintText: 'Chọn',
              items: locator<List<NganhNgheChuyenNganh>>(),
              initialValue: _nganhId,
              onChanged: (value) {
                setState(() {
                  _nganhId = value?.id is int
                      ? value?.id
                      : int.tryParse(value?.id?.toString() ?? '');
                  _updateFormData();
                });
              },
            ),
            const SizedBox(height: 16),

            // Row 7: Office Computer Skills
            Row(
              children: [
                Expanded(
                  child: GenericPicker<TrinhDoTinHoc>(
                    label: 'Tin học văn phòng',
                    hintText: 'Chọn',
                    items: locator<List<TrinhDoTinHoc>>(),
                    initialValue: _idTdthvp,
                    onChanged: (value) {
                      setState(() {
                        _idTdthvp = value?.id?.toString();
                        _updateFormData();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GenericPicker<StatusDg>(
                    label: 'Mức độ',
                    hintText: 'Chọn mức độ',
                    items: _statusDgList,
                    initialValue: _mucThvp,
                    onChanged: (value) {
                      setState(() {
                        _mucThvp = value?.id is int
                            ? value?.id
                            : int.tryParse(value?.id?.toString() ?? '');
                        _updateFormData();
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Row 7b: Vị trí CV
            GenericPicker<ChucDanhModel>(
              label: 'Vị trí (CV)',
              hintText: 'Chọn',
              items: locator<List<ChucDanhModel>>(),
              initialValue: _idChucvu,
              onChanged: (value) {
                setState(() {
                  _idChucvu = value?.id is int
                      ? value?.id
                      : int.tryParse(value?.id?.toString() ?? '');
                  _updateFormData();
                });
              },
            ),
            const SizedBox(height: 16),

            // Row 8: Work Experience
            CustomTextField(
              labelText: 'Công việc cần tìm',
              hintText: 'Nhập công việc cần tìm',
              controller: _congViecCanTimController,
              maxLines: 3,
              onChanged: (_) => _updateFormData(),
            ),
            const SizedBox(height: 16),

            // Row 8b: Loại hình DN
            GenericPicker<LoaiHinh>(
              label: 'Loại hình DN',
              hintText: 'Chọn',
              items: locator<List<LoaiHinh>>(),
              initialValue: _idLhdn,
              onChanged: (value) {
                setState(() {
                  _idLhdn = value?.id?.toString();
                  _updateFormData();
                });
              },
            ),
            const SizedBox(height: 16),

            // Row 9-10: Ngành nghề cascading picker (using API with level parameter)
            NganhNgheCapDoPicker(
              initialNganhNgheCapDo1: _level1,
              initialNganhNgheCapDo2: _level2,
              initialNganhNgheCapDo3: _level3,
              initialNganhNgheCapDo4: _level4,
              onNganhNgheCapDoLevel1Changed: (value) {
                setState(() {
                  _level1 = value?.id is int ? value?.id : int.tryParse(value?.id?.toString() ?? '');
                  _updateFormData();
                });
              },
              onNganhNgheCapDoLevel2Changed: (value) {
                setState(() {
                  _level2 = value?.id is int ? value?.id : int.tryParse(value?.id?.toString() ?? '');
                  _updateFormData();
                });
              },
              onNganhNgheCapDoLevel3Changed: (value) {
                setState(() {
                  _level3 = value?.id is int ? value?.id : int.tryParse(value?.id?.toString() ?? '');
                  _updateFormData();
                });
              },
              onNganhNgheCapDoLevel4Changed: (value) {
                setState(() {
                  _level4 = value?.id is int ? value?.id : int.tryParse(value?.id?.toString() ?? '');
                  _updateFormData();
                });
              },
            ),
            const SizedBox(height: 16),

            // Row 11: Job Description
            CustomTextField(
              labelText: 'Mô tả công việc',
              hintText: 'Nhập mô tả công việc',
              controller: _moTaCongViecController,
              maxLines: 5,
              onChanged: (_) => _updateFormData(),
            ),
          ],
        ),
      ),
    );
  }
}
