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
import 'package:ttld/widgets/field/custom_picker.dart';

class CascadeLocationPicker extends StatefulWidget {
  const CascadeLocationPicker({Key? key}) : super(key: key);

  @override
  State<CascadeLocationPicker> createState() => _CascadeLocationPickerState();
}

class _CascadeLocationPickerState extends State<CascadeLocationPicker> {
  Tinh? selectedTinh;
  Huyen? selectedHuyen;
  Xa? selectedXa;

  @override
  void initState() {
    super.initState();
    context.read<TinhBloc>().add(LoadTinhs());
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
              return CustomPicker<Tinh>(
                items: state.tinhs,
                selectedItem: selectedTinh,
                hint: 'Chọn Tỉnh',
                displayItemBuilder: (Tinh? tinh) => tinh?.tentinh ?? '',
                onChanged: (Tinh? newValue) {
                  setState(() {
                    selectedTinh = newValue;
                    selectedHuyen = null;
                    selectedXa = null;
                  });
                  if (newValue != null) {
                    context
                        .read<HuyenBloc>()
                        .add(LoadHuyensByTinh(matinh: newValue.matinh));
                  }
                },
              );
            } else if (state is TinhError) {
              return Text('Error: ${state.message}');
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        const SizedBox(height: 16),
        BlocBuilder<HuyenBloc, HuyenState>(
          builder: (context, state) {
            if (state is HuyenLoading) {
              return const CircularProgressIndicator();
            } else if (state is HuyenLoaded) {
              return CustomPicker<Huyen>(
                items: state.huyens,
                selectedItem: selectedHuyen,
                hint: 'Chọn Huyện',
                onChanged: (Huyen? newValue) {
                  setState(() {
                    selectedHuyen = newValue;
                    selectedXa = null;
                  });
                  if (newValue != null) {
                    context
                        .read<XaBloc>()
                        .add(LoadXasByHuyen(mahuyen: newValue.mahuyen));
                  }
                },
              );
            } else if (state is HuyenError) {
              return Text('Error: ${state.message}');
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        const SizedBox(height: 16),
        BlocBuilder<XaBloc, XaState>(
          builder: (context, state) {
            if (state is XaLoading) {
              return const CircularProgressIndicator();
            } else if (state is XaLoaded) {
              return CustomPicker<Xa>(
                items: state.xas,
                selectedItem: selectedXa,
                hint: 'Chọn Xã',
                onChanged: (Xa? newValue) {
                  setState(() {
                    selectedXa = newValue;
                  });
                },
              );
            } else if (state is XaError) {
              return Text('Error: ${state.message}');
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
