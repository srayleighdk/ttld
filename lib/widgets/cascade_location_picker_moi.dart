import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/services/tinh_moi_api_service.dart';
import 'package:ttld/core/services/xa_moi_api_service.dart';
import 'package:ttld/models/dmtinhmoi_model.dart';
import 'package:ttld/models/dmxamoi_model.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

/// Cascade location picker for TinhMoi and XaMoi
/// Provides hierarchical selection: TinhMoi > XaMoi
class CascadeLocationPickerMoi extends StatefulWidget {
  const CascadeLocationPickerMoi({
    super.key,
    this.onTinhMoiChanged,
    this.onXaMoiChanged,
    this.initialTinhMoi,
    this.initialXaMoi,
    this.labelTinhMoi = 'Tỉnh/Thành phố mới',
    this.labelXaMoi = 'Xã/Phường mới',
  });

  final int? initialTinhMoi;
  final int? initialXaMoi;
  final Function(DmTinhMoi?)? onTinhMoiChanged;
  final Function(DmXaMoi?)? onXaMoiChanged;
  final String labelTinhMoi;
  final String labelXaMoi;

  @override
  State<CascadeLocationPickerMoi> createState() => _CascadeLocationPickerMoiState();
}

class _CascadeLocationPickerMoiState extends State<CascadeLocationPickerMoi> {
  DmTinhMoi? selectedTinhMoi;
  DmXaMoi? selectedXaMoi;
  List<DmTinhMoi> tinhMoiList = [];
  List<DmXaMoi> xaMoiList = [];
  bool isLoadingTinhMoi = false;
  bool isLoadingXaMoi = false;

  @override
  void initState() {
    super.initState();
    _loadTinhMoi();
  }

  Future<void> _loadTinhMoi() async {
    setState(() {
      isLoadingTinhMoi = true;
    });

    try {
      final response = await locator<TinhMoiApiService>().getTinhMoi();
      final data = response['data'] as List;
      setState(() {
        tinhMoiList = data.map((json) => DmTinhMoi.fromJson(json)).toList();
        isLoadingTinhMoi = false;
      });

      // Load initial data if provided
      if (widget.initialTinhMoi != null) {
        selectedTinhMoi = tinhMoiList.firstWhere(
          (t) => t.id == widget.initialTinhMoi,
          orElse: () => tinhMoiList.first,
        );
        await _loadXaMoi(selectedTinhMoi!.id);

        if (widget.initialXaMoi != null) {
          selectedXaMoi = xaMoiList.firstWhere(
            (x) => x.id == widget.initialXaMoi,
            orElse: () => xaMoiList.first,
          );
        }
        setState(() {});
      }
    } catch (e) {
      debugPrint('Error loading TinhMoi: $e');
      setState(() {
        isLoadingTinhMoi = false;
      });
    }
  }

  Future<void> _loadXaMoi(int matinh) async {
    setState(() {
      isLoadingXaMoi = true;
      xaMoiList = [];
      selectedXaMoi = null;
    });

    try {
      final response = await locator<XaMoiApiService>().getXaMoi(matinh: matinh);
      final data = response['data'] as List;
      setState(() {
        xaMoiList = data.map((json) => DmXaMoi.fromJson(json)).toList();
        isLoadingXaMoi = false;
      });
    } catch (e) {
      debugPrint('Error loading XaMoi: $e');
      setState(() {
        isLoadingXaMoi = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TinhMoi Picker
        GenericPicker<DmTinhMoi>(
          label: widget.labelTinhMoi,
          hintText: isLoadingTinhMoi ? 'Đang tải...' : 'Chọn tỉnh/thành phố',
          items: tinhMoiList,
          initialValue: selectedTinhMoi?.id,
          isLoading: isLoadingTinhMoi,
          onChanged: (value) {
            setState(() {
              selectedTinhMoi = value;
              selectedXaMoi = null;
              xaMoiList = [];
            });
            if (value != null) {
              _loadXaMoi(value.id);
            }
            widget.onTinhMoiChanged?.call(value);
          },
        ),
        const SizedBox(height: 16),

        // XaMoi Picker
        GenericPicker<DmXaMoi>(
          label: widget.labelXaMoi,
          hintText: isLoadingXaMoi
              ? 'Đang tải...'
              : selectedTinhMoi == null
                  ? 'Vui lòng chọn tỉnh trước'
                  : 'Chọn xã/phường',
          items: xaMoiList,
          initialValue: selectedXaMoi?.id,
          isLoading: isLoadingXaMoi,
          onChanged: (value) {
            setState(() {
              selectedXaMoi = value;
            });
            widget.onXaMoiChanged?.call(value);
          },
        ),
      ],
    );
  }
}
