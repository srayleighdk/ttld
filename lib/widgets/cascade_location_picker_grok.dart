import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/blocs/huyen/huyen_bloc.dart';
import 'package:ttld/blocs/huyen/huyen_event.dart';
import 'package:ttld/blocs/huyen/huyen_state.dart';
import 'package:ttld/blocs/tinh/tinh_bloc.dart';
import 'package:ttld/blocs/tinh/tinh_event.dart';
import 'package:ttld/blocs/tinh/tinh_state.dart';
import 'package:ttld/blocs/xa/xa_bloc.dart';
import 'package:ttld/blocs/xa/xa_event.dart';
import 'package:ttld/blocs/xa/xa_state.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/huyen/huyen.dart';
import 'package:ttld/models/tinh/tinh.dart';
import 'package:ttld/models/xa/xa.dart';
import 'package:ttld/blocs/kcn/kcn_cubit.dart';
import 'package:ttld/models/kcn/kcn_model.dart';
import 'package:ttld/widgets/form/modern_text_field.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';
import 'package:ttld/themes/colors/color_style.dart';
import 'package:theme_provider/theme_provider.dart';

/// Modern, theme-aware cascade location picker widget that follows the project's design system.
/// Provides a hierarchical location selection interface for Tinh > Huyen > Xa > KCN.
class ModernCascadeLocationPicker extends StatefulWidget {
  const ModernCascadeLocationPicker({
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
    this.style,
    this.showAddressDetail = true,
    this.validator,
    this.helperText,
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
  final ModernCascadeLocationPickerStyle? style;
  final bool showAddressDetail;
  final String? Function(String?)? validator;
  final String? helperText;

  @override
  State<ModernCascadeLocationPicker> createState() =>
      _ModernCascadeLocationPickerState();
}

/// Legacy class for backward compatibility
/// @deprecated Use ModernCascadeLocationPicker instead
class CascadeLocationPickerGrok extends StatefulWidget {
  const CascadeLocationPickerGrok({
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
  State<CascadeLocationPickerGrok> createState() => _CascadeLocationPickerGrokState();
}

class _CascadeLocationPickerGrokState extends State<CascadeLocationPickerGrok> {
  @override
  Widget build(BuildContext context) {
    // Use the new ModernCascadeLocationPicker for consistent styling
    return ModernCascadeLocationPicker(
      onTinhChanged: widget.onTinhChanged,
      onHuyenChanged: widget.onHuyenChanged,
      onXaChanged: widget.onXaChanged,
      onKCNChanged: widget.onKCNChanged,
      addressDetailController: widget.addressDetailController,
      initialTinh: widget.initialTinh,
      initialHuyen: widget.initialHuyen,
      initialXa: widget.initialXa,
      initialKCN: widget.initialKCN,
      isNTD: widget.isNTD,
    );
  }
}

class _ModernCascadeLocationPickerState
    extends State<ModernCascadeLocationPicker> {
  Tinh? selectedTinh;
  Huyen? selectedHuyen;
  Xa? selectedXa;
  KCNModel? selectedKCN;
  late final KcnCubit _kcnCubit;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _kcnCubit = locator<KcnCubit>();
    _initializeTinh();
  }

  Future<void> _initializeTinh() async {
    final tinhBloc = locator<TinhBloc>();
    tinhBloc.add(LoadTinhs());

    if (widget.initialTinh != null) {
      final tinhState =
          await tinhBloc.stream.firstWhere((state) => state is TinhLoaded);
      if (tinhState is TinhLoaded) {
        final foundTinh = tinhState.tinhs.firstWhere(
          (tinh) => tinh.id == widget.initialTinh,
          orElse: () => tinhState.tinhs.first,
        );
        setState(() {
          selectedTinh = foundTinh;
        });
        _loadInitialData(foundTinh);
      }
    }

    if (selectedTinh != null && widget.initialHuyen != null) {
      final huyenBloc = locator<HuyenBloc>();
      huyenBloc.add(LoadHuyensByTinh(matinh: selectedTinh!.id));

      final huyenState = await huyenBloc.stream
          .firstWhere((state) => state is HuyenLoadedByTinh);
      if (huyenState is HuyenLoadedByTinh) {
        final foundHuyen = huyenState.huyens.firstWhere(
          (huyen) => huyen.id == widget.initialHuyen,
          orElse: () => huyenState.huyens.first,
        );
        setState(() {
          selectedHuyen = foundHuyen;
        });
        _loadInitialXa(foundHuyen);
      }
    }

    if (selectedHuyen != null && widget.initialXa != null) {
      final xaBloc = locator<XaBloc>();
      xaBloc.add(LoadXasByHuyen(mahuyen: selectedHuyen!.id));

      final xaState =
          await xaBloc.stream.firstWhere((state) => state is XaLoadedByHuyen);
      if (xaState is XaLoadedByHuyen) {
        final foundXa = xaState.xas.firstWhere(
          (xa) => xa.id == widget.initialXa,
          orElse: () => xaState.xas.first,
        );
        setState(() {
          selectedXa = foundXa;
        });
        _updateAddressDetail();
      }
    }

    if (widget.isNTD && selectedTinh != null && widget.initialKCN != null) {
      _kcnCubit.getKCN(selectedTinh!.id);

      final kcnState =
          await _kcnCubit.stream.firstWhere((state) => state is KcnLoaded);
      if (kcnState is KcnLoaded) {
        final foundKCN = kcnState.kcnList.firstWhere(
          (kcn) => kcn.id.toString() == widget.initialKCN,
          orElse: () => kcnState.kcnList.first,
        );
        setState(() {
          selectedKCN = foundKCN;
        });
      }
    }
  }

  void _loadInitialData(Tinh tinh) {
    locator<HuyenBloc>().add(LoadHuyensByTinh(matinh: tinh.id));
    if (widget.isNTD) {
      _kcnCubit.getKCN(tinh.id);
    }
  }

  void _loadInitialXa(Huyen huyen) {
    locator<XaBloc>().add(LoadXasByHuyen(mahuyen: huyen.id));
  }

  void _validateSelection() {
    if (widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(_buildAddressString(
          selectedXa?.displayName,
          selectedHuyen?.displayName,
          selectedTinh?.displayName,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorStyles =
        ThemeProvider.themeOf(context).data.extension<ColorStyles>();
    final effectiveStyle =
        widget.style ?? ModernCascadeLocationPickerStyle.defaultStyle(context);

    return Container(
      padding: effectiveStyle.containerPadding,
      decoration: BoxDecoration(
        color: colorStyles?.surfaceBackground ?? theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(effectiveStyle.borderRadius),
        boxShadow: effectiveStyle.showShadow
            ? [
                BoxShadow(
                  color: (colorStyles?.content ?? theme.colorScheme.onSurface)
                      .withOpacity(0.06),
                  spreadRadius: 0,
                  blurRadius: 16,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          if (effectiveStyle.showHeader)
            _buildHeaderSection(theme, colorStyles),

          // Location Pickers
          _buildTinhPicker(theme, colorStyles, effectiveStyle),
          SizedBox(height: effectiveStyle.spacing),

          _buildHuyenPicker(theme, colorStyles, effectiveStyle),
          SizedBox(height: effectiveStyle.spacing),

          _buildXaPicker(theme, colorStyles, effectiveStyle),
          SizedBox(height: effectiveStyle.spacing),

          // KCN Picker (only for NTD)
          if (widget.isNTD) ...[
            _buildKCNPicker(theme, colorStyles, effectiveStyle),
            SizedBox(height: effectiveStyle.spacing),
          ],

          // Address Detail Field
          if (widget.showAddressDetail)
            _buildAddressDetailField(theme, colorStyles, effectiveStyle),

          // Error Text
          if (_errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                _errorText!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),

          // Helper Text
          if (widget.helperText != null && _errorText == null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                widget.helperText!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: (colorStyles?.content ?? theme.colorScheme.onSurface)
                      .withOpacity(0.6),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(ThemeData theme, ColorStyles? colorStyles) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (colorStyles?.primaryAccent ?? theme.colorScheme.primary)
                  .withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.location_on_outlined,
              color: colorStyles?.primaryAccent ?? theme.colorScheme.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Địa chỉ',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorStyles?.content ?? theme.colorScheme.onSurface,
                  ),
                ),
                Text(
                  'Chọn địa chỉ theo thứ tự: Tỉnh/Thành phố → Quận/Huyện → Xã/Phường',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: (colorStyles?.content ?? theme.colorScheme.onSurface)
                        .withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTinhPicker(ThemeData theme, ColorStyles? colorStyles,
      ModernCascadeLocationPickerStyle style) {
    return BlocBuilder<TinhBloc, TinhState>(
      bloc: locator<TinhBloc>(),
      builder: (context, state) {
        if (state is TinhLoaded) {
          return ModernPicker<Tinh>(
            label: 'Tỉnh/Thành phố',
            hint: 'Chọn Tỉnh/Thành phố',
            items: state.tinhs,
            initialValue: selectedTinh?.id,
            onChanged: (item) {
              final tinh = item;
              setState(() {
                selectedTinh = tinh;
                selectedHuyen = null;
                selectedXa = null;
                selectedKCN = null;
                _updateAddressDetail();
              });
              if (tinh != null) {
                locator<HuyenBloc>().add(LoadHuyensByTinh(matinh: tinh.id));
                if (widget.isNTD) {
                  _kcnCubit.getKCN(tinh.id);
                }
              }
              widget.onTinhChanged?.call(tinh);
              _validateSelection();
            },
            isLoading: state is TinhLoading,
            style: style.pickerStyle,
            prefixIcon: Icon(Icons.location_city_outlined),
          );
        } else if (state is TinhError) {
          return _buildErrorWidget(
              'Lỗi tải danh sách tỉnh: ${state.message}', theme);
        } else {
          return _buildLoadingPicker('Tỉnh/Thành phố', 'Đang tải...', theme);
        }
      },
    );
  }

  Widget _buildHuyenPicker(ThemeData theme, ColorStyles? colorStyles,
      ModernCascadeLocationPickerStyle style) {
    return BlocBuilder<HuyenBloc, HuyenState>(
      bloc: locator<HuyenBloc>(),
      builder: (context, state) {
        if (state is HuyenLoadedByTinh) {
          return ModernPicker<Huyen>(
            label: 'Quận/Huyện',
            hint: 'Chọn Quận/Huyện',
            items:
                state.huyens,
            initialValue: selectedHuyen?.id,
            onChanged: (item) {
              final huyen = item;
              setState(() {
                selectedHuyen = huyen;
                selectedXa = null;
                selectedKCN = null;
                _updateAddressDetail();
              });
              if (huyen != null) {
                locator<XaBloc>().add(LoadXasByHuyen(mahuyen: huyen.id));
              }
              widget.onHuyenChanged?.call(huyen);
              _validateSelection();
            },
            isLoading: state is HuyenLoading,
            enabled: selectedTinh != null,
            style: style.pickerStyle,
            prefixIcon: Icon(Icons.location_searching_outlined),
          );
        } else if (state is HuyenError) {
          return _buildErrorWidget(
              'Lỗi tải danh sách huyện: ${state.message}', theme);
        } else {
          return _buildLoadingPicker(
              'Quận/Huyện',
              selectedTinh == null ? 'Vui lòng chọn tỉnh trước' : 'Đang tải...',
              theme);
        }
      },
    );
  }

  Widget _buildXaPicker(ThemeData theme, ColorStyles? colorStyles,
      ModernCascadeLocationPickerStyle style) {
    return BlocBuilder<XaBloc, XaState>(
      bloc: locator<XaBloc>(),
      builder: (context, state) {
        if (state is XaLoadedByHuyen) {
          return ModernPicker<Xa>(
            label: 'Xã/Phường',
            hint: 'Chọn Xã/Phường',
            items: state.xas,
            initialValue: selectedXa?.id,
            onChanged: (item) {
              final xa = item;
              setState(() {
                selectedXa = xa;
                selectedKCN = null;
                _updateAddressDetail();
              });
              widget.onXaChanged?.call(xa);
              _validateSelection();
            },
            isLoading: state is XaLoading,
            enabled: selectedHuyen != null,
            style: style.pickerStyle,
            prefixIcon: Icon(Icons.home_outlined),
          );
        } else if (state is XaError) {
          return _buildErrorWidget(
              'Lỗi tải danh sách xã: ${state.message}', theme);
        } else {
          return _buildLoadingPicker(
              'Xã/Phường',
              selectedHuyen == null
                  ? 'Vui lòng chọn huyện trước'
                  : 'Đang tải...',
              theme);
        }
      },
    );
  }

  Widget _buildKCNPicker(ThemeData theme, ColorStyles? colorStyles,
      ModernCascadeLocationPickerStyle style) {
    return BlocBuilder<KcnCubit, KcnState>(
      bloc: _kcnCubit,
      builder: (context, state) {
        if (state is KcnLoaded) {
          return ModernPicker<KCNModel>(
            label: 'Khu công nghiệp',
            hint: 'Chọn KCN (tùy chọn)',
            items: state.kcnList,
            initialValue: selectedKCN?.id,
            onChanged: (kcn) {
              setState(() {
                selectedKCN = kcn;
              });
              widget.onKCNChanged?.call(kcn);
              _validateSelection();
            },
            isLoading: state is KcnLoading,
            enabled: selectedTinh != null,
            style: style.pickerStyle,
            prefixIcon: Icon(Icons.factory_outlined),
          );
        } else if (state is KcnError) {
          return _buildErrorWidget(
              'Lỗi tải danh sách KCN: ${state.message}', theme);
        } else {
          return _buildLoadingPicker(
              'Khu công nghiệp',
              selectedTinh == null ? 'Vui lòng chọn tỉnh trước' : 'Đang tải...',
              theme);
        }
      },
    );
  }

  Widget _buildAddressDetailField(ThemeData theme, ColorStyles? colorStyles,
      ModernCascadeLocationPickerStyle style) {
    return ModernTextField.textArea(
      label: 'Địa chỉ chi tiết',
      hint: 'Nhập số nhà, tên đường...',
      controller: widget.addressDetailController,
      minLines: 2,
      maxLines: 3,
      helperText: 'Địa chỉ sẽ được tự động cập nhật khi bạn chọn địa điểm',
    );
  }

  Widget _buildLoadingPicker(String label, String hint, ThemeData theme) {
    return ModernPicker<GenericPickerItem>(
      label: label,
      hint: hint,
      items: const [],
      initialValue: null,
      onChanged: (_) {},
      isLoading: true,
      enabled: false,
    );
  }

  Widget _buildErrorWidget(String message, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.error.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: theme.colorScheme.error, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _updateAddressDetail() {
    widget.addressDetailController.text = _buildAddressString(
        selectedXa?.displayName, 
        selectedHuyen?.displayName, 
        selectedTinh?.displayName);
  }

  String _buildAddressString(String? xa, String? huyen, String? tinh) {
    String address = "";
    if (xa != null && xa.isNotEmpty) address += xa;
    if (huyen != null && huyen.isNotEmpty) {
      if (address.isNotEmpty) address += ", ";
      address += huyen;
    }
    if (tinh != null && tinh.isNotEmpty) {
      if (address.isNotEmpty) address += ", ";
      address += tinh;
    }
    return address;
  }
}

/// Style configuration for ModernCascadeLocationPicker
class ModernCascadeLocationPickerStyle {
  final EdgeInsets containerPadding;
  final double borderRadius;
  final double spacing;
  final bool showShadow;
  final bool showHeader;
  final ModernPickerStyle? pickerStyle;

  const ModernCascadeLocationPickerStyle({
    this.containerPadding = const EdgeInsets.all(20),
    this.borderRadius = 16,
    this.spacing = 16,
    this.showShadow = true,
    this.showHeader = true,
    this.pickerStyle,
  });

  /// Default style that follows the project's design system
  factory ModernCascadeLocationPickerStyle.defaultStyle(BuildContext context) {
    return const ModernCascadeLocationPickerStyle();
  }

  /// Compact style for forms with many fields
  factory ModernCascadeLocationPickerStyle.compact() {
    return ModernCascadeLocationPickerStyle(
      containerPadding: const EdgeInsets.all(16),
      spacing: 12,
      showHeader: false,
      pickerStyle: ModernPickerStyle.compact(),
    );
  }

  /// Card style with prominent appearance
  factory ModernCascadeLocationPickerStyle.card() {
    return ModernCascadeLocationPickerStyle(
      containerPadding: const EdgeInsets.all(24),
      spacing: 20,
      showShadow: true,
      showHeader: true,
      pickerStyle: ModernPickerStyle.prominent(),
    );
  }

  ModernCascadeLocationPickerStyle copyWith({
    EdgeInsets? containerPadding,
    double? borderRadius,
    double? spacing,
    bool? showShadow,
    bool? showHeader,
    ModernPickerStyle? pickerStyle,
  }) {
    return ModernCascadeLocationPickerStyle(
      containerPadding: containerPadding ?? this.containerPadding,
      borderRadius: borderRadius ?? this.borderRadius,
      spacing: spacing ?? this.spacing,
      showShadow: showShadow ?? this.showShadow,
      showHeader: showHeader ?? this.showHeader,
      pickerStyle: pickerStyle ?? this.pickerStyle,
    );
  }
}

