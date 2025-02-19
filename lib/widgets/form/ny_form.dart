import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:ttld/core/utils/extenstions.dart';
import 'package:ttld/core/utils/toast_enums.dart';
import 'package:ttld/helppers/form_validation.dart';
import 'package:ttld/helppers/help.dart';
import 'package:ttld/helppers/loading_styles.dart';
import 'package:ttld/helppers/ny_logger.dart';
import 'package:ttld/helppers/validator/rules.dart';
import 'package:ttld/helppers/validator/validate_exceptions.dart';
import 'package:ttld/helppers/validator/validator.dart';
import 'package:ttld/widgets/custom_text_field.dart';
import 'package:ttld/widgets/field/cast.dart';
import 'package:ttld/widgets/field/field.dart';
import 'package:ttld/widgets/field/form_style.dart';
import 'package:ttld/widgets/form/ny_form_data.dart';
import 'package:ttld/widgets/form/ny_form_item.dart';
import 'package:ttld/widgets/ny_future_builder.dart';

class NyForm extends StatefulWidget {
  final NyFormData form;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final bool validateOnFocusChange;
  final Function(String field, Map<String, dynamic> data)? onChanged;

  /// The type of form
  final String type;

  /// The header widget
  final Widget? header;

  /// The footer widget
  final Widget? footer;

  /// The header spacing
  final double headerSpacing;

  /// The footer spacing
  final double footerSpacing;

  /// The loading widget, defaults to skeleton
  final Widget? loading;
  final bool locked;

  /// The loading style
  final LoadingStyle loadingStyle;

  /// The child widgets
  final List<Widget>? children;

  NyForm(
      {super.key,
      required NyFormData form,
      this.crossAxisSpacing = 10,
      this.mainAxisSpacing = 10,
      Map<String, dynamic>? initialData,
      this.onChanged,
      this.validateOnFocusChange = false,
      this.header,
      this.footer,
      this.headerSpacing = 10,
      this.footerSpacing = 10,
      @Deprecated('Use loadingStyle instead') this.loading,
      LoadingStyle? loadingStyle,
      this.locked = false})
      : form = form..setData(initialData ?? {}, refreshState: false),
        type = "form",
        loadingStyle = loadingStyle ?? LoadingStyle.skeletonizer(),
        children = null;

  /// Create a form with children
  /// Example:
  /// ```dart
  /// NyForm(
  /// form: form,
  /// children: [
  ///  Button.primary("Submit", onPressed: () {}),
  /// ],
  /// );
  /// ```
  NyForm.list(
      {super.key,
      required NyFormData form,
      required this.children,
      this.crossAxisSpacing = 10,
      this.mainAxisSpacing = 10,
      Map<String, dynamic>? initialData,
      this.onChanged,
      this.validateOnFocusChange = false,
      this.header,
      this.footer,
      this.headerSpacing = 10,
      this.footerSpacing = 10,
      @Deprecated('Use loadingStyle instead') this.loading,
      LoadingStyle? loadingStyle,
      this.locked = false})
      : form = form..setData(initialData ?? {}, refreshState: false),
        loadingStyle = loadingStyle ?? LoadingStyle.skeletonizer(),
        type = "list";

  /// Get the state name
  static state(String stateName) {
    return "form_$stateName";
  }

  // Refresh the state of the form
  // static stateRefresh(String stateName) {
  //   updateState(state(stateName), data: {
  //     "action": "refresh",
  //   });
  // }
  //
  // /// Set field in the form
  // static stateSetValue(String stateName, String key, dynamic value) {
  //   updateState(state(stateName),
  //       data: {"action": "setValue", "key": key, "value": value});
  // }
  //
  // /// Set field in the form
  // static stateSetOptions(String stateName, String key, dynamic value) {
  //   updateState(state(stateName),
  //       data: {"action": "setOptions", "key": key, "value": value});
  // }
  //
  // /// Refresh the state of the form
  // static stateClearData(String stateName) {
  //   updateState(state(stateName), data: {
  //     "action": "clear",
  //   });
  // }
  //
  // /// Refresh the state of the form
  // static stateRefreshForm(String stateName) {
  //   updateState(state(stateName), data: {
  //     "action": "refresh-form",
  //   });
  // }

