import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/bloc/huyen/huyen_bloc.dart';
import 'package:ttld/bloc/huyen/huyen_event.dart';
import 'package:ttld/bloc/huyen/huyen_state.dart';
import 'package:ttld/bloc/tinh/tinh_bloc.dart';
import 'package:ttld/bloc/tinh/tinh_event.dart';
import 'package:ttld/bloc/tinh/tinh_state.dart';
import 'package:ttld/bloc/xa/xa_bloc.dart';
import 'package:ttld/bloc/xa/xa_event.dart';
import 'package:ttld/bloc/xa/xa_state.dart';
import 'package:ttld/models/huyen/huyen.dart';
import 'package:ttld/models/tinh/tinh.dart';
import 'package:ttld/models/xa/xa.dart';
import 'package:ttld/widgets/field/custom_picker.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';

class CascadeLocationPicker extends StatefulWidget {
  final Function(Tinh?)? onTinhChanged;
  final Function(Huyen?)? onHuyenChanged;
  final Function(Xa?)? onXaChanged;

  const CascadeLocationPicker({
    super.key,
    this.onTinhChanged,
    this.onHuyenChanged,
    this.onXaChanged,
  });

  @override
  State<CascadeLocationPicker> createState() => _CascadeLocationPickerState();
}

class _CascadeLocationPickerState extends State<CascadeLocationPicker> {
  Tinh? selectedTinh;
  Huyen? selectedHuyen;
  Xa? selectedXa;
  final TextEditingController _addressDetailController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TinhBloc>().add(LoadTinhs());
    _updateAddressDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<TinhBloc, TinhState>(
          builder: (context, state) {
            if (state is TinhLoading) {
              return const CircularProgressIndicator();
            } else if (state is TinhLoaded) {
              // Load Huyens when Tinhs are loaded
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (selectedTinh != null) {
                  context
                      .read<HuyenBloc>()
                      .add(LoadHuyensByTinh(matinh: selectedTinh!.matinh));
                }
              });
              return CustomPicker<Tinh>(
                items: state.tinhs,
                selectedItem: selectedTinh,
                hint: 'Chọn Tỉnh/Thành Phố',
                displayItemBuilder: (Tinh? tinh) => tinh?.tentinh ?? '',
                onChanged: (Tinh? newValue) {
                  setState(() {
                    selectedTinh = newValue;
                    selectedHuyen = null;
                    selectedXa = null;
                    _updateAddressDetail();
                  });
                  if (newValue != null) {
                    context
                        .read<HuyenBloc>()
                        .add(LoadHuyensByTinh(matinh: newValue.matinh));
                  }
                  widget.onTinhChanged?.call(newValue);
                },
              );
            } else if (state is TinhError) {
              return Text('Error: ${state.message}');
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        const SizedBox(height: 14),
        BlocBuilder<HuyenBloc, HuyenState>(
          builder: (context, state) {
            if (state is HuyenLoading) {
              return const CircularProgressIndicator();
            } else if (state is HuyenLoadedByTinh) {
              return CustomPicker<Huyen>(
                items: state.huyens,
                selectedItem: selectedHuyen,
                hint: 'Chọn Quận/Huyện',
                displayItemBuilder: (Huyen? huyen) => huyen?.tenhuyen ?? '',
                onChanged: (Huyen? newValue) {
                  setState(() {
                    selectedHuyen = newValue;
                    selectedXa = null;
                    _updateAddressDetail();
                  });
                  if (newValue != null) {
                    context
                        .read<XaBloc>()
                        .add(LoadXasByHuyen(mahuyen: newValue.mahuyen));
                  }
                  widget.onHuyenChanged?.call(newValue);
                },
              );
            } else if (state is HuyenError) {
              return Text('Error: ${state.message}');
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        const SizedBox(height: 14),
        BlocBuilder<XaBloc, XaState>(
          builder: (context, state) {
            if (state is XaLoading) {
              return const CircularProgressIndicator();
            } else if (state is XaLoadedByHuyen) {
              return CustomPicker<Xa>(
                items: state.xas,
                selectedItem: selectedXa,
                displayItemBuilder: (Xa? xa) => xa?.tenxa ?? '',
                hint: 'Chọn Xã/Phường',
                onChanged: (Xa? newValue) {
                  setState(() {
                    selectedXa = newValue;
                    _updateAddressDetail();
                  });
                  widget.onXaChanged?.call(newValue);
                },
              );
            } else if (state is XaError) {
              return Text('Error: ${state.message}');
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        const SizedBox(height: 14),
        CustomTextField.addressDetail(
          controller: _addressDetailController,
          tinh: selectedTinh?.tentinh,
          huyen: selectedHuyen?.tenhuyen,
          xa: selectedXa?.tenxa,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _addressDetailController.dispose();
    super.dispose();
  }

  void _updateAddressDetail() {
    _addressDetailController.text = _buildAddressString(
        selectedXa?.tenxa, selectedHuyen?.tenhuyen, selectedTinh?.tentinh);
  }

  String _buildAddressString(String? xa, String? huyen, String? tinh) {
    String address = "";
    if (xa != null && xa.isNotEmpty) {
      address += xa;
    }
    if (huyen != null && huyen.isNotEmpty) {
      if (address.isNotEmpty) address += ", ";
      address += " $huyen";
    }
    if (tinh != null && tinh.isNotEmpty) {
      if (address.isNotEmpty) address += ", ";
      address += " $tinh";
    }
    return address;
  }
}
