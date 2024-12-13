import 'package:flutter/material.dart';
import 'package:utility/widgets/custom_decoration.dart';

class CustomTextField extends StatelessWidget {
  final bool isDisabled;
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final Icon? prefixIcon;
  final String? prefixText = '';
  final Icon? suffixIcon;
  final Color? fillColor;

  const CustomTextField({
    required this.isDisabled,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: !isDisabled,
      decoration: customInputDecoration(
        labelText: labelText,
        hintText: hintText,
        fillColor: fillColor,
        prefixIcon: prefixIcon,
        prefixText: prefixText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
