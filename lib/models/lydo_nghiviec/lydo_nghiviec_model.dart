import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

part 'lydo_nghiviec_model.freezed.dart';
part 'lydo_nghiviec_model.g.dart';

@freezed
class LydoNghiviec with _$LydoNghiviec implements GenericPickerItem {
  const LydoNghiviec._();

  const factory LydoNghiviec({
    int? id,
    String? ten,
    int? displayOrder,
    DateTime? createdDate,
    String? createdBy,
    DateTime? modifiredDate,
    String? modifiredBy,
    bool? status,
  }) = _LydoNghiviec;

  factory LydoNghiviec.fromJson(Map<String, dynamic> json) =>
      _$LydoNghiviecFromJson(json);

  @override
  String get displayName => ten ?? '';
}
