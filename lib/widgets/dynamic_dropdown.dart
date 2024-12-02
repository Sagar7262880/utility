import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'dart:async';

class DynamicDropdown extends StatefulWidget {
  final String labelText;
  final void Function(dynamic) onChanged;
  final void Function(dynamic) onSuggestionSelected;
  final FutureOr<Iterable<dynamic>> Function(dynamic) onSuggestionCallback;
  final Widget Function(BuildContext context, dynamic) suggestionBuilder;
  final bool isSearchable;
  final AxisDirection axisDirection;

  const DynamicDropdown({
    Key? key,
    required this.labelText,
    required this.onChanged,
    required this.onSuggestionSelected,
    required this.onSuggestionCallback,
    required this.suggestionBuilder,
    this.isSearchable = true,
    this.axisDirection = AxisDirection.down,
  }) : super(key: key);

  @override
  State<DynamicDropdown> createState() =>
      _StatefulDynamicDropdownState();
}

class _StatefulDynamicDropdownState extends State<DynamicDropdown> {
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

    return TypeAheadFormField<dynamic>(
      direction: widget.axisDirection,
      textFieldConfiguration: TextFieldConfiguration(
        controller: _controller,
        enableSuggestions: true,
        onChanged: widget.onChanged,
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
          suffixIcon: const Icon(
            Icons.arrow_drop_down,
            color: grey,
            size: 30,
          ),
        ),
      ),
      suggestionsCallback: widget.onSuggestionCallback,
      itemBuilder: widget.suggestionBuilder,
      onSuggestionSelected: (suggestion) {
        _controller.text = suggestion.toString();
        widget.onSuggestionSelected(suggestion);
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
        scrollbarThumbAlwaysVisible: true,
        color: white,
        constraints: const BoxConstraints(
          maxHeight: 200.0, // Adjust height as needed
        ),
      ),
    );
  }
}
