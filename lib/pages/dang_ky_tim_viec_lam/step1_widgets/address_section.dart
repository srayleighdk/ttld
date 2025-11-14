import 'package:flutter/material.dart';
import 'package:ttld/models/dmtinhmoi_model.dart';
import 'package:ttld/models/dmxamoi_model.dart';
import 'package:ttld/models/huyen/huyen.dart';
import 'package:ttld/models/tinh/tinh.dart';
import 'package:ttld/models/xa/xa.dart';
import 'package:ttld/widgets/cascade_location_picker_grok.dart';
import 'package:ttld/widgets/cascade_location_picker_moi.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';

class AddressSection extends StatefulWidget {
  // Permanent address (Hộ khẩu) - Old system
  final String? matinhHk;
  final String? mahuyenHk;
  final String? maxaHk;
  final TextEditingController thonHkController;
  final TextEditingController diachiHkController;

  // Permanent address (Hộ khẩu) - New system
  final int? idTinhHk;
  final int? idXaHk;

  // Temporary address (Tạm trú) - Old system
  final String? matinhTt;
  final String? mahuyenTt;
  final String? maxaTt;
  final TextEditingController thonTtController;
  final TextEditingController diachiTtController;

  // Temporary address (Tạm trú) - New system
  final int? idTinhTt;
  final int? idXaTt;

  final Function(String?, String?, String?) onPermanentAddressChanged;
  final Function(int?, int?) onPermanentAddressNewChanged;
  final Function(String?, String?, String?) onTemporaryAddressChanged;
  final Function(int?, int?) onTemporaryAddressNewChanged;
  final VoidCallback onUpdate;

  const AddressSection({
    super.key,
    required this.matinhHk,
    required this.mahuyenHk,
    required this.maxaHk,
    required this.idTinhHk,
    required this.idXaHk,
    required this.thonHkController,
    required this.diachiHkController,
    required this.matinhTt,
    required this.mahuyenTt,
    required this.maxaTt,
    required this.idTinhTt,
    required this.idXaTt,
    required this.thonTtController,
    required this.diachiTtController,
    required this.onPermanentAddressChanged,
    required this.onPermanentAddressNewChanged,
    required this.onTemporaryAddressChanged,
    required this.onTemporaryAddressNewChanged,
    required this.onUpdate,
  });

  @override
  State<AddressSection> createState() => _AddressSectionState();
}

class _AddressSectionState extends State<AddressSection> {
  // Controllers for cascade pickers
  final TextEditingController _permanentAddressDetailController = TextEditingController();
  final TextEditingController _temporaryAddressDetailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize with existing values if any
    _permanentAddressDetailController.text = widget.diachiHkController.text;
    _temporaryAddressDetailController.text = widget.diachiTtController.text;
  }

  @override
  void dispose() {
    _permanentAddressDetailController.dispose();
    _temporaryAddressDetailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ==================== PERMANENT ADDRESS SECTION ====================
        Text(
          'Địa chỉ thường trú',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),

        // Old Address System (Tinh/Huyen/Xa)
        CascadeLocationPickerGrok(
          key: const Key('permanent_address_old'),
          onTinhChanged: (tinh) {
            widget.onPermanentAddressChanged(tinh?.id, widget.mahuyenHk, widget.maxaHk);
            widget.onUpdate();
          },
          onHuyenChanged: (huyen) {
            widget.onPermanentAddressChanged(widget.matinhHk, huyen?.id, widget.maxaHk);
            widget.onUpdate();
          },
          onXaChanged: (xa) {
            widget.onPermanentAddressChanged(widget.matinhHk, widget.mahuyenHk, xa?.id);
            widget.onUpdate();
          },
          onKCNChanged: null,
          addressDetailController: _permanentAddressDetailController,
          initialTinh: widget.matinhHk,
          initialHuyen: widget.mahuyenHk,
          initialXa: widget.maxaHk,
          isNTD: false,
        ),
        const SizedBox(height: 16),

        // Thôn/khối/phố
        CustomTextField(
          labelText: 'Thôn/khối/phố',
          hintText: 'Nhập thôn/khối/phố',
          controller: widget.thonHkController,
          onChanged: (_) => widget.onUpdate(),
        ),
        const SizedBox(height: 16),

        // New Address System (TinhMoi/XaMoi)
        CascadeLocationPickerMoi(
          key: const Key('permanent_address_new'),
          onTinhMoiChanged: (tinhMoi) {
            widget.onPermanentAddressNewChanged(tinhMoi?.id, widget.idXaHk);
            widget.onUpdate();
          },
          onXaMoiChanged: (xaMoi) {
            widget.onPermanentAddressNewChanged(widget.idTinhHk, xaMoi?.id);
            widget.onUpdate();
          },
          initialTinhMoi: widget.idTinhHk,
          initialXaMoi: widget.idXaHk,
          labelTinhMoi: 'Tỉnh mới (Thường trú)',
          labelXaMoi: 'Xã mới (Thường trú)',
        ),
        const SizedBox(height: 32),

        // ==================== TEMPORARY ADDRESS SECTION ====================
        Text(
          'Địa chỉ hiện ở (Tạm trú)',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),

        // Old Address System (Tinh/Huyen/Xa)
        CascadeLocationPickerGrok(
          key: const Key('temporary_address_old'),
          onTinhChanged: (tinh) {
            widget.onTemporaryAddressChanged(tinh?.id, widget.mahuyenTt, widget.maxaTt);
            widget.onUpdate();
          },
          onHuyenChanged: (huyen) {
            widget.onTemporaryAddressChanged(widget.matinhTt, huyen?.id, widget.maxaTt);
            widget.onUpdate();
          },
          onXaChanged: (xa) {
            widget.onTemporaryAddressChanged(widget.matinhTt, widget.mahuyenTt, xa?.id);
            widget.onUpdate();
          },
          onKCNChanged: null,
          addressDetailController: _temporaryAddressDetailController,
          initialTinh: widget.matinhTt,
          initialHuyen: widget.mahuyenTt,
          initialXa: widget.maxaTt,
          isNTD: false,
        ),
        const SizedBox(height: 16),

        // Thôn/khối/phố
        CustomTextField(
          labelText: 'Thôn/khối/phố',
          hintText: 'Nhập thôn/khối/phố',
          controller: widget.thonTtController,
          onChanged: (_) => widget.onUpdate(),
        ),
        const SizedBox(height: 16),

        // New Address System (TinhMoi/XaMoi)
        CascadeLocationPickerMoi(
          key: const Key('temporary_address_new'),
          onTinhMoiChanged: (tinhMoi) {
            widget.onTemporaryAddressNewChanged(tinhMoi?.id, widget.idXaTt);
            widget.onUpdate();
          },
          onXaMoiChanged: (xaMoi) {
            widget.onTemporaryAddressNewChanged(widget.idTinhTt, xaMoi?.id);
            widget.onUpdate();
          },
          initialTinhMoi: widget.idTinhTt,
          initialXaMoi: widget.idXaTt,
          labelTinhMoi: 'Tỉnh mới (Tạm trú)',
          labelXaMoi: 'Xã mới (Tạm trú)',
        ),
      ],
    );
  }
}
