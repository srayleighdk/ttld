import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:ttld/helppers/form_validation.dart';
import 'package:ttld/widgets/custom_text_field.dart';
import 'package:ttld/widgets/field/cast.dart';
import 'package:ttld/widgets/styles/bottom_modal_sheet.dart';
import 'package:intl/intl.dart' as intl;

typedef FormStyleTextField
    = Map<String, CustomTextField Function(CustomTextField)>;

typedef FormStyleCheckbox = Map<String, FormCast Function()>;

/// FormStyleSwitchBox is a typedef that helps in managing form style switch boxes
typedef FormStyleSwitchBox = Map<String, FormCast Function()>;

class NyFormStyle {
  /// FormStyleTextField styles for the form
  FormStyleTextField textField(BuildContext context, Field field) => {};

  /// FormStyleCheckbox styles for the form
  FormStyleCheckbox checkbox(BuildContext context, Field field) => {};

  /// FormStyleSwitchBox styles for the form
  FormStyleSwitchBox switchBox(BuildContext context, Field field) => {};
}

class Field {
  Field(
    this.key, {
    this.value,
    FormCast? cast,
    this.validate,
    this.autofocus = false,
    this.dummyData,
    this.header,
    this.footer,
    this.titleStyle,
    this.style,
    this.metaData = const {},
    this.hidden = false,
    this.readOnly,
  }) : cast = cast ?? FormCast() {
    if (style == null) return;

    metaData = {};
    if (style is String) {
      style = style;
      return;
    }
    if (style is Map) {
      style as Map<String, dynamic>;
      metaData!["decoration_style"] =
          (style as Map<String, dynamic>).entries.first.value;
      style = (style as Map<String, dynamic>).entries.first.key;
    }
  }

  /// Field.text is a constructor that helps in managing text fields
  Field.text(
    this.key, {
    this.value,
    this.validate,
    this.autofocus = false,
    this.dummyData,
    this.header,
    this.footer,
    this.titleStyle,
    this.style,
    this.metaData = const {},
    this.hidden = false,
    this.readOnly,
    Widget? prefixIcon,
    bool clearable = false,
    Widget? clearIcon,
  }) : cast = FormCast.text(
          prefixIcon: prefixIcon,
          clearable: clearable,
          clearIcon: clearIcon,
        ) {
    if (style == null) return;

    metaData = {};
    if (style is String) {
      style = style;
      return;
    }
    if (style is Map) {
      style as Map<String, dynamic>;
      metaData!["decoration_style"] =
          (style as Map<String, dynamic>).entries.first.value;
      style = (style as Map<String, dynamic>).entries.first.key;
    }
  }

  /// Field.currency is a constructor that helps in managing currency fields
  Field.currency(
    this.key, {
    required String currency,
    this.value,
    this.validate,
    this.autofocus = false,
    this.dummyData,
    this.header,
    this.footer,
    this.titleStyle,
    this.style,
    this.metaData = const {},
    this.hidden = false,
    this.readOnly,
  }) : cast = FormCast.currency(currency.toLowerCase()) {
    if (style == null) return;

    metaData = {};
    if (style is String) {
      style = style;
      return;
    }
    if (style is Map) {
      style as Map<String, dynamic>;
      metaData!["decoration_style"] =
          (style as Map<String, dynamic>).entries.first.value;
      style = (style as Map<String, dynamic>).entries.first.key;
    }
  }

  /// Field.password is a constructor that helps in managing password fields
  Field.password(
    this.key, {
    this.value,
    this.validate,
    this.autofocus = false,
    this.dummyData,
    this.header,
    this.footer,
    this.titleStyle,
    this.style,
    this.metaData = const {},
    this.hidden = false,
    bool viewable = false,
    this.readOnly,
  }) : cast = FormCast.password(viewable: viewable) {
    if (style == null) return;

    metaData = {};
    if (style is String) {
      style = style;
      return;
    }
    if (style is Map) {
      style as Map<String, dynamic>;
      metaData!["decoration_style"] =
          (style as Map<String, dynamic>).entries.first.value;
      style = (style as Map<String, dynamic>).entries.first.key;
    }
  }

