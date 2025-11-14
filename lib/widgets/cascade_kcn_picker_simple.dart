import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/services/danhmuc_kcn_api_service.dart';
import 'package:ttld/models/tinh/tinh.dart';
import 'package:ttld/models/kcn/kcn_model.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

class CascadeKcnPicker extends StatefulWidget {
  final String? initialTinhId;
  final int? initialKcnId;
  final String tinhLabel;
  final String kcnLabel;
  final Function(String?)? onTinhChanged;
  final Function(int?)? onKcnChanged;

  const CascadeKcnPicker({
    super.key,
    this.initialTinhId,
    this.initialKcnId,
    this.tinhLabel = 'Tỉnh/Thành phố',
    this.kcnLabel = 'Khu CN/KKT',
    this.onTinhChanged,
    this.onKcnChanged,
  });

  @override
  State<CascadeKcnPicker> createState() => _CascadeKcnPickerState();
}

class _CascadeKcnPickerState extends State<CascadeKcnPicker> {
  String? _selectedTinhId;
  int? _selectedKcnId;
  List<KCNModel> _kcnList = [];
  bool _isLoadingKcn = false;

  @override
  void initState() {
    super.initState();
    _selectedTinhId = widget.initialTinhId;
    _selectedKcnId = widget.initialKcnId;
    
    // Load initial KCN list if tinhId is provided
    if (_selectedTinhId != null && _selectedTinhId!.isNotEmpty) {
      _loadKcn(_selectedTinhId!);
    }
  }

  Future<void> _loadKcn(String matinh) async {
    if (matinh.isEmpty) return;

    setState(() {
      _isLoadingKcn = true;
      _kcnList = [];
      _selectedKcnId = null;
    });

    try {
      final response = await locator<DanhMucKcnApiService>().getKCN(matinh);
      if (response.statusCode == 200) {
        final responseData = response.data;
        List<dynamic> data;

        if (responseData is Map<String, dynamic>) {
          data = responseData['data'] as List<dynamic>? ?? [];
        } else if (responseData is List<dynamic>) {
          data = responseData;
        } else {
          data = [];
        }

        setState(() {
          _kcnList = data.map((json) => KCNModel.fromJson(json)).toList();
          _isLoadingKcn = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading KCN: $e');
      setState(() {
        _isLoadingKcn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GenericPicker<Tinh>(
          label: widget.tinhLabel,
          hintText: 'Không xác định',
          items: locator<List<Tinh>>(),
          initialValue: _selectedTinhId,
          onChanged: (value) {
            setState(() {
              _selectedTinhId = value?.id?.toString();
            });
            widget.onTinhChanged?.call(_selectedTinhId);
            
            if (value?.id != null) {
              _loadKcn(value!.id.toString());
            } else {
              setState(() {
                _kcnList = [];
                _selectedKcnId = null;
              });
              widget.onKcnChanged?.call(null);
            }
          },
        ),
        const SizedBox(height: 16),
        GenericPicker<KCNModel>(
          label: widget.kcnLabel,
          hintText: _isLoadingKcn ? 'Đang tải...' : 'Chọn',
          items: _kcnList,
          initialValue: _selectedKcnId,
          onChanged: (value) {
            if (!_isLoadingKcn) {
              setState(() {
                _selectedKcnId = value?.id;
              });
              widget.onKcnChanged?.call(_selectedKcnId);
            }
          },
        ),
      ],
    );
  }
}
