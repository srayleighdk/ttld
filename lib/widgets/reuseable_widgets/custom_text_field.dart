import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final DecoratorTextField? decoration;

  const CustomTextField({
    super.key,
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
  });

  factory CustomTextField.email({
    TextEditingController? controller,
    String? Function(String?)? validator,
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
    String? Function(String?)? validator,
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

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }

  factory CustomTextField.addressDetail({
    Key? key,
    required TextEditingController controller,
    String? tinh,
    String? huyen,
    String? xa,
    String labelText = "Địa chỉ chi tiết",
    String? Function(String?)? validator,
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
      keyboardType: keyboardType,
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
