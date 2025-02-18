import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:ttld/core/utils/extension_text.dart';
import 'package:ttld/core/utils/extenstions.dart';
import 'package:ttld/helppers/ny_color.dart';
import 'package:ttld/helppers/ny_text_style.dart';
import 'package:ttld/widgets/field/cast.dart';
import 'package:ttld/widgets/field/field.dart';
import 'package:ttld/widgets/field/field_base_state.dart';
import 'package:ttld/widgets/styles/bottom_modal_sheet.dart';

class NyFormPicker extends StatefulWidget {
  /// Creates a [NyFormPicker] widget
  NyFormPicker({
    super.key,
    required String name,
    required List<String> options,
    String? selectedValue,
    BottomModalSheetStyle? bottomModalSheetStyle,
    this.onChanged,
  }) : field = Field(name, value: selectedValue)
          ..cast = FormCast.picker(
              options: options, bottomModalSheetStyle: bottomModalSheetStyle);

  /// Creates a [NyFormPicker] widget from a [Field]
  const NyFormPicker.fromField(this.field, this.onChanged, {super.key});

  /// The field to be rendered
  final Field field;

  /// The callback function to be called when the value changes
  final Function(dynamic value)? onChanged;

  @override
  // ignore: no_logic_in_create_state
  createState() => _NyFormPickerState(field);
}

class _NyFormPickerState extends FieldBaseState<NyFormPicker> {
  dynamic currentValue;
  _NyFormPickerState(super.field);

  @override
  void initState() {
    super.initState();

    dynamic fieldValue = widget.field.value;
    if (fieldValue is String && fieldValue.isNotEmpty) {
      currentValue = fieldValue;
    }
  }

  @override
  Widget view(BuildContext context) {
    return LayoutBuilder(builder: (layoutContext, constraints) {
      double width = constraints.maxWidth;
      Widget container = InkWell(
          onTap: () => _selectValue(context),
          child: Container(
              height: 50,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color:
                    color(light: Colors.grey.shade100, dark: surfaceColorDark),
                borderRadius: BorderRadius.circular(8),
              ),
              child: currentValue != null
                  ? SizedBox(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          if (width < 200)
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Text(
                                currentValue.toString(),
                                textAlign: width < 200
                                    ? TextAlign.left
                                    : TextAlign.center,
                                style: TextStyle(
                                    color: color(
                                        light: Colors.black87,
                                        dark: Colors.white),
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          if (width > 200)
                            Positioned.fill(
                              child: Center(
                                child: Text(
                                  currentValue.toString(),
                                  textAlign: width < 200
                                      ? TextAlign.left
                                      : TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: color(
                                          light: Colors.black87,
                                          dark: Colors.white),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          Positioned(
                            left: 0,
                            top: 5,
                            child: Text(
                              widget.field.name.titleCase,
                              // widget.field.name.titleCase.tr(),
                              style: TextStyle(
                                  fontSize: 10,
                                  color: color(
                                      light: Colors.black54,
                                      dark: Colors.white),
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            "${"Select"} ${widget.field.name}",
                            // "${"Select".tr()} ${widget.field.name.tr()}",
                            textAlign:
                                width < 200 ? TextAlign.left : TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: color(
                                    light: Colors.black54, dark: Colors.white),
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: color(
                              light: Colors.grey.shade800, dark: Colors.white),
                        )
                      ],
                    ).withGap(10)));

      return container;
    });
  }

  /// Get the list of options from the field
  List<String> getOptions() {
    if (widget.field.cast.metaData == null) {
      return [];
    }
    return List<String>.from(widget.field.cast.metaData!["options"]);
  }

  // Get the color from the field meta
  Color? findColorFromMeta(String name, {Color? defaultColor}) {
    if (getFieldMeta<NyColor?>(name, null) != null) {
      NyColor nyColor = getFieldMeta<NyColor?>(name, null)!;
      return color(light: nyColor.light, dark: nyColor.dark);
    }
    return defaultColor;
  }

  // Get the color from the field meta
  TextStyle? findTextStyleFromMeta(String name,
      {NyTextStyle? defaultTextStyle}) {
    if (getFieldMeta<NyTextStyle?>(name, null) != null) {
      NyTextStyle textStyle = getFieldMeta<NyTextStyle?>(name, null)!;
      return textStyle.toTextStyle(context);
    }
    return defaultTextStyle?.toTextStyle(context);
  }

  /// Select a value from the list of options
  _selectValue(BuildContext context) {
    // get the list of values
    List<String> values = getOptions();

    // colors
    Color? backgroundColor = findColorFromMeta('bm_backgroundColor');
    Color? barrierColor =
        findColorFromMeta('bm_barrierColor', defaultColor: null);

    // text styles
    TextStyle? titleTextStyle = findTextStyleFromMeta('bm_titleTextStyle',
        defaultTextStyle: NyTextStyle(
            fontWeight: FontWeight.bold,
            color: NyColor(light: Colors.black, dark: Colors.white)));
    TextStyle? itemStyle = findTextStyleFromMeta('bm_itemStyle',
        defaultTextStyle: NyTextStyle(
            color: NyColor(light: Colors.black87, dark: Colors.white),
            fontWeight: FontWeight.bold,
            fontSize: 14));
    TextStyle? clearButtonStyle = findTextStyleFromMeta('bm_clearButtonStyle',
        defaultTextStyle: NyTextStyle(
            fontSize: 13, color: NyColor(light: Colors.red, dark: Colors.red)));

    // show modal bottom sheet
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
      useRootNavigator: getFieldMeta('bm_useRootNavigator', false),
      routeSettings: getFieldMeta('bm_routeSettings', null),
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: backgroundColor,
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.field.name,
                      // widget.field.name.tr(),
                      textAlign: TextAlign.center,
                      style: titleTextStyle,
                    ).paddingOnly(top: 10),
                    // Text(
                    //   // "Clear".tr(),
                    //   "Clear",
                    //   style: clearButtonStyle,
                    // ).onTap(() {
                    //   setState(() {
                    //     currentValue = null;
                    //   });
                    //   Navigator.pop(context);
                    // }),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          currentValue = null;
                        });
                      },
                      child: Text("Clear", style: clearButtonStyle),
                    )
                  ],
                ).paddingOnly(bottom: 15),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: ListTile.divideTiles(
                        context: context,
                        color: color(
                            light: Colors.grey.shade100, dark: Colors.black38),
                        tiles: values.map((item) {
                          return ListTile(
                            title: Text(
                              item,
                              style: itemStyle,
                            ),
                            onTap: () {
                              if (widget.onChanged != null) {
                                widget.onChanged!(item);
                              }
                              setState(() {
                                currentValue = item;
                              });
                              Navigator.pop(context);
                            },
                          );
                        })).toList(),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
