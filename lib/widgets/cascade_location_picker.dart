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
import 'package:ttld/widgets/field/custom_picker.dart';
import 'package:ttld/widgets/reuseable_widgets/custom_text_field.dart';

class CascadeLocationPicker extends StatefulWidget {
  const CascadeLocationPicker({
    super.key,
    this.onTinhChanged,
    this.onHuyenChanged,
    this.onXaChanged,
    this.onKCNChanged,
    required this.addressDetailController,
    this.initialTinh,
    this.initialHuyen,
    this.initialXa,
    this.initialKCN,
    required this.isNTD,
  });

  final String? initialTinh;
  final String? initialHuyen;
  final String? initialXa;
  final String? initialKCN;
  final Function(Tinh?)? onTinhChanged;
  final Function(Huyen?)? onHuyenChanged;
  final Function(Xa?)? onXaChanged;
  final Function(KCN?)? onKCNChanged;
  final TextEditingController addressDetailController;
  final bool isNTD;

  @override
  State<CascadeLocationPicker> createState() => _CascadeLocationPickerState();
}

class _CascadeLocationPickerState extends State<CascadeLocationPicker> {
  Tinh? selectedTinh;
  Huyen? selectedHuyen;
  Xa? selectedXa;
  KCN? selectedKCN;
  late final KcnCubit _kcnCubit;
  bool _showAddressDetail = true;

  @override
  void initState() {
    super.initState();
    _kcnCubit = context.read<KcnCubit>();
    _initializeTinh();
  }

  void _initializeTinh() async {
    final tinhBloc = BlocProvider.of<TinhBloc>(context);
    tinhBloc.add(LoadTinhs());

    if (widget.initialTinh != null) {
      final tinhState =
          await tinhBloc.stream.firstWhere((state) => state is TinhLoaded);
      if (tinhState is TinhLoaded) {
        final foundTinh = tinhState.tinhs.firstWhere(
          (tinh) => tinh.matinh == widget.initialTinh,
          orElse: () => tinhState.tinhs.first,
        );
        setState(() {
          selectedTinh = foundTinh;
        });
        _loadInitialData(foundTinh);
      }
    }

    if (selectedTinh != null && widget.initialHuyen != null) {
      final huyenBloc = context.read<HuyenBloc>();
      huyenBloc.add(LoadHuyensByTinh(matinh: selectedTinh!.matinh));

      final huyenState = await huyenBloc.stream
          .firstWhere((state) => state is HuyenLoadedByTinh);
      if (huyenState is HuyenLoadedByTinh) {
        final foundHuyen = huyenState.huyens.firstWhere(
          (huyen) => huyen.mahuyen == widget.initialHuyen,
          orElse: () => huyenState.huyens.first,
        );
        setState(() {
          selectedHuyen = foundHuyen;
        });
        _loadHuyenData(foundHuyen);
      }
    }

    if (selectedHuyen != null && widget.initialXa != null) {
      final xaBloc = context.read<XaBloc>();
      xaBloc.add(LoadXasByHuyen(mahuyen: selectedHuyen!.mahuyen));

      final xaState =
          await xaBloc.stream.firstWhere((state) => state is XaLoadedByHuyen);
      if (xaState is XaLoadedByHuyen) {
        final foundXa = xaState.xas.firstWhere(
          (xa) => xa.maxa == widget.initialXa,
          orElse: () => xaState.xas.first,
        );
        setState(() {
          selectedXa = foundXa;
        });
        _loadXaData(foundXa);
      }
    }

    if (widget.isNTD && selectedTinh != null && widget.initialKCN != null) {
      final kcnCubit = context.read<KcnCubit>();
      kcnCubit.getKCN(selectedTinh!.matinh);

      final kcnState =
          await kcnCubit.stream.firstWhere((state) => state is KcnLoaded);
      if (kcnState is KcnLoaded) {
        final foundKCN = kcnState.kcnList.firstWhere(
          (kcn) => kcn.kcnId == int.tryParse(widget.initialKCN ?? ''),
          orElse: () => kcnState.kcnList.first,
        );
        setState(() {
          selectedKCN = foundKCN;
        });
        widget.onKCNChanged?.call(foundKCN);
      }
    }

    // BlocProvider.of<KcnCubit>(context).getKCN(selectedTinh?.matinh ?? '');
    _updateAddressDetail();
  }

