import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SimpleDropdown extends StatefulWidget {
  final String labelText;
  final List<String> items;
  final void Function(String?) onChanged;
  final bool isSearchable;
  final AxisDirection axisDirection;
  final Widget? suffixIcon;

  const SimpleDropdown({
    Key? key,
    required this.labelText,
    required this.items,
    required this.onChanged,
    this.isSearchable = true,
    this.axisDirection = AxisDirection.down,
    this.suffixIcon,
  }) : super(key: key);

  @override
  State<SimpleDropdown> createState() => _StatefulDropdownState();
}

class _StatefulDropdownState extends State<SimpleDropdown> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color grey = Colors.grey; // Default grey color
    const Color white = Colors.white;

    final Widget suffixIcon = widget.suffixIcon ??
        Icon(
          Icons.arrow_drop_down,
          color: Theme.of(context).primaryColor,
          size: 30,
        );

    return TypeAheadFormField<String>(
      suggestionsBoxVerticalOffset: 4,
      direction: widget.axisDirection,
      textFieldConfiguration: TextFieldConfiguration(
        controller: _controller,
        enableSuggestions: true,
        style: const TextStyle(color: Colors.black, fontSize: 16),
        decoration: InputDecoration(
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
          contentPadding: const EdgeInsets.all(10),
          fillColor: white,
          filled: true,
          labelText: widget.labelText,
          suffixIcon: suffixIcon,
        ),
      ),
      suggestionsCallback: (pattern) {
        if (widget.isSearchable) {
          return widget.items
              .where((e) => e.toUpperCase().contains(pattern.toUpperCase()))
              .toList();
        } else {
          return widget.items;
        }
      },
      itemBuilder: (context, String suggestion) {
        return ListTile(
          title: Text(suggestion),
        );
      },
      onSuggestionSelected: (String suggestion) {
        _controller.text = suggestion;
        widget.onChanged(suggestion);
      },
      hideKeyboard: !widget.isSearchable,
      noItemsFoundBuilder: (context) => const Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          'No items found',
          style: TextStyle(fontSize: 16),
        ),
      ),
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        borderRadius: BorderRadius.circular(10),
        elevation: 8.0,
        shadowColor: Colors.black45,
        color: white,
        constraints: const BoxConstraints(
          maxHeight: 200.0, // Adjust height as needed
        ),
      ),
    );
  }
}
