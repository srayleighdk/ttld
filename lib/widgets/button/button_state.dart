import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ttld/core/utils/extenstions.dart';
import 'package:ttld/helppers/loading_styles.dart';
import 'package:ttld/helppers/ny_logger.dart';
import 'package:ttld/widgets/form/ny_form.dart';
import 'package:ttld/widgets/form/ny_form_data.dart';

class ButtonState extends StatefulWidget {
  const ButtonState({
    super.key,
    required this.child,
    this.onSubmit,
    this.loadingStyle,
    this.onFailure,
    this.showToastError,
    this.skeletonizerLoading,
    this.loading,
  });

  final Widget Function(VoidCallback? onPressed) child;
  final (Function()? onPressed, (dynamic, Function(dynamic data))?)? onSubmit;
  final Function(dynamic data)? onFailure;
  final bool? showToastError;
  final LoadingStyle? loadingStyle;
  @Deprecated('Use loadingStyle instead')
  final bool? skeletonizerLoading;
  @Deprecated('Use loadingStyle instead')
  final Widget? loading;

  @override
  State<ButtonState> createState() => _ButtonStateState();
}

class _ButtonStateState extends State<ButtonState> {
  /// Check if the form is loading
  bool formLoading = false;

  Map<String, bool> _lockMap = {};

  bool isLocked(String name) {
    if (_lockMap.containsKey(name) == false) {
      _lockMap[name] = false;
    }
    return _lockMap[name]!;
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

  /// Update the lock state.
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

  _setLock(String name, {required bool value}) {
    _lockMap[name] = value;
  }

  @override
  void initState() {
    super.initState();
    if (widget.onSubmit?.$2?.$1 is NyFormData &&
        (widget.onSubmit?.$2?.$1 as NyFormData).getLoadData is Future
            Function()) {
      formLoading = true;

      (widget.onSubmit!.$2!.$1 as NyFormData).isReady.listen((ready) {
        if (ready) {
          setState(() {
            formLoading = false;
          });
        }
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLocked(widget.child.toString()) || formLoading) {
      // ignore: deprecated_member_use_from_same_package
      if (widget.skeletonizerLoading == false) {
        // ignore: deprecated_member_use_from_same_package
        if (widget.loading != null) {
          // ignore: deprecated_member_use_from_same_package
          return widget.loading!;
        }
        return SizedBox(
          height: 50,
          child: CircularProgressIndicator(),
        );
      }

      if (widget.loadingStyle?.type == LoadingStyleType.skeletonizer) {
        if (widget.loadingStyle?.child != null) {
          return SizedBox(
            height: 50,
            child: widget.loadingStyle!.child!.toSkeleton(),
          );
        }
        return widget.child(null).toSkeleton();
      }
      if (widget.loadingStyle?.type == LoadingStyleType.normal) {
        if (widget.loadingStyle?.child != null) {
          return widget.loadingStyle?.child ??
              SizedBox(
                height: 50,
                child: CircularProgressIndicator(),
              );
        }
        return SizedBox(
          height: 50,
          child: CircularProgressIndicator(),
        );
      }
      if (widget.loadingStyle?.type == LoadingStyleType.none) {
        return widget.child(null);
      }
      return widget.child(null).toSkeleton();
    }
    return widget.child(() {
      if (widget.onSubmit == null) return;
      if (widget.onSubmit!.$2 != null) {
        assert(widget.onSubmit!.$2!.$1 != null,
            "Form ID is required for form submission");
        assert(
            widget.onSubmit!.$2!.$1 is String ||
                widget.onSubmit!.$2!.$1 is NyFormData,
            "Form ID must be a String or NyFormData");
        late String formId;
        if (widget.onSubmit!.$2!.$1 is NyFormData) {
          formId = (widget.onSubmit!.$2!.$1 as NyFormData).name!;
        } else {
          formId = widget.onSubmit!.$2!.$1 as String;
        }
        NyForm.submit(formId, onSuccess: (data) {
          if (widget.onSubmit!.$2!.$2 is Future Function(dynamic data)) {
            lockRelease(widget.child.toString(), perform: () async {
              await widget.onSubmit!.$2!.$2(data);
            });
          } else {
            widget.onSubmit!.$2!.$2(data);
          }
        },
            onFailure: widget.onFailure,
            showToastError: widget.showToastError ?? true);
      }
      try {
        if (widget.onSubmit!.$1 is Future Function()) {
          lockRelease(widget.child.toString(), perform: () async {
            await widget.onSubmit!.$1!();
          });
        } else {
          if (widget.onSubmit!.$1 != null) widget.onSubmit!.$1!();
        }
      } catch (e) {
        if (widget.onFailure != null) widget.onFailure!(e);
      }
    });
  }
}
