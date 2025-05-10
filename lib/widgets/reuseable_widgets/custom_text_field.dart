import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final dynamic validator;
  final void Function(String)? onChanged;
  final DecoratorTextField? decoration;
  final bool validateOnBlur;
  final bool autoValidate;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool expands;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField(
      {super.key,
      this.labelText = '',
      required this.hintText,
      this.controller,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.prefixIcon,
      this.suffixIcon,
      this.validator,
      this.onChanged,
      this.decoration,
      this.validateOnBlur = true,
      this.autoValidate = false,
      this.focusNode,
      this.maxLines = 1,
      this.minLines,
      this.maxLength,
      this.expands = false,
      this.inputFormatters});

  factory CustomTextField.email({
    TextEditingController? controller,
    dynamic validator,
    void Function(String)? onChanged,
  }) {
    return CustomTextField(
      labelText: 'Email',
      hintText: 'Enter your email',
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.email),
      controller: controller,
      validator: validator,
      onChanged: onChanged,
    );
  }

  factory CustomTextField.password({
    TextEditingController? controller,
    dynamic validator,
    void Function(String)? onChanged,
  }) {
    return CustomTextField(
      labelText: 'Password',
      hintText: 'Enter your password',
      obscureText: true,
      prefixIcon: const Icon(Icons.lock),
      controller: controller,
      validator: validator,
      onChanged: onChanged,
    );
  }

  factory CustomTextField.numberGrok({
    TextEditingController? controller,
    dynamic validator,
    void Function(String)? onChanged,
    String hintText = 'Enter a number',
    String labelText = 'Number',
  }) {
    return CustomTextField(
      labelText: labelText,
      hintText: hintText,
      keyboardType: TextInputType.number,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }

  factory CustomTextField.addressDetail({
    Key? key,
    required TextEditingController controller,
    String? tinh,
    String? huyen,
    String? xa,
    String labelText = "Địa chỉ chi tiết",
    dynamic validator,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    String hintText = _buildAddressHint(xa, huyen, tinh);
    return CustomTextField(
      key: key,
      controller: controller,
      labelText: labelText,
      hintText: hintText,
      validator: validator,
      keyboardType: TextInputType.text,
      obscureText: obscureText,
    );
  }

  static String _buildAddressHint(String? xa, String? huyen, String? tinh) {
    String address = "";
    if (xa != null && xa.isNotEmpty) {
      address += "Xã $xa";
    }
    if (huyen != null && huyen.isNotEmpty) {
      if (address.isNotEmpty) address += ", ";
      address += "Huyện $huyen";
    }
    if (tinh != null && tinh.isNotEmpty) {
      if (address.isNotEmpty) address += ", ";
      address += "Tỉnh $tinh";
    }
    return address.isNotEmpty ? address : "Địa chỉ chi tiết";
  }

// Add this method to handle predefined validators
  static String? handleValidation(String? value, dynamic validator) {
    if (validator == null) return null;

    if (validator is String) {
      switch (validator) {
        case 'not_empty':
          return value == null || value.trim().isEmpty
              ? 'This field is required'
              : null;
        case 'email':
          if (value == null || value.trim().isEmpty) {
            return 'Email is required';
          }
          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          return !emailRegex.hasMatch(value)
              ? 'Please enter a valid email'
              : null;
        case 'phone':
          if (value == null || value.trim().isEmpty) {
            return 'Phone number is required';
          }
          final phoneRegex = RegExp(r'^\d{10}$');
          return !phoneRegex.hasMatch(value)
              ? 'Please enter a valid 10-digit phone number'
              : null;
        default:
          return null;
      }
    }

    // If validator is a function, use it directly
    if (validator is String? Function(String?)) {
      return validator(value);
    }

    return null;
  }

  // Add new factory constructor for numbers
  factory CustomTextField.number({
    Key? key,
    String labelText = '',
    String hintText = '',
    TextEditingController? controller,
    bool allowDecimals = true,
    num? min,
    num? max,
    dynamic validator,
    void Function(String)? onChanged,
  }) {
    final numberController = controller ?? TextEditingController();

    return CustomTextField(
      key: key,
      labelText: labelText,
      hintText: hintText,
      controller: numberController,
      keyboardType: allowDecimals
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.number,
      validator: (String? value) {
        if (validator != null) {
          final validatorResult =
              CustomTextField.handleValidation(value, validator);
          if (validatorResult != null) return validatorResult;
        }

        if (value == null || value.isEmpty) {
          return 'This field is required';
        }

        // Try parsing the number
        try {
          final number = allowDecimals ? double.parse(value) : int.parse(value);

          // Check min value
          if (min != null && number < min) {
            return 'Value must be greater than or equal to $min';
          }

          // Check max value
          if (max != null && number > max) {
            return 'Value must be less than or equal to $max';
          }
        } catch (e) {
          return allowDecimals
              ? 'Please enter a valid number'
              : 'Please enter a valid integer';
        }

        return null;
      },
      onChanged: (value) {
        // Remove any non-numeric characters except decimal point if allowed
        final newValue = value.replaceAll(
            allowDecimals ? RegExp(r'[^0-9.]') : RegExp(r'[^0-9]'), '');

        // Ensure only one decimal point
        if (allowDecimals && newValue.split('.').length > 2) {
          numberController.text = newValue.replaceFirst(RegExp(r'\..*\.'), '.');
          numberController.selection = TextSelection.fromPosition(
            TextPosition(offset: numberController.text.length),
          );
        } else {
          numberController.text = newValue;
          numberController.selection = TextSelection.fromPosition(
            TextPosition(offset: newValue.length),
          );
        }

        if (onChanged != null) {
          onChanged(newValue);
        }
      },
    );
  }

  // Add new factory constructor for text area
  factory CustomTextField.textArea({
    Key? key,
    String labelText = '',
    String hintText = '',
    TextEditingController? controller,
    int? minLines = 3,
    int? maxLines = 5,
    int? maxLength,
    dynamic validator,
    void Function(String)? onChanged,
    bool autoValidate = false,
  }) {
    return CustomTextField(
      key: key,
      labelText: labelText,
      hintText: hintText,
      controller: controller,
      keyboardType: TextInputType.multiline,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      validator: validator,
      onChanged: onChanged,
      autoValidate: autoValidate,
      decoration: DecoratorTextField(
        decoration: (data, decoration) {
          return decoration.copyWith(
            alignLabelWithHint: true,
            contentPadding: const EdgeInsets.all(12),
          );
        },
      ),
    );
  }

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  String? _errorText;
  bool _isValid = false;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      // Validate when focus is lost
      setState(() {
        if (widget.validator != null) {
          _errorText = CustomTextField.handleValidation(
              _controller.text, widget.validator);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        maxLength: widget.maxLength,
        expands: widget.expands,
        inputFormatters: widget.inputFormatters,
        validator: (value) {
          final error =
              CustomTextField.handleValidation(value, widget.validator);
          setState(() {
            _errorText = error;
            _isValid = error == null;
          });
          return error;
        },
        onChanged: (value) {
          if (widget.autoValidate) {
            setState(() {
              _errorText =
                  CustomTextField.handleValidation(value, widget.validator);
              _isValid = _errorText == null;
            });
          } else {
            setState(() {
              _errorText = null;
            });
          }
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          alignLabelWithHint: true,
          labelStyle: TextStyle(
            color: _errorText != null ? Colors.red : Colors.black,
          ),
          floatingLabelStyle: TextStyle(
            color: _errorText != null
                ? Colors.red
                : _focusNode.hasFocus
                    ? Colors.blue
                    : Colors.black,
          ),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10.0),
          // ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          errorText: _errorText,
          errorStyle: const TextStyle(color: Colors.red),
          errorBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: _errorText != null ? Colors.red : Colors.blue,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: _errorText != null
                  ? Colors.red
                  : _isValid
                      ? Colors.green
                      : Colors.black,
              width: 1.0,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}

class DecoratorTextField {
  final InputDecoration Function(dynamic data, InputDecoration inputDecoration)?
      decoration;
  final InputDecoration Function(dynamic data, InputDecoration inputDecoration)?
      successDecoration;
  final InputDecoration Function(dynamic data, InputDecoration inputDecoration)?
      errorDecoration;

  DecoratorTextField({
    this.decoration,
    this.successDecoration,
    this.errorDecoration,
  });
}
