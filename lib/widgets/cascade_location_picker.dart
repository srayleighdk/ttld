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
import 'package:ttld/bloc/kcn/kcn_cubit.dart';
import 'package:ttld/models/kcn/kcn_model.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/widgets/field/custom_picker.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';

class CascadeLocationPicker extends StatefulWidget {
  const CascadeLocationPicker({
    super.key,
    this.onTinhChanged,
    this.onHuyenChanged,
    this.onXaChanged,
    this.onKCNChanged,
  });

  final Function(Tinh?)? onTinhChanged;
  final Function(Huyen?)? onHuyenChanged;
  final Function(Xa?)? onXaChanged;
  final Function(KCN?)? onKCNChanged;

  @override
  State<CascadeLocationPicker> createState() => _CascadeLocationPickerState();
}

class _CascadeLocationPickerState extends State<CascadeLocationPicker> {
  Tinh? selectedTinh;
  Huyen? selectedHuyen;
  Xa? selectedXa;
  KCN? selectedKCN;
  final TextEditingController _addressDetailController =
      TextEditingController();
  late final KcnCubit _kcnCubit;

  @override
  void initState() {
    super.initState();
    locator<TinhBloc>().add(LoadTinhs());
    _kcnCubit = locator<KcnCubit>();
    _updateAddressDetail();
  }

  @override
  void didUpdateWidget(covariant CascadeLocationPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<TinhBloc, TinhState>(
          builder: (context, state) {
            Widget child;
            if (state is TinhLoaded) {
              // Load Huyens when Tinhs are loaded
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (selectedTinh != null) {
                  context
                      .read<HuyenBloc>()
                      .add(LoadHuyensByTinh(matinh: selectedTinh!.matinh));
                  _kcnCubit.getKCN(selectedTinh!.matinh);
                }
              });
              child = CustomPicker<Tinh>(
                label: const Text('Tình/Thành Phố'),
                items: state.tinhs,
                selectedItem: selectedTinh,
                hint: 'Chọn Tỉnh/Thành Phố',
                displayItemBuilder: (Tinh? tinh) => tinh?.tentinh ?? '',
                onChanged: (Tinh? newValue) {
                  setState(() {
                    selectedTinh = newValue;
                    selectedHuyen = null;
                    selectedXa = null;
                    selectedKCN = null;
                    _updateAddressDetail();
                  });
                  if (newValue != null) {
                    context
                        .read<HuyenBloc>()
                        .add(LoadHuyensByTinh(matinh: newValue.matinh));
                    _kcnCubit.getKCN(newValue.matinh);
                  }
                  widget.onTinhChanged?.call(newValue);
                },
              );
            } else {
              child = Text('Error: ${state.message}');
            }
            return child;
          },
        ),
        const SizedBox(height: 14),
        BlocBuilder<HuyenBloc, HuyenState>(
          builder: (context, state) {
            Widget child;
            if (state is HuyenLoadedByTinh) {
              child = CustomPicker<Huyen>(
                label: const Text('Quận/Huyện'),
                items: state.huyens,
                selectedItem: selectedHuyen,
                hint: 'Chọn Quận/Huyện',
                displayItemBuilder: (Huyen? huyen) => huyen?.tenhuyen ?? '',
                onChanged: (Huyen? newValue) {
                  setState(() {
                    selectedHuyen = newValue;
                    selectedXa = null;
                    selectedKCN = null;
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
            } else {
              child = Text('Error: ${state.message}');
            }
            return child;
          },
        ),
        const SizedBox(height: 14),
        BlocBuilder<XaBloc, XaState>(
          builder: (context, state) {
            Widget child;
            if (state is XaLoadedByHuyen) {
              child = CustomPicker<Xa>(
                label: const Text('Xã/Phường'),
                items: state.xas,
                selectedItem: selectedXa,
                displayItemBuilder: (Xa? xa) => xa?.tenxa ?? '',
                hint: 'Chọn Xã/Phường',
                onChanged: (Xa? newValue) {
                  setState(() {
                    selectedXa = newValue;
                    selectedKCN = null;
                    _updateAddressDetail();
                  });
                  widget.onXaChanged?.call(newValue);
                },
              );
            } else {
              child = Text('Error: ${state.message}');
            }
            return child;
          },
        ),
        const SizedBox(height: 14),
        BlocBuilder<KcnCubit, KcnState>(
          bloc: _kcnCubit,
          builder: (context, state) {
            if (state is KcnLoading) {
              return const CircularProgressIndicator();
            } else if (state is KcnLoaded) {
              return CustomPicker<KCN>(
                items: state.kcnList,
                selectedItem: selectedKCN,
                displayItemBuilder: (KCN? kcn) => kcn?.kcnTen ?? '',
                hint: 'Chọn KCN',
                onChanged: (KCN? newValue) {
                  setState(() {
                    selectedKCN = newValue;
                    _updateAddressDetail();
                  });
                  widget.onKCNChanged?.call(newValue);
                },
              );
            } else if (state is KcnError) {
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
    _kcnCubit.close();
    super.dispose();
  }

  void _updateAddressDetail() {
    _addressDetailController.text = _buildAddressString(selectedXa?.tenxa,
        selectedHuyen?.tenhuyen, selectedTinh?.tentinh, selectedKCN?.kcnTen);
  }

  String _buildAddressString(
      String? xa, String? huyen, String? tinh, String? kcn) {
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
    if (kcn != null && kcn.isNotEmpty) {
      if (address.isNotEmpty) address += ", ";
      address += " $kcn";
    }
    return address;
  }
}