  /// Field.email is a constructor that helps in managing password fields
  Field.email(
    this.key, {
    this.value,
    this.validate,
    this.autofocus = false,
    this.dummyData,
    this.header,
    this.footer,
    this.titleStyle,
    this.style,
    this.metaData = const {},
    this.hidden = false,
    this.readOnly,
    Widget? prefixIcon,
    bool clearable = false,
    Widget? clearIcon,
  }) : cast = FormCast.email(
          prefixIcon: prefixIcon,
          clearable: clearable,
          clearIcon: clearIcon,
        ) {
    if (style == null) return;

    metaData = {};
    if (style is String) {
      style = style;
      return;
    }
    if (style is Map) {
      style as Map<String, dynamic>;
      metaData!["decoration_style"] =
          (style as Map<String, dynamic>).entries.first.value;
      style = (style as Map<String, dynamic>).entries.first.key;
    }
  }

  /// Field.capitalizeWords is a constructor that helps in managing capitalizeWords fields
  Field.capitalizeWords(
    this.key, {
    this.value,
    this.validate,
    this.autofocus = false,
    this.dummyData,
    this.header,
    this.footer,
    this.titleStyle,
    this.style,
    this.metaData = const {},
    this.hidden = false,
    this.readOnly,
    Widget? prefixIcon,
    bool clearable = false,
    Widget? clearIcon,
  }) : cast = FormCast.capitalizeWords(
          prefixIcon: prefixIcon,
          clearable: clearable,
          clearIcon: clearIcon,
        ) {
    if (style == null) return;

    metaData = {};
    if (style is String) {
      style = style;
      return;
    }
    if (style is Map) {
      style as Map<String, dynamic>;
      metaData!["decoration_style"] =
          (style as Map<String, dynamic>).entries.first.value;
      style = (style as Map<String, dynamic>).entries.first.key;
    }
  }

  /// Field.capitalizeSentences is a constructor that helps in managing capitalizeSentences fields
  Field.capitalizeSentences(
    this.key, {
    this.value,
    this.validate,
    this.autofocus = false,
    this.dummyData,
    this.header,
    this.footer,
    this.titleStyle,
    this.style,
    this.metaData = const {},
    this.hidden = false,
    this.readOnly,
    Widget? prefixIcon,
    bool clearable = false,
    Widget? clearIcon,
  }) : cast = FormCast.capitalizeSentences(
          prefixIcon: prefixIcon,
          clearable: clearable,
          clearIcon: clearIcon,
        ) {
    if (style == null) return;

    metaData = {};
    if (style is String) {
      style = style;
      return;
    }
    if (style is Map) {
      style as Map<String, dynamic>;
      metaData!["decoration_style"] =
          (style as Map<String, dynamic>).entries.first.value;
      style = (style as Map<String, dynamic>).entries.first.key;
    }
  }

  /// Field.picker is a constructor that helps in managing picker fields
  Field.picker(
    this.key, {
    this.value,
    this.validate,
    this.autofocus = false,
    this.dummyData,
    this.header,
    this.footer,
    this.titleStyle,
    this.style,
    this.metaData = const {},
    this.hidden = false,
    this.readOnly,
    required List<String> options,
    BottomModalSheetStyle? bottomModalSheetStyle,
  }) : cast = FormCast.picker(
            options: options, bottomModalSheetStyle: bottomModalSheetStyle) {
    if (style == null) return;

    metaData = {};
    if (style is String) {
      style = style;
      return;
    }
    if (style is Map) {
      style as Map<String, dynamic>;
      metaData!["decoration_style"] =
          (style as Map<String, dynamic>).entries.first.value;
      style = (style as Map<String, dynamic>).entries.first.key;
    }
  }

  /// Field.number is a constructor that helps in managing number fields
  Field.number(
    this.key, {
    this.value,
    this.validate,
    this.autofocus = false,
    this.dummyData,
    this.header,
    this.footer,
    this.titleStyle,
    this.style,
    this.metaData = const {},
    this.hidden = false,
    this.readOnly,
    bool decimal = false,
  }) : cast = FormCast.number(decimal: decimal) {
    if (style == null) return;

    metaData = {};
    if (style is String) {
      style = style;
      return;
    }
    if (style is Map) {
      style as Map<String, dynamic>;
      metaData!["decoration_style"] =
          (style as Map<String, dynamic>).entries.first.value;
      style = (style as Map<String, dynamic>).entries.first.key;
    }
  }

