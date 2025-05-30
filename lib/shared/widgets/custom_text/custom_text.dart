import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  // Constructor with required label text and optional styling parameters
  const CustomText(
      this.label, {
        this.maxLines,
        super.key,
        this.textAlign,
        this.softWrap,
        this.textOverflow,
        this.height,
        this.horizontalPadding,
        this.verticalPadding,
        this.style,
      });

  // The string to display
  final String label;

  // Optional maximum number of lines for the text
  final int? maxLines;

  // Optional text alignment
  final TextAlign? textAlign;

  // Optional flag to enable/disable soft wrapping of text
  final bool? softWrap;

  // Optional overflow behavior for text (not currently used in build)
  final TextOverflow? textOverflow;

  // Optional height of the text line (not currently used in build)
  final double? height;

  // Optional horizontal padding around the text
  final double? horizontalPadding;

  // Optional vertical padding around the text
  final double? verticalPadding;

  // Optional text style
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    // Wraps the Text widget with Padding using given horizontal and vertical padding or zero by default
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 0,
        vertical: verticalPadding ?? 0,
      ),
      child: Text(
        label,
        maxLines: maxLines??10,
        softWrap: softWrap,
        textAlign: textAlign,
        style: style,
        // Uses ellipsis for overflow if text exceeds constraints
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