  /// Submit the form
  static submit(String name,
      {required Function(dynamic value) onSuccess,
      Function(Exception exception)? onFailure,
      bool showToastError = true}) {
    /// Update the state
    // updateState(state(name), data: {
    //   "onSuccess": onSuccess,
    //   "onFailure": onFailure,
    //   "showToastError": showToastError
    // });
  }

  @override
  // ignore: no_logic_in_create_state
  State<NyForm> createState() => _NyFormState(form);
}

class _NyFormState extends State<NyForm> {
  List<NyFormItem> _children = [];
  dynamic initialFormData;

  /// The [stateName] is used as the ID for the [UpdateState] class.
  String? stateName;
  Map<String, bool> _loadingMap = {};
  Map<String, bool> _lockMap = {};

  LoadingStyle get loadingStyle => LoadingStyle.normal();
  bool get shouldLoadView => (init is Future Function());
  bool overrideLoading = false;
  bool hasInitComplete = false;

  _NyFormState(NyFormData form) {
    stateName = "form_${form.stateName}";
  }

  bool isLoading({String name = 'default'}) {
    if (_loadingMap.containsKey(name) == false) {
      _loadingMap[name] = false;
    }
    return _loadingMap[name]!;
  }

  _setLock(String name, {required bool value}) {
    _lockMap[name] = value;
  }

  _updateLockState(
      {required bool shouldSetState,
      required String name,
      required bool value}) {
    if (shouldSetState == true) {
      setState(() {
        _setLock(name, value: value);
      });
    } else {
      _setLock(name, value: value);
    }
  }

  lockRelease(String name,
      {required Function perform, bool shouldSetState = true}) async {
    if (isLocked(name) == true) {
      return;
    }
    _updateLockState(shouldSetState: shouldSetState, name: name, value: true);

    try {
      await perform();
    } on Exception catch (e) {
      NyLogger.error(e.toString());
    }

    _updateLockState(shouldSetState: shouldSetState, name: name, value: false);
  }

  bool isLocked(String name) {
    if (_lockMap.containsKey(name) == false) {
      _lockMap[name] = false;
    }
    return _lockMap[name]!;
  }

