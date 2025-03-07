import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/bloc/nganh_nghe/nganh_nghe_capdo_bloc.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/nganh_nghe_capdo.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker.dart';

class NganhNgheCapDoPicker extends StatefulWidget {
  final int? initialNganhNgheCapDo1;
  final int? initialNganhNgheCapDo2;
  final int? initialNganhNgheCapDo3;
  final int? initialNganhNgheCapDo4;
  final Function(NganhNgheCapDo?)? onNganhNgheCapDoLevel1Changed;
  final Function(NganhNgheCapDo?)? onNganhNgheCapDoLevel2Changed;
  final Function(NganhNgheCapDo?)? onNganhNgheCapDoLevel3Changed;
  final Function(NganhNgheCapDo?)? onNganhNgheCapDoLevel4Changed;

  const NganhNgheCapDoPicker({
    super.key,
    this.initialNganhNgheCapDo1,
    this.initialNganhNgheCapDo2,
    this.initialNganhNgheCapDo3,
    this.initialNganhNgheCapDo4,
    this.onNganhNgheCapDoLevel1Changed,
    this.onNganhNgheCapDoLevel2Changed,
    this.onNganhNgheCapDoLevel3Changed,
    this.onNganhNgheCapDoLevel4Changed,
  });

  @override
  State<NganhNgheCapDoPicker> createState() => _NganhNgheCapDoPickerState();
}

class _NganhNgheCapDoPickerState extends State<NganhNgheCapDoPicker> {
  final List<NganhNgheCapDo> _nganhNgheCapDoLevel1s =
      locator<List<NganhNgheCapDo>>();
  List<NganhNgheCapDo>? _nganhNgheCapDoLevel2s;
  List<NganhNgheCapDo>? _nganhNgheCapDoLevel3s;
  List<NganhNgheCapDo>? _nganhNgheCapDoLevel4s;

  final nganhNgheCapDoBloc = locator<NganhNgheCapDoBloc>();

  NganhNgheCapDo? selectedNganhNgheCapDoLevel1;
  NganhNgheCapDo? selectedNganhNgheCapDoLevel2;
  NganhNgheCapDo? selectedNganhNgheCapDoLevel3;

  bool isLoadinglv2 = false;
  bool isLoadinglv3 = false;

  @override
  void initState() {
    super.initState();

    if (widget.initialNganhNgheCapDo1 != null) {
      final foundNganh = _nganhNgheCapDoLevel1s.firstWhere(
        (capdo) => capdo.id == widget.initialNganhNgheCapDo1,
        orElse: () => _nganhNgheCapDoLevel1s.first,
      );
      setState(() {
        selectedNganhNgheCapDoLevel1 = foundNganh;
      });
      // Only load level 2 if an initial value is provided
      nganhNgheCapDoBloc.add(LoadNganhNgheCapDo2s(id: foundNganh.id, level: 2));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NganhNgheCapDoBloc, NganhNgheCapDoState>(
          bloc: locator<NganhNgheCapDoBloc>(),
          listener: (context, state) {
            if (state is NganhNgheCapDo2Loaded) {
              _nganhNgheCapDoLevel2s = state.nganhNgheCapDo2s;
              // Load occupations for the selected industry
              isLoadinglv2 = false;
              if (widget.initialNganhNgheCapDo2 != null) {
                final foundNganhNgheCapDo2 = _nganhNgheCapDoLevel2s!.firstWhere(
                  (capdo) => capdo.id == widget.initialNganhNgheCapDo2,
                  orElse: () => _nganhNgheCapDoLevel2s!.first,
                );
                setState(() {
                  selectedNganhNgheCapDoLevel2 = foundNganhNgheCapDo2;
                });
                nganhNgheCapDoBloc.add(LoadNganhNgheCapDo3s(
                    id: foundNganhNgheCapDo2.id, level: 3));
              }
            }
            if (state is NganhNgheCapDo3Loaded) {
              _nganhNgheCapDoLevel3s = state.nganhNgheCapDo3s;
              // Load occupations for the selected industry
              isLoadinglv3 = false;
              if (widget.initialNganhNgheCapDo3 != null) {
                final foundNganhNgheCapDo3 = _nganhNgheCapDoLevel3s!.firstWhere(
                  (capdo) => capdo.id == widget.initialNganhNgheCapDo3,
                  orElse: () => _nganhNgheCapDoLevel3s!.first,
                );
                setState(() {
                  selectedNganhNgheCapDoLevel3 = foundNganhNgheCapDo3;
                });
                nganhNgheCapDoBloc.add(LoadNganhNgheCapDo4s(
                    id: foundNganhNgheCapDo3.id, level: 4));
              }
            }
          },
        ),
      ],
      child: Column(
        children: [
          GenericPicker<NganhNgheCapDo>(
              label: 'Ngành nghề Cấp độ lv1',
              items: _nganhNgheCapDoLevel1s,
              initialValue: widget.initialNganhNgheCapDo1,
              hintText: 'Chọn ngành nghề',
              isLoading: false,
              onChanged: (NganhNgheCapDo? value) {
                selectedNganhNgheCapDoLevel1 = value;
                // Load occupations for the selected industry
                isLoadinglv2 = true;
                nganhNgheCapDoBloc
                    .add(LoadNganhNgheCapDo2s(id: value?.id, level: 2));
                widget.onNganhNgheCapDoLevel1Changed?.call(value);
              }),
          const SizedBox(height: 14),
          BlocBuilder<NganhNgheCapDoBloc, NganhNgheCapDoState>(
              bloc: nganhNgheCapDoBloc,
              builder: (context, state) {
                return GenericPicker<NganhNgheCapDo>(
                  label: 'Ngành nghề Cấp độ lv2',
                  items: _nganhNgheCapDoLevel2s ?? [],
                  initialValue: widget.initialNganhNgheCapDo2,
                  hintText: 'Chọn ngành nghề',
                  isLoading: isLoadinglv2,
                  onChanged: (value) {
                    if (value != null) {
                      selectedNganhNgheCapDoLevel2 = value;
                      isLoadinglv3 = true;

                      // Load skill levels for the selected occupation
                      nganhNgheCapDoBloc
                          .add(LoadNganhNgheCapDo3s(id: value.id, level: 3));
                      widget.onNganhNgheCapDoLevel2Changed?.call(value);
                    }
                  },
                );
              }),
          const SizedBox(height: 14),
          BlocBuilder<NganhNgheCapDoBloc, NganhNgheCapDoState>(
            bloc: nganhNgheCapDoBloc,
            builder: (context, state) {
              return GenericPicker<NganhNgheCapDo>(
                label: 'Cấp độ',
                items: _nganhNgheCapDoLevel3s ?? [],
                initialValue: widget.initialNganhNgheCapDo3,
                hintText: 'Chọn cấp độ',
                isLoading: isLoadinglv3,
                onChanged: (value) {
                  if (value != null) {
                    selectedNganhNgheCapDoLevel3 = value;

                    widget.onNganhNgheCapDoLevel3Changed?.call(value);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
