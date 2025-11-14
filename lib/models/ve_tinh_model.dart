import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ttld/widgets/reuseable_widgets/generic_picker_grok.dart';

part 've_tinh_model.freezed.dart';
part 've_tinh_model.g.dart';

@freezed
class VeTinh with _$VeTinh implements GenericPickerItem {
  const VeTinh._();

  const factory VeTinh({
    String? id,
    String? name,
    String? code,
    int? displayOrder,
    bool? status,
    String? parentId,
    String? address,
    String? phoneNumber,
    String? email,
  }) = _VeTinh;

  factory VeTinh.fromJson(Map<String, dynamic> json) =>
      _$VeTinhFromJson(json);

  @override
  String get displayName => name ?? '';
}