  validate(
      {required Map<String, dynamic> rules,
      Map<String, dynamic>? data,
      Map<String, dynamic>? messages,
      bool showAlert = true,
      Duration? alertDuration,
      ToastNotificationStyleType alertStyle =
          ToastNotificationStyleType.warning,
      required Function()? onSuccess,
      Function(Exception exception)? onFailure,
      String? lockRelease}) {
    if (!mounted) return;

    Map<String, String> finalRules = {};
    Map<String, dynamic> finalData = {};
    Map<String, dynamic> finalMessages = messages ?? {};

    bool completed = false;
    for (MapEntry rule in rules.entries) {
      String key = rule.key;
      dynamic value = rule.value;

      if (value is FormValidator) {
        FormValidator formValidator = value;

        if (formValidator.customRule != null) {
          bool passed = formValidator.customRule!(formValidator.data);
          if (!passed) {
            ValidationRule customRule = ValidationRule(
              signature: "FormValidator.custom",
              textFieldMessage: formValidator.message,
              title: formValidator.message ?? "Invalid data",
            );
            ValidationException exception =
                ValidationException(key, customRule);
            NyLogger.error(exception.toString());
            if (onFailure == null) return;
            onFailure(exception);
            completed = true;
            break;
          }
        }

        if (formValidator.rules == null) continue;
        finalRules[key] = formValidator.rules;
        finalData[key] = formValidator.data;
        if (formValidator.message != null) {
          finalMessages[key] = formValidator.message;
        }
        continue;
      }

      if (value is List) {
        assert(value.length < 4,
            'Validation rules can contain a maximum of 3 items. E.g. "email": [emailData, "add|validation|rules", "my message"]');
        finalRules[key] = value[1];
        finalData[key] = value[0];
        if (value.length == 3) {
          finalMessages[key] = value[2];
        }
      } else {
        if (value != null) {
          finalRules[key] = value;
        }
      }
    }

    if (completed) return;

    if (data != null) {
      data.forEach((key, value) {
        finalData.addAll({key: value});
      });
    }

    if (lockRelease != null) {
      this.lockRelease(lockRelease, perform: () async {
        try {
          NyValidator.check(
            rules: finalRules,
            data: finalData,
            messages: finalMessages,
            context: context,
            showAlert: showAlert,
            alertDuration: alertDuration,
            alertStyle: alertStyle,
          );

          if (onSuccess == null) return;
          await onSuccess();
        } on Exception catch (exception) {
          if (onFailure == null) return;
          onFailure(exception);
        }
      });
      return;
    }
    try {
      NyValidator.check(
        rules: finalRules,
        data: finalData,
        messages: finalMessages,
        context: context,
        showAlert: showAlert,
        alertDuration: alertDuration,
        alertStyle: alertStyle,
      );

      if (onSuccess == null) return;
      onSuccess();
    } on Exception catch (exception) {
      NyLogger.error(exception.toString());
      if (onFailure == null) return;
      onFailure(exception);
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.form.updated?.close();
  }

  bool runOnce = true;

  @override
  get init => () {
        widget.form.updated?.stream.listen((data) {
          String fieldSnakeCase = ReCase(data.$1).snakeCase;
          dynamic formData = widget.form.data(lowerCaseKeys: true);
          widget.form.onChange(fieldSnakeCase, formData);
          if (widget.onChanged != null) {
            setState(() {
              widget.onChanged!(fieldSnakeCase, formData);
            });
          }
        });

        _construct();
      };

  List<String> showableFields = [];

  /// Construct the form
  _construct() {
    NyFormStyle? nyFormStyle = FormStyle();

    Map<String, dynamic> fields = widget.form.data();

    _children = fields.entries.map((field) {
      dynamic value = field.value;

      bool autofocus = widget.form.getAutoFocusedField == field.key;

      String? fieldStyle;
      FormCast? fieldCast;

      // check what to cast the field to
      Map<String, dynamic> casts = widget.form.getCast;

      if (casts.containsKey(field.key)) {
        fieldCast = casts[field.key];
      }

      // check if there is a style for the field
      CustomTextField Function(CustomTextField nyTextField)? style;
      Map<String, dynamic> styles = widget.form.getStyle;
      if (styles.containsKey(field.key)) {
        dynamic styleItem = styles[field.key];
        if (styleItem is CustomTextField Function(
            CustomTextField nyTextField)) {
          style = styleItem;
        }

        if (styleItem is String) {
          fieldStyle = styleItem;
        }
      }

      if (fieldCast == null) {
        if (value is DateTime ||
            field.value.runtimeType.toString() == "DateTime") {
          fieldCast = FormCast.datetime();
        }

        if (value is String || field.value.runtimeType.toString() == "String") {
          fieldCast = FormCast();
        }

        if (value is int || field.value.runtimeType.toString() == "int") {
          fieldCast = FormCast.number();
        }

        if (value is double || field.value.runtimeType.toString() == "double") {
          fieldCast = FormCast.number(decimal: true);
        }
      }

      fieldCast ??= FormCast();

      if (value is double || value is int) {
        value = value.toString();
      }

      String? validationRules;
      String? validationMessage;
      bool Function(dynamic value)? customValidationRule;
      Map<String, dynamic> formRules = widget.form.getValidate;
      if (formRules.containsKey(field.key)) {
        dynamic rule = formRules[field.key];
        if (rule is String) {
          validationRules = rule;
        }

        if (rule is FormValidator) {
          customValidationRule = rule.customRule;
          if (rule.customRule == null) {
            validationRules = rule.rules;
          }
          if (rule.message != null) {
            validationMessage = rule.message;
          }
        }

        if ((rule is List) && rule.isNotEmpty) {
          validationRules = rule[0];
          if (rule.length == 2) {
            validationMessage = rule[1];
          }
        }
      }

      String? dummyDataValue;
      if (getEnv('APP_ENV') == 'developing') {
        Map<String, dynamic> dummyData = widget.form.getDummyData;
        if (dummyData.containsKey(field.key)) {
          dummyDataValue = dummyData[field.key];
          if (dummyDataValue != null && value == null) {
            widget.form
                .setFieldValue(field.key, dummyDataValue, refreshState: false);
          }
        }
      }

      Widget? headerValue;
      Map<String, dynamic> headerData = widget.form.getHeaderData;
      if (headerData.containsKey(field.key)) {
        headerValue = headerData[field.key];
      }

      Widget? footerValue;
      Map<String, dynamic> footerData = widget.form.getFooterData;
      if (footerData.containsKey(field.key)) {
        footerValue = footerData[field.key];
      }

      Map<String, CustomTextField Function(CustomTextField)>? metaDataValue;
      Map<String, dynamic> metaData = widget.form.getMetaData;
      if (metaData.containsKey(field.key)) {
        metaDataValue = metaData[field.key];
      }

      bool isHidden = false;
      Map<String, dynamic> isHiddenData = widget.form.getHiddenData;
      if (isHiddenData.containsKey(field.key)) {
        isHidden = isHiddenData[field.key];
      }

      bool readOnly = false;
      Map<String, dynamic> readOnlyData = widget.form.getReadOnlyData;
      if (readOnlyData.containsKey(field.key)) {
        readOnly = readOnlyData[field.key] ?? false;
      }

      Field nyField = Field(
        field.key,
        value: value,
        cast: fieldCast,
        autofocus: autofocus,
        header: headerValue,
        footer: footerValue,
        metaData: metaDataValue,
        hidden: isHidden,
        readOnly: readOnly,
      );

      NyFormItem formItem = NyFormItem(
          field: nyField,
          validationRules: validationRules,
          validationMessage: validationMessage,
          validateOnFocusChange: widget.validateOnFocusChange,
          dummyData: dummyDataValue,
          customValidationRule: customValidationRule,
          fieldStyle: fieldStyle,
          formStyle: nyFormStyle,
          style: style,
          updated: widget.form.updated,
          onChanged: (dynamic fieldValue) {
            if (fieldValue is DateTime) {
              widget.form
                  .setFieldValue(field.key, fieldValue, refreshState: false);
              return;
            }
            widget.form
                .setFieldValue(field.key, fieldValue, refreshState: false);
          });

      return formItem;
    }).toList();
  }

  stateUpdated(dynamic data) async {
    if (data is Map && data.containsKey('action')) {
      if (data['action'] == 'refresh') {
        _construct();
        return;
      }
      if (data['action'] == 'clear') {
        widget.form.clear(refreshState: false);
        _construct();
        return;
      }
      if (data['action'] == 'setValue') {
        _children = _children.update((child) => child.field.name == data['key'],
            (child) {
          child.field.value = data['value'];
          return child;
        });
        _construct();
        setState(() {});
        return;
      }

      if (data['action'] == 'setOptions') {
        _children = _children.update((child) => child.field.name == data['key'],
            (child) {
          if (child.field.cast.type == "picker") {
            child.field.cast.metaData!['options'] = data['value'];
          }
          return child;
        });
        _construct();
        setState(() {});
        return;
      }
      if (["hideField", "showField"].contains(data['action'])) {
        String field = data['field'];

        _children =
            _children.update((child) => child.field.name == field, (child) {
          if (data['action'] == 'hideField') {
            child.field.hide();
            showableFields.remove(field);
          } else if (data['action'] == 'showField') {
            showableFields.add(field);
            child.field.show();
          }
          return child;
        });
        setState(() {});
        return;
      }

      if (data['action'] == 'refresh-form') {
        _construct();
        initialFormData = null;
        setState(() {});
        return;
      }
      return;
    }
    data as Map<String, dynamic>;

    // Get the rules, onSuccess and onFailure functions
    Map<String, dynamic> rules =
        data.containsKey("rules") ? data["rules"] : widget.form.getValidate;
    Function(dynamic value) onSuccess = data["onSuccess"];
    Function(Exception error)? onFailure;
    bool showToastError = data["showToastError"];
    if (data.containsKey("onFailure")) {
      onFailure = data["onFailure"];
    }

    // Update the rules with the current form data
    Map<String, dynamic> formData = widget.form.data();
    for (var field in formData.entries) {
      if (rules.containsKey(field.key)) {
        if (rules[field.key] is FormValidator) {
          FormValidator formValidator = rules[field.key];

          if (field.value is List) {
            formValidator.setData((field.value as List).join(", ").toString());
          } else {
            formValidator.setData(field.value);
          }

          rules[field.key] = formValidator;
        }
      }
    }

    // Validate the form
    validate(
      rules: rules,
      onSuccess: () {
        Map<String, dynamic> currentData =
            widget.form.data(lowerCaseKeys: true);
        onSuccess(currentData);
      },
      onFailure: (Exception exception) {
        if (onFailure == null) return;
        onFailure(exception);
      },
      showAlert: showToastError,
    );
  }

  Widget view(BuildContext context) {
    /// If the form has initial data, construct the form
    if (initialFormData != null) {
      _construct();
      return _createWidget(IgnorePointer(
        ignoring: widget.locked,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: _createForm(),
        ),
      ));
    }

    if (widget.form.getLoadData is! Future Function() &&
        widget.form.getLoadData != null &&
        initialFormData == null) {
      initialFormData = widget.form.getLoadData!();
      widget.form.setData(initialFormData, refreshState: false);
    }

    if (widget.form.getLoadData is Future Function()) {
      // ignore: prefer_function_declarations_over_variables
      dynamic formData = () async {
        if (initialFormData == null) {
          dynamic data = await widget.form.getLoadData!();
          initialFormData = data;
          widget.form.setData(data, refreshState: false);
        }
        _construct();
        return _createForm();
      };

      return _createWidget(IgnorePointer(
        ignoring: widget.locked,
        child: NyFutureBuilder<List<Widget>>(
            future: formData(),
            child: (context, data) {
              widget.form.formReady();
              return ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [if (data != null) ...data],
              );
            },
            loadingStyle: LoadingStyle.normal(child: loadingWidget())),
      ));
    }

