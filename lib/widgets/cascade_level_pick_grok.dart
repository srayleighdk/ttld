import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/bloc/nganh_nghe/nganh_nghe_capdo_bloc.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/nganh_nghe_capdo.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

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

  @override
  void initState() async {
    super.initState();
    if (widget.initialNganhNgheCapDo1 != null ||
        widget.initialNganhNgheCapDo2 != null ||
        widget.initialNganhNgheCapDo3 != null ||
        widget.initialNganhNgheCapDo4 != null) {
      final level1Id =
          widget.initialNganhNgheCapDo1 ?? _nganhNgheCapDoLevel1s.first.id;
      final foundNganh = _nganhNgheCapDoLevel1s.firstWhere(
        (capdo) => capdo.id == level1Id,
        orElse: () => _nganhNgheCapDoLevel1s.first,
      );
      setState(() {
        selectedNganhNgheCapDoLevel1 = foundNganh;
      });
      nganhNgheCapDoBloc.add(LoadNganhNgheCapDo2s(id: foundNganh.id, level: 2));
    }
  }

  void _resetLowerLevels(int level) {
    setState(() {
      if (level <= 2) {
        _nganhNgheCapDoLevel2s = null;
        selectedNganhNgheCapDoLevel2 = null;
      }
      if (level <= 3) {
        _nganhNgheCapDoLevel3s = null;
        selectedNganhNgheCapDoLevel3 = null;
      }
      _nganhNgheCapDoLevel4s = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NganhNgheCapDoBloc, NganhNgheCapDoState>(
          bloc: nganhNgheCapDoBloc,
          listener: (context, state) {
            if (state is NganhNgheCapDo2Loaded) {
              print(
                  'Level 2 loaded: ${state.nganhNgheCapDo2s.map((e) => e.id)}');
              setState(() {
                _nganhNgheCapDoLevel2s = state.nganhNgheCapDo2s;
                if (widget.initialNganhNgheCapDo2 != null &&
                    _nganhNgheCapDoLevel2s!.isNotEmpty) {
                  final found = _nganhNgheCapDoLevel2s!.firstWhere(
                    (capdo) => capdo.id == widget.initialNganhNgheCapDo2,
                    orElse: () => _nganhNgheCapDoLevel2s!.first,
                  );
                  selectedNganhNgheCapDoLevel2 = found;
                  nganhNgheCapDoBloc
                      .add(LoadNganhNgheCapDo3s(id: found.id, level: 3));
                }
              });
            } else if (state is NganhNgheCapDo3Loaded) {
              print(
                  'Level 3 loaded: ${state.nganhNgheCapDo3s.map((e) => e.id)}');
              setState(() {
                _nganhNgheCapDoLevel3s = state.nganhNgheCapDo3s;
                if (widget.initialNganhNgheCapDo3 != null &&
                    _nganhNgheCapDoLevel3s!.isNotEmpty) {
                  final found = _nganhNgheCapDoLevel3s!.firstWhere(
                    (capdo) => capdo.id == widget.initialNganhNgheCapDo3,
                    orElse: () => _nganhNgheCapDoLevel3s!.first,
                  );
                  selectedNganhNgheCapDoLevel3 = found;
                  nganhNgheCapDoBloc
                      .add(LoadNganhNgheCapDo4s(id: found.id, level: 4));
                }
              });
            } else if (state is NganhNgheCapDo4Loaded) {
              setState(() {
                _nganhNgheCapDoLevel4s = state.nganhNgheCapDo4s;
              });
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
              setState(() {
                selectedNganhNgheCapDoLevel1 = value;
              });
              _resetLowerLevels(2);
              if (value != null) {
                nganhNgheCapDoBloc
                    .add(LoadNganhNgheCapDo2s(id: value.id, level: 2));
              }
              widget.onNganhNgheCapDoLevel1Changed?.call(value);
            },
          ),
          const SizedBox(height: 14),
          BlocBuilder<NganhNgheCapDoBloc, NganhNgheCapDoState>(
            bloc: nganhNgheCapDoBloc,
            builder: (context, state) {
              print(
                  'Level 2 BlocBuilder: state=$state, items=${_nganhNgheCapDoLevel2s?.map((e) => e.id)}');
              return GenericPicker<NganhNgheCapDo>(
                label: 'Ngành nghề Cấp độ lv2',
                items: _nganhNgheCapDoLevel2s ?? [],
                initialValue: widget.initialNganhNgheCapDo2,
                hintText: 'Chọn ngành nghề',
                isLoading: state is NganhNgheCapDo2Loading,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedNganhNgheCapDoLevel2 = value;
                    });
                    _resetLowerLevels(3);
                    nganhNgheCapDoBloc
                        .add(LoadNganhNgheCapDo3s(id: value.id, level: 3));
                    widget.onNganhNgheCapDoLevel2Changed?.call(value);
                  }
                },
              );
            },
          ),
          const SizedBox(height: 14),
          BlocBuilder<NganhNgheCapDoBloc, NganhNgheCapDoState>(
            bloc: nganhNgheCapDoBloc,
            builder: (context, state) {
              print(
                  'Level 3 BlocBuilder: state=$state, items=${_nganhNgheCapDoLevel3s?.map((e) => e.id)}');
              return GenericPicker<NganhNgheCapDo>(
                label: 'Cấp độ',
                items: _nganhNgheCapDoLevel3s ?? [],
                initialValue: widget.initialNganhNgheCapDo3,
                hintText: 'Chọn cấp độ',
                isLoading: state is NganhNgheCapDo3Loading,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedNganhNgheCapDoLevel3 = value;
                    });
                    widget.onNganhNgheCapDoLevel3Changed?.call(value);
                  }
                },
              );
            },
          ),
          const SizedBox(height: 14),
          BlocBuilder<NganhNgheCapDoBloc, NganhNgheCapDoState>(
            bloc: nganhNgheCapDoBloc,
            builder: (context, state) {
              return GenericPicker<NganhNgheCapDo>(
                label: 'Ngành nghề Cấp độ lv4',
                items: _nganhNgheCapDoLevel4s ?? [],
                initialValue: widget.initialNganhNgheCapDo4,
                hintText: 'Chọn ngành nghề',
                isLoading: state is NganhNgheCapDo4Loading,
                onChanged: (value) {
                  widget.onNganhNgheCapDoLevel4Changed?.call(value);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
