import 'dart:async';

import 'package:flutter/material.dart';

class DebounceTextField extends StatefulWidget {
  const DebounceTextField(
      {super.key, required this.onChanged, required this.controller});

  final Function(String) onChanged;
  final TextEditingController controller;

  @override
  State<DebounceTextField> createState() => _DebounceTextFieldState();
}

class _DebounceTextFieldState extends State<DebounceTextField> {
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onChanged(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: TextFormField(
        onChanged: _onSearchChanged,
        controller: widget.controller,
        decoration: const InputDecoration(
          hintText: 'Введите название фильма',
        ),
      ),
    );
  }
}