  /// Field.mask is a constructor that helps in managing mask fields
  Field.mask(
    this.key, {
    this.value,
    this.validate,
    this.autofocus = false,
    this.dummyData,
    this.header,
    this.footer,
    this.titleStyle,
    this.style,
    this.metaData = const {},
    this.hidden = false,
    this.readOnly,
    Widget? prefixIcon,
    bool clearable = false,
    Widget? clearIcon,
    required String? mask,
    String? match = r'[\w\d]',
    bool? maskReturnValue = false,
  }) : cast = FormCast.mask(
          prefixIcon: prefixIcon,
          clearable: clearable,
          clearIcon: clearIcon,
          mask: mask,
        ) {
    if (style == null) return;

    metaData = {};
    if (style is String) {
      style = style;
      return;
    }
    if (style is Map) {
      style as Map<String, dynamic>;
      metaData!["decoration_style"] =
          (style as Map<String, dynamic>).entries.first.value;
      style = (style as Map<String, dynamic>).entries.first.key;
    }
  }

  /// Field.url is a constructor that helps in managing url fields
  Field.url(
    this.key, {
    this.value,
    this.validate,
    this.autofocus = false,
    this.dummyData,
    this.header,
    this.footer,
    this.titleStyle,
    this.style,
    this.metaData = const {},
    this.hidden = false,
    this.readOnly,
    Widget? prefixIcon,
    bool clearable = false,
    Widget? clearIcon,
  }) : cast = FormCast.url(
          prefixIcon: prefixIcon,
          clearable: clearable,
          clearIcon: clearIcon,
        ) {
    if (style == null) return;

    metaData = {};
    if (style is String) {
      style = style;
      return;
    }
    if (style is Map) {
      style as Map<String, dynamic>;
      metaData!["decoration_style"] =
          (style as Map<String, dynamic>).entries.first.value;
      style = (style as Map<String, dynamic>).entries.first.key;
    }
  }

  /// Field.textArea is a constructor that helps in managing textArea fields
  Field.textArea(this.key,
      {this.value,
      this.validate,
      this.autofocus = false,
      this.dummyData,
      this.header,
      this.footer,
      this.titleStyle,
      this.style,
      this.metaData = const {},
      this.hidden = false,
      this.readOnly,
      TextAreaSize textAreaSize = TextAreaSize.sm})
      : cast = FormCast.textArea(textAreaSize: textAreaSize) {
    if (style == null) return;

    metaData = {};
    if (style is String) {
      style = style;
      return;
    }
    if (style is Map) {
      style as Map<String, dynamic>;
      metaData!["decoration_style"] =
          (style as Map<String, dynamic>).entries.first.value;
      style = (style as Map<String, dynamic>).entries.first.key;
    }
  }

  /// Field.phoneNumber is a constructor that helps in managing phoneNumber fields
  Field.phoneNumber(
    this.key, {
    this.value,
    this.validate,
    this.autofocus = false,
    this.dummyData,
    this.header,
    this.footer,
    this.titleStyle,
    this.style,
    this.metaData = const {},
    this.hidden = false,
    this.readOnly,
    Widget? prefixIcon,
    bool clearable = false,
    Widget? clearIcon,
  }) : cast = FormCast.phoneNumber(
          prefixIcon: prefixIcon,
          clearable: clearable,
          clearIcon: clearIcon,
        ) {
    if (style == null) return;

    metaData = {};
    if (style is String) {
      style = style;
      return;
    }
    if (style is Map) {
      style as Map<String, dynamic>;
      metaData!["decoration_style"] =
          (style as Map<String, dynamic>).entries.first.value;
      style = (style as Map<String, dynamic>).entries.first.key;
    }
  }