  void _loadInitialData(Tinh tinh) {
    context.read<HuyenBloc>().add(LoadHuyensByTinh(matinh: tinh.matinh));
    if (widget.isNTD) {
      _kcnCubit.getKCN(tinh.matinh);
    }
    widget.onTinhChanged?.call(tinh);
  }

  void _loadHuyenData(Huyen huyen) {
    context.read<XaBloc>().add(LoadXasByHuyen(mahuyen: huyen.mahuyen));
    widget.onHuyenChanged?.call(huyen);
  }

  void _loadXaData(Xa xa) {
    widget.onXaChanged?.call(xa);
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
              child = CustomPicker<Tinh>(
                key: ValueKey(state.tinhs),
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
                    _showAddressDetail = true;
                    _updateAddressDetail();
                  });
                  if (newValue != null) {
                    context
                        .read<HuyenBloc>()
                        .add(LoadHuyensByTinh(matinh: newValue.matinh));
                    if (widget.isNTD) {
                      _kcnCubit.getKCN(newValue.matinh);
                    }
                  }
                  widget.onTinhChanged?.call(newValue);
                },
              );
            } else if (state is TinhError) {
              child = Text('Error: ${(state).message}');
            } else if (state is TinhLoading) {
              child = const CircularProgressIndicator();
            } else {
              child = const Text('Loading Tỉnh...');
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
                    _showAddressDetail = true;
                    _updateAddressDetail();
                  });
                  if (newValue != null) {
                    context
                        .read<XaBloc>()
                        .add(LoadXasByHuyen(mahuyen: newValue.mahuyen));
                  }
                  widget.onHuyenChanged?.call(newValue);
                  if (newValue != null) {
                    context
                        .read<XaBloc>()
                        .add(LoadXasByHuyen(mahuyen: newValue.mahuyen));
                  }
                },
              );
            } else if (state is HuyenError) {
              child = Text('Error: ${(state).message}');
            } else if (state is HuyenLoading) {
              child = const CircularProgressIndicator();
            } else {
              child = CustomPicker<Huyen>(
                label: const Text('Quận/Huyện'),
                items: const [],
                selectedItem: selectedHuyen,
                hint: 'Chọn Quận/Huyện',
                displayItemBuilder: (Huyen? huyen) => huyen?.tenhuyen ?? '',
                onChanged: (Huyen? newValue) {},
              );
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
                    _showAddressDetail = true;
                    _updateAddressDetail();
                  });
                  widget.onXaChanged?.call(newValue);
                },
              );
            } else if (state is XaError) {
              child = Text('Error: ${(state).message}');
            } else if (state is XaLoading) {
              child = const CircularProgressIndicator();
            } else {
              child = CustomPicker<Xa>(
                label: const Text('Xã/Phường'),
                items: const [],
                selectedItem: selectedXa,
                displayItemBuilder: (Xa? xa) => xa?.tenxa ?? '',
                hint: 'Chọn Xã/Phường',
                onChanged: (Xa? newValue) {},
              );
              ;
            }
            print('XaState: ${state.runtimeType}'); // Add this line
            return child;
          },
        ),
        const SizedBox(height: 14),
        if (widget.isNTD)
          BlocBuilder<KcnCubit, KcnState>(
            builder: (context, state) {
              Widget child;
              if (state is KcnLoading) {
                child = const CircularProgressIndicator();
              } else if (state is KcnLoaded) {
                child = CustomPicker<KCN>(
                  items: state.kcnList,
                  selectedItem: selectedKCN,
                  displayItemBuilder: (KCN? kcn) => kcn?.kcnTen ?? '',
                  hint: 'Chọn KCN',
                  onChanged: (KCN? newValue) {
                    setState(() {
                      selectedKCN = newValue;
                    });
                    widget.onKCNChanged?.call(newValue);
                  },
                );
              } else if (state is KcnError) {
                child = Text('Error: ${state.message}');
              } else {
                child = const SizedBox.shrink();
              }
              return child;
            },
          ),
        const SizedBox(height: 14),
        if (_showAddressDetail)
          CustomTextField.addressDetail(
            controller: widget.addressDetailController,
            tinh: selectedTinh?.tentinh,
            huyen: selectedHuyen?.tenhuyen,
            xa: selectedXa?.tenxa,
          ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _updateAddressDetail() {
    widget.addressDetailController.text = _buildAddressString(
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
