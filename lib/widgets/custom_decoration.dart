import 'package:flutter/material.dart';

InputDecoration customInputDecoration({
  required String labelText,
  required String hintText,
  Color? fillColor,
  Icon? prefixIcon,
  String? prefixText = '',
  Icon? suffixIcon,
}) {
  return InputDecoration(
    labelText: labelText,
    hintText: hintText,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    filled: true,
    fillColor: fillColor,
    prefixIcon: prefixIcon,
    prefixText: prefixText,
    suffixIcon: suffixIcon,
  );
}