  /// Field.checkbox is a constructor that helps in managing textArea fields
  Field.checkbox(
    this.key, {
    this.value,
    this.validate,
    this.autofocus = false,
    this.dummyData,
    this.header,
    this.footer,
    this.titleStyle,
    this.style,
    this.metaData = const {},
    this.hidden = false,
    this.readOnly,
    MouseCursor? mouseCursor,
    Color? activeColor,
    Color? fillColor,
    Color? checkColor,
    Color? hoverColor,
    Color? overlayColor,
    double? splashRadius,
    MaterialTapTargetSize? materialTapTargetSize,
    VisualDensity? visualDensity,
    FocusNode? focusNode,
    ShapeBorder? shape,
    BorderSide? side,
    bool isError = false,
    bool? enabled,
    Color? tileColor,
    Widget? title,
    Widget? subtitle,
    bool isThreeLine = false,
    bool? dense,
    Widget? secondary,
    bool selected = false,
    ListTileControlAffinity controlAffinity = ListTileControlAffinity.platform,
    EdgeInsetsGeometry? contentPadding,
    bool tristate = false,
    ShapeBorder? checkboxShape,
    Color? selectedTileColor,
    ValueChanged<bool?>? onFocusChange,
    bool? enableFeedback,
    String? checkboxSemanticLabel,
  }) : cast = FormCast.checkbox(
            mouseCursor: mouseCursor,
            activeColor: activeColor,
            fillColor: fillColor,
            checkColor: checkColor,
            hoverColor: hoverColor,
            overlayColor: overlayColor,
            splashRadius: splashRadius,
            materialTapTargetSize: materialTapTargetSize,
            visualDensity: visualDensity,
            focusNode: focusNode,
            autofocus: autofocus,
            shape: shape,
            side: side,
            isError: isError,
            enabled: enabled,
            tileColor: tileColor,
            title: title,
            subtitle: subtitle,
            isThreeLine: isThreeLine,
            dense: dense,
            secondary: secondary,
            selected: selected,
            controlAffinity: controlAffinity,
            contentPadding: contentPadding,
            tristate: tristate,
            checkboxShape: checkboxShape,
            selectedTileColor: selectedTileColor,
            onFocusChange: onFocusChange,
            enableFeedback: enableFeedback,
            checkboxSemanticLabel: checkboxSemanticLabel) {
    if (style == null) return;

    metaData = {};
    if (style is String) {
      style = style;
      return;
    }
    if (style is Map) {
      style as Map<String, dynamic>;
      metaData!["decoration_style"] =
          (style as Map<String, dynamic>).entries.first.value;
      style = (style as Map<String, dynamic>).entries.first.key;
    }
  }

  /// Field.switchBox is a constructor that helps in managing switch fields
  Field.switchBox(
    this.key, {
    this.value,
    this.validate,
    this.autofocus = false,
    this.dummyData,
    this.header,
    this.footer,
    this.titleStyle,
    this.style,
    this.metaData = const {},
    this.hidden = false,
    this.readOnly,
    MouseCursor? mouseCursor,
    Color? activeColor,
    Color? fillColor,
    Color? checkColor,
    Color? hoverColor,
    Color? overlayColor,
    double? splashRadius,
    MaterialTapTargetSize? materialTapTargetSize,
    VisualDensity? visualDensity,
    FocusNode? focusNode,
    ShapeBorder? shape,
    BorderSide? side,
    bool isError = false,
    bool? enabled,
    Color? tileColor,
    Widget? title,
    Widget? subtitle,
    bool isThreeLine = false,
    bool? dense,
    Widget? secondary,
    bool selected = false,
    ListTileControlAffinity controlAffinity = ListTileControlAffinity.platform,
    EdgeInsetsGeometry? contentPadding,
    bool tristate = false,
    ShapeBorder? checkboxShape,
    Color? selectedTileColor,
    ValueChanged<bool?>? onFocusChange,
    bool? enableFeedback,
    String? checkboxSemanticLabel,
  }) : cast = FormCast.switchBox(
            mouseCursor: mouseCursor,
            activeColor: activeColor,
            fillColor: fillColor,
            checkColor: checkColor,
            hoverColor: hoverColor,
            overlayColor: overlayColor,
            splashRadius: splashRadius,
            materialTapTargetSize: materialTapTargetSize,
            visualDensity: visualDensity,
            focusNode: focusNode,
            autofocus: autofocus,
            shape: shape,
            side: side,
            isError: isError,
            enabled: enabled,
            tileColor: tileColor,
            title: title,
            subtitle: subtitle,
            isThreeLine: isThreeLine,
            dense: dense,
            secondary: secondary,
            selected: selected,
            controlAffinity: controlAffinity,
            contentPadding: contentPadding,
            tristate: tristate,
            checkboxShape: checkboxShape,
            selectedTileColor: selectedTileColor,
            onFocusChange: onFocusChange,
            enableFeedback: enableFeedback,
            checkboxSemanticLabel: checkboxSemanticLabel) {
    if (style == null) return;

    metaData = {};
    if (style is String) {
      style = style;
      return;
    }
    if (style is Map) {
      style as Map<String, dynamic>;
      metaData!["decoration_style"] =
          (style as Map<String, dynamic>).entries.first.value;
      style = (style as Map<String, dynamic>).entries.first.key;
    }
  }

