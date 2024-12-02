import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TxtField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? formatters;
  final int? maxLength;
  final void Function()? onTap;
  final void Function(dynamic)? onChanged;
  final String? Function(dynamic)? validator;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final bool isEnabled;
  final bool isReadOnly;
  final int maxLines;

  const TxtField({
    Key? key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.formatters,
    this.maxLength,
    this.onTap,
    this.onChanged,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.isEnabled = true,
    this.isReadOnly = false,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  State<TxtField> createState() => _TxtFieldState();
}

class _TxtFieldState extends State<TxtField> {
  @override
  Widget build(BuildContext context) {
    const Color grey = Colors.grey; // Replace with your desired color if needed

    return TextFormField(
      textAlign: TextAlign.left,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      onTap: widget.onTap,
      maxLines: widget.maxLines,
      enabled: widget.isEnabled,
      validator: widget.validator,
      readOnly: widget.isReadOnly,
      onChanged: widget.onChanged,
      inputFormatters: widget.formatters ?? [],
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        fillColor: Colors.white,
        filled: true,
        labelText: widget.label,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        labelStyle: const TextStyle(color: Colors.black54, fontSize: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: grey, width: 0.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: grey, width: 0.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 0, color: grey),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 0, color: grey),
        ),
        counter: const Offstage(),
      ),
    );
  }
}
