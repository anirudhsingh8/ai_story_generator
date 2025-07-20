import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final bool isFullWidth;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.isFullWidth = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget buttonContent = isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        : Text(text);

    Widget button = isOutlined
        ? ShadButton.outline(
            onPressed: isLoading ? null : onPressed,
            child: buttonContent,
          )
        : ShadButton(
            onPressed: isLoading ? null : onPressed,
            child: buttonContent,
          );

    return isFullWidth
        ? SizedBox(
            width: double.infinity,
            child: button,
          )
        : button;
  }
}