  /// Field.datetime is a constructor that helps in managing datetime fields
  Field.datetime(
    this.key, {
    this.value,
    this.validate,
    this.autofocus = false,
    this.dummyData,
    this.header,
    this.footer,
    this.titleStyle,
    this.style,
    this.metaData = const {},
    this.hidden = false,
    this.readOnly,
    TextStyle? dateTextStyle,
    VoidCallback? onTap,
    FocusNode? focusNode,
    bool? enableFeedback,
    EdgeInsetsGeometry? padding,
    bool hideDefaultSuffixIcon = false,
    DateTime? initialPickerDateTime,
    CupertinoDatePickerOptions? cupertinoDatePickerOptions,
    MaterialDatePickerOptions? materialDatePickerOptions,
    MaterialTimePickerOptions? materialTimePickerOptions,
    InputDecoration? decoration,
    intl.DateFormat? dateFormat,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTimeFieldPickerMode mode = DateTimeFieldPickerMode.dateAndTime,
    DateTimeFieldPickerPlatform pickerPlatform =
        DateTimeFieldPickerPlatform.adaptive,
  }) : cast = FormCast.datetime(
            style: dateTextStyle,
            onTap: onTap,
            focusNode: focusNode,
            autofocus: autofocus,
            enableFeedback: enableFeedback,
            padding: padding,
            hideDefaultSuffixIcon: hideDefaultSuffixIcon,
            initialPickerDateTime: initialPickerDateTime,
            cupertinoDatePickerOptions: cupertinoDatePickerOptions,
            materialDatePickerOptions: materialDatePickerOptions,
            materialTimePickerOptions: materialTimePickerOptions,
            decoration: decoration,
            dateFormat: dateFormat,
            firstDate: firstDate,
            lastDate: lastDate,
            mode: mode,
            pickerPlatform: pickerPlatform) {
    if (style == null) return;

    metaData = {};
    if (style is String) {
      style = style;
      return;
    }
    if (style is Map) {
      style as Map<String, dynamic>;
      metaData!["decoration_style"] =
          (style as Map<String, dynamic>).entries.first.value;
      style = (style as Map<String, dynamic>).entries.first.key;
    }
  }

