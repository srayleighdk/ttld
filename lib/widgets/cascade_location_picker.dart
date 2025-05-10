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
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/huyen/huyen.dart';
import 'package:ttld/models/tinh/tinh.dart';
import 'package:ttld/models/xa/xa.dart';
import 'package:ttld/bloc/kcn/kcn_cubit.dart';
import 'package:ttld/models/kcn/kcn_model.dart';
import 'package:ttld/widgets/field/custom_picker_grok.dart';
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
  final Function(KCNModel?)? onKCNChanged;
  final TextEditingController addressDetailController;
  final bool isNTD;

  @override
  State<CascadeLocationPicker> createState() => _CascadeLocationPickerState();
}

class _CascadeLocationPickerState extends State<CascadeLocationPicker> {
  Tinh? selectedTinh;
  Huyen? selectedHuyen;
  Xa? selectedXa;
  KCNModel? selectedKCN;
  late final KcnCubit _kcnCubit;
  bool _showAddressDetail = true;

  @override
  void initState() {
    super.initState();
    _kcnCubit = locator<KcnCubit>();
    _initializeTinh();
  }

  void _initializeTinh() {
    final tinhBloc = locator<TinhBloc>();
    tinhBloc.add(LoadTinhs()); // Trigger loading
  }

  void _loadInitialData(Tinh tinh) {
    locator<HuyenBloc>().add(LoadHuyensByTinh(matinh: tinh.matinh));
    if (widget.isNTD) {
      _kcnCubit.getKCN(tinh.matinh);
    }
    widget.onTinhChanged?.call(tinh);
  }

  void _loadHuyenData(Huyen huyen) {
    locator<XaBloc>().add(LoadXasByHuyen(mahuyen: huyen.mahuyen));
    widget.onHuyenChanged?.call(huyen);
  }

  void _loadXaData(Xa xa) {
    widget.onXaChanged?.call(xa);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TinhBloc, TinhState>(
          bloc: locator<TinhBloc>(),
          listener: (context, state) {
            if (state is TinhLoaded && widget.initialTinh != null) {
              final foundTinh = state.tinhs.firstWhere(
                (tinh) => tinh.matinh == widget.initialTinh,
                orElse: () => state.tinhs.first,
              );
              setState(() {
                selectedTinh = foundTinh;
              });
              _loadInitialData(foundTinh);
            }
          },
        ),
        BlocListener<HuyenBloc, HuyenState>(
          bloc: locator<HuyenBloc>(),
          listener: (context, state) {
            if (state is HuyenLoadedByTinh && widget.initialHuyen != null) {
              final foundHuyen = state.huyens.firstWhere(
                (huyen) => huyen.mahuyen == widget.initialHuyen,
                orElse: () => state.huyens.first,
              );
              setState(() {
                selectedHuyen = foundHuyen;
              });
              _loadHuyenData(foundHuyen);
            }
          },
        ),
        BlocListener<XaBloc, XaState>(
          bloc: locator<XaBloc>(),
          listener: (context, state) {
            if (state is XaLoadedByHuyen && widget.initialXa != null) {
              final foundXa = state.xas.firstWhere(
                (xa) => xa.maxa == widget.initialXa,
                orElse: () => state.xas.first,
              );
              setState(() {
                selectedXa = foundXa;
              });
              _loadXaData(foundXa);
            }
          },
        ),
        BlocListener<KcnCubit, KcnState>(
          bloc: locator<KcnCubit>(),
          listener: (context, state) {
            if (state is KcnLoaded &&
                widget.initialKCN != null &&
                widget.isNTD) {
              final foundKCN = state.kcnList.firstWhere(
                (kcn) => kcn.id == int.tryParse(widget.initialKCN ?? ''),
                orElse: () => state.kcnList.first,
              );
              setState(() {
                selectedKCN = foundKCN;
              });
              widget.onKCNChanged?.call(foundKCN);
            }
          },
        ),
      ],
      child: Column(
        children: [
          BlocBuilder<TinhBloc, TinhState>(
            bloc: locator<TinhBloc>(),
            builder: (context, state) {
              print("TinhBlocBuilder: Current state is ${state.runtimeType}");
              Widget child;
              if (state is TinhLoaded) {
                child = CustomPickerGrok<Tinh>(
                  key: ValueKey(state.tinhs),
                  label: const Text('Tỉnh/Thành Phố'),
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
                      locator<HuyenBloc>()
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
            bloc: locator<HuyenBloc>(),
            builder: (context, state) {
              Widget child;
              if (state is HuyenLoadedByTinh) {
                child = CustomPickerGrok<Huyen>(
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
                      locator<XaBloc>()
                          .add(LoadXasByHuyen(mahuyen: newValue.mahuyen));
                    }
                    widget.onHuyenChanged?.call(newValue);
                  },
                );
              } else if (state is HuyenError) {
                child = Text('Error: ${(state).message}');
              } else if (state is HuyenLoading) {
                child = const CircularProgressIndicator();
              } else {
                child = CustomPickerGrok<Huyen>(
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
            bloc: locator<XaBloc>(),
            builder: (context, state) {
              Widget child;
              if (state is XaLoadedByHuyen) {
                child = CustomPickerGrok<Xa>(
                  label: const Text('Xã/Phường'),
                  items: state.xas,
                  selectedItem: selectedXa,
                  hint: 'Chọn Xã/Phường',
                  displayItemBuilder: (Xa? xa) => xa?.tenxa ?? '',
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
                child = CustomPickerGrok<Xa>(
                  label: const Text('Xã/Phường'),
                  items: const [],
                  selectedItem: selectedXa,
                  hint: 'Chọn Xã/Phường',
                  displayItemBuilder: (Xa? xa) => xa?.tenxa ?? '',
                  onChanged: (Xa? newValue) {},
                );
              }
              return child;
            },
          ),
          const SizedBox(height: 14),
          if (widget.isNTD)
            BlocBuilder<KcnCubit, KcnState>(
              bloc: locator<KcnCubit>(),
              builder: (context, state) {
                Widget child;
                if (state is KcnLoading) {
                  child = const CircularProgressIndicator();
                } else if (state is KcnLoaded) {
                  child = CustomPickerGrok<KCNModel>(
                    items: state.kcnList,
                    selectedItem: selectedKCN,
                    displayItemBuilder: (KCNModel? kcn) => kcn?.displayName ?? '',
                    hint: 'Chọn KCN',
                    onChanged: (KCNModel? newValue) {
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
      ),
    );
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
