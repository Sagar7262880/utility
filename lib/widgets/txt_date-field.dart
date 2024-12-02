import 'package:flutter/material.dart';

class DatePickerField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final String? Function(String?)? validator;
  final bool isEnabled;
  final bool isReadOnly;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const DatePickerField({
    Key? key,
    required this.label,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.isEnabled = true,
    this.isReadOnly = true, // Default is readonly because it's a date picker
    this.initialDate,
    this.firstDate,
    this.lastDate,
  }) : super(key: key);

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {

  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = widget.initialDate ?? DateTime.now();
    final DateTime firstDate = widget.firstDate ?? DateTime(2000);
    final DateTime lastDate = widget.lastDate ?? DateTime(2100);
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        widget.controller.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color grey = Colors.grey;

    return TextFormField(
      textAlign: TextAlign.left,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      controller: widget.controller,
      onTap: ()async {
        if (widget.isEnabled) {
       // await   _selectDate(context);\
          final DateTime currentDate = widget.initialDate ?? DateTime.now();
          final DateTime firstDate = widget.firstDate ?? DateTime(2000);
          final DateTime lastDate = widget.lastDate ?? DateTime(2100);
          print("===================");
          final DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: currentDate,
            firstDate: firstDate,
            lastDate: lastDate,
          );

          if (pickedDate != null) {
            setState(() {
              widget.controller.text = "${pickedDate.toLocal()}".split(' ')[0];
            });
          }
        }
      },
      readOnly: widget.isReadOnly,
      enabled: widget.isEnabled,
      validator: widget.validator,

      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        fillColor: Colors.white,
        filled: true,
        labelText: widget.label,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon ?? const Icon(Icons.calendar_today),
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
      ),
    );
  }
}