  /// Field.date is a constructor that helps in managing date fields
  Field.date(
    this.key, {
    this.value,
    this.validate,
    this.autofocus = false,
    this.dummyData,
    this.header,
    this.footer,
    this.titleStyle,
    this.style,
    this.metaData = const {},
    this.hidden = false,
    this.readOnly,
    TextStyle? dateTextStyle,
    VoidCallback? onTap,
    FocusNode? focusNode,
    bool? enableFeedback,
    EdgeInsetsGeometry? padding,
    bool hideDefaultSuffixIcon = false,
    DateTime? initialPickerDateTime,
    CupertinoDatePickerOptions? cupertinoDatePickerOptions,
    MaterialDatePickerOptions? materialDatePickerOptions,
    MaterialTimePickerOptions? materialTimePickerOptions,
    InputDecoration? decoration,
    intl.DateFormat? dateFormat,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTimeFieldPickerMode mode = DateTimeFieldPickerMode.dateAndTime,
    DateTimeFieldPickerPlatform pickerPlatform =
        DateTimeFieldPickerPlatform.adaptive,
  }) : cast = FormCast.date(
            style: dateTextStyle,
            onTap: onTap,
            focusNode: focusNode,
            autofocus: autofocus,
            enableFeedback: enableFeedback,
            padding: padding,
            hideDefaultSuffixIcon: hideDefaultSuffixIcon,
            initialPickerDateTime: initialPickerDateTime,
            cupertinoDatePickerOptions: cupertinoDatePickerOptions,
            materialDatePickerOptions: materialDatePickerOptions,
            materialTimePickerOptions: materialTimePickerOptions,
            decoration: decoration,
            dateFormat: dateFormat,
            firstDate: firstDate,
            lastDate: lastDate,
            mode: mode,
            pickerPlatform: pickerPlatform) {
    if (style == null) return;

    metaData = {};
    if (style is String) {
      style = style;
      return;
    }
    if (style is Map) {
      style as Map<String, dynamic>;
      metaData!["decoration_style"] =
          (style as Map<String, dynamic>).entries.first.value;
      style = (style as Map<String, dynamic>).entries.first.key;
    }
  }

  /// Field.chips is a constructor that helps in managing chips fields
  Field.chips(
    this.key, {
    this.value,
    this.validate,
    this.autofocus = false,
    this.dummyData,
    this.header,
    this.footer,
    this.titleStyle,
    this.style,
    this.metaData = const {},
    this.hidden = false,
    this.readOnly,
    required List<dynamic> options,
    Color? backgroundColor,
    Color? selectedColor,
    double headerSpacing = 5,
    double footerSpacing = 5,
    OutlinedBorder shape = const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8))),
    BorderSide unselectedSide = const BorderSide(color: Colors.grey, width: 1),
    BorderSide selectedSide = const BorderSide(color: Colors.grey, width: 1),
    TextStyle labelStyle =
        const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    TextStyle unselectedTextStyle =
        const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    TextStyle selectedTextStyle =
        const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    EdgeInsets padding = const EdgeInsets.all(8.0),
    double runSpacing = 8.0,
    double spacing = 8.0,
    Color checkmarkColor = Colors.white,
  }) : cast = FormCast.chips(
            options: options,
            backgroundColor: backgroundColor,
            selectedColor: selectedColor,
            headerSpacing: headerSpacing,
            footerSpacing: footerSpacing,
            shape: shape,
            unselectedSide: unselectedSide,
            selectedSide: selectedSide,
            labelStyle: labelStyle,
            unselectedTextStyle: unselectedTextStyle,
            selectedTextStyle: selectedTextStyle,
            padding: padding,
            runSpacing: runSpacing,
            spacing: spacing,
            checkmarkColor: checkmarkColor) {
    if (style == null) return;

    metaData = {};
    if (style is String) {
      style = style;
      return;
    }
    if (style is Map) {
      style as Map<String, dynamic>;
      metaData!["decoration_style"] =
          (style as Map<String, dynamic>).entries.first.value;
      style = (style as Map<String, dynamic>).entries.first.key;
    }
  }

  /// The key of the field
  String key;

  /// The value of the field
  dynamic value;

  /// The cast for the field
  FormCast cast;

  /// The validator for the field
  FormValidator? validate;

  /// The autofocus for the field
  bool autofocus;

  /// The dummy data for the field
  String? dummyData;

  /// The style for the field
  dynamic style;

  /// Get the name of the field
  String get name => key;

  /// Get the header of the field
  Widget? header;

  /// Get the footer of the field
  Widget? footer;

  /// Get the title style of the field
  TextStyle? titleStyle;

  /// Get the metadata of the field
  Map<String, CustomTextField Function(CustomTextField nyTextField)>? metaData;

  /// Hidden field
  bool? hidden = false;

  /// Readonly field
  bool? readOnly;

  /// Hide the field
  hide() {
    hidden = true;
  }

  /// Show the field
  show() {
    hidden = false;
  }

  /// Convert the [Field] to a Map
  Map<String, dynamic> toJson() {
    return {
      "key": key,
      "value": value,
    };
  }
}
