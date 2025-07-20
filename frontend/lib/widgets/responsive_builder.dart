import 'package:flutter/material.dart';

/// A widget that makes its child responsive by limiting the maximum width
/// to ensure proper display on larger screens.
class ResponsiveBuilder extends StatelessWidget {
  /// The child widget to display.
  final Widget child;

  /// The maximum width for the content.
  /// Defaults to 512 pixels.
  final double maxWidth;

  /// Horizontal padding to apply around the content.
  /// Defaults to 24 pixels.
  final double horizontalPadding;

  /// Creates a responsive builder with the specified parameters.
  const ResponsiveBuilder({
    super.key,
    required this.child,
    this.maxWidth = 512.0,
    this.horizontalPadding = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: child,
      ),
    );
  }
}