    _construct();

    return _createWidget(IgnorePointer(
      ignoring: widget.locked,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: _createForm(),
      ),
    ));
  }

  /// Create the widget
  Widget _createWidget(Widget widgetForm) {
    if (widget.type == "list") {
      return Column(
        children: [
          if (widget.header != null) widget.header!,
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [widgetForm, ...widget.children!],
            ),
          ),
          if (widget.footer != null) widget.footer!,
        ],
      );
    }

    if (widget.header != null || widget.footer != null) {
      return Column(
        children: [
          if (widget.headerSpacing > 0) SizedBox(height: widget.headerSpacing),
          if (widget.header != null) widget.header!,
          widgetForm,
          if (widget.footerSpacing > 0) SizedBox(height: widget.footerSpacing),
          if (widget.footer != null) widget.footer!,
        ],
      );
    }

    return widgetForm;
  }

  /// Loading widget
  Widget loadingWidget() {
    if (widget.loading != null) {
      return widget.loading!;
    }

    return widget.loadingStyle.render(
        child: Column(
      children: _createForm(),
    ));
  }

  List<Widget> _createForm() {
    List<Widget> items = [];
    List<List<dynamic>> groupedItems = widget.form.groupedItems;
    List<NyFormItem> childrenNotHidden = _children.where((test) {
      if (test.field.hidden == false) {
        return true;
      }
      if (showableFields.contains(test.field.name)) {
        return true;
      }
      return false;
    }).toList();

    for (List<dynamic> listItems in groupedItems) {
      if (listItems.length == 1) {
        List<NyFormItem> allItems = childrenNotHidden
            .where((test) => test.field.name == listItems[0])
            .toList();
        if (allItems.isNotEmpty) {
          items.add(allItems.first);
        }
        continue;
      }

      List<Widget> childrenRowWidgets = [
        for (String action in listItems)
          (childrenNotHidden
                  .where((test) => test.field.name == action)
                  .isNotEmpty)
              ? Flexible(
                  child: childrenNotHidden
                          .where((test) => test.field.name == action)
                          .isNotEmpty
                      ? childrenNotHidden
                          .where((test) => test.field.name == action)
                          .first
                      : const SizedBox.shrink())
              : const SizedBox.shrink()
      ];

      Row row = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: childrenRowWidgets,
      ).withGap(childrenRowWidgets
              .where((element) => element.runtimeType == SizedBox)
              .isNotEmpty
          ? 0
          : widget.mainAxisSpacing);

      items.add(row);
    }

    return items.withGap(widget.crossAxisSpacing);
  }

  @override
  Widget build(BuildContext context) {
    if (!shouldLoadView && overrideLoading == false) {
      return view(context);
    }

    if (hasInitComplete == false || isLoading()) {
      switch (loadingStyle.type) {
        case LoadingStyleType.normal:
          {
            if (loadingStyle.child != null) {
              return loadingStyle.child!;
            }
            return CircularProgressIndicator();
          }
        case LoadingStyleType.skeletonizer:
          {
            if (loadingStyle.child != null) {
              return Skeletonizer(
                enabled: true,
                child: loadingStyle.child!,
              );
            }
            return Skeletonizer(
              enabled: true,
              child: view(context),
            );
          }
        case LoadingStyleType.none:
          return view(context);
      }
    }
    return view(context);
  }
}
