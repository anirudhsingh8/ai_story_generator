import 'package:flutter/material.dart';

class AppTextInput extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController controller;
  final bool isMultiline;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool enabled;

  const AppTextInput({
    super.key,
    required this.label,
    this.hintText,
    required this.controller,
    this.isMultiline = false,
    this.validator,
    this.keyboardType,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: isMultiline ? 5 : 1,
      minLines: isMultiline ? 3 : 1,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        alignLabelWithHint: isMultiline,
      ),
    );
  }
}
