import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldConfig {
  /// Controller for managing the text being edited.
  final TextEditingController controller;

  /// The action button to use for the keyboard (e.g., done, next).
  final TextInputAction? textInputAction;

  /// The focus node for managing focus state.
  final FocusNode? focusNode;

  /// Whether to hide the text being entered (e.g., for passwords).
  final bool? obscureText;

  /// Callback called when the text changes.
  final void Function(String)? onChanged;

  /// Callback called when the user submits the text.
  final void Function(String)? onSubmitted;

  /// Keyboard type to use for this text field.
  final TextInputType? keyBoardType;

  /// Error text to display below the text field.
  final String? errorText;

  /// Callback when an icon is tapped.
  final void Function()? onIconTap;

  /// Widget to show at the end of the text field.
  final Widget? suffixIcon;

  /// Widget to show at the start of the text field.
  final Widget? prefixIcon;

  /// Function for validating the text field input.
  final String? Function(String?)? validator;

  /// Placeholder text when the field is empty.
  final String? hintText;

  /// Background fill color of the text field.
  final Color? fillColor;

  /// Vertical alignment of the text within the field.
  final TextAlignVertical? textAlignVertical;

  /// List of input formatters to apply to the input.
  final List<TextInputFormatter>? inputFormatter;

  /// Whether the text field is read-only.
  final bool isReadOnly;

  /// Maximum number of characters allowed.
  final int? maxLength;

  /// Color of the border in its default state.
  final Color? borderColor;

  /// Color of the border when enabled.
  final Color? enabledBorderColor;

  /// Color of the border when focused.
  final Color? focusedBorderColor;

  /// Color of the border when disabled.
  final Color? disabledBorderColor;

  /// Color of the border when there is an error.
  final Color? errorBorderColor;

  /// Color of the border when focused and there is an error.
  final Color? focusedErrorBorderColor;

  /// Color of the hint text.
  final Color? hintColor;

  /// Whether to use outline border (true) or underline border (false).
  final bool isOutLineInputBorder;

  /// Maximum number of lines for the text field.
  final int? maxLines;

  /// Whether the text field is enabled.
  final bool isEnabled;

  /// Font size of the input text.
  final double? fontSize;

  /// Horizontal padding inside the text field.
  final double? horizontalPadding;

  /// Vertical padding inside the text field.
  final double? verticalPadding;

  /// General color, e.g., for text or icons.
  final Color? color;

  /// Font weight of the input text.
  final FontWeight? fontWeight;

  /// Font weight of the hint text.
  final FontWeight? hintFontWeight;

  /// Height constraint for suffix icon.
  final double? suffixHeight;

  /// Width constraint for suffix icon.
  final double? suffixWidth;

  /// Border radius for outline borders.
  final double? borderRadius;

  /// Minimum width constraint for prefix icon.
  final double? prefixConstraint;

  /// Minimum width constraint for suffix icon.
  final double? suffixConstraint;

  /// Horizontal alignment of the input text.
  final TextAlign? textAlign;

  /// Whether to show border or not.
  final bool isHasBorder;

  /// Custom text to show as the character counter.
  final String? counterText;

  /// Border width of the text field.
  final double? borderWidth;

  /// Custom text style for the input text.
  final TextStyle? style;

  /// Controls text capitalization behavior.
  final TextCapitalization textCapitalization;

  /// Constructor for [TextFieldConfig].
  const TextFieldConfig({
    required this.controller,
    this.textInputAction,
    this.focusNode,
    this.obscureText = false,
    this.onChanged,
    this.onSubmitted,
    this.keyBoardType,
    this.errorText,
    this.onIconTap,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.hintText,
    this.fillColor,
    this.textAlignVertical,
    this.inputFormatter,
    this.isReadOnly = false,
    this.maxLength,
    this.borderColor,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.disabledBorderColor,
    this.errorBorderColor,
    this.focusedErrorBorderColor,
    this.hintColor,
    this.isOutLineInputBorder = true,
    this.maxLines,
    this.isEnabled = true,
    this.fontSize,
    this.horizontalPadding,
    this.verticalPadding,
    this.color,
    this.fontWeight,
    this.hintFontWeight,
    this.suffixHeight,
    this.suffixWidth,
    this.borderRadius,
    this.prefixConstraint,
    this.suffixConstraint,
    this.textAlign,
    this.isHasBorder = true,
    this.counterText,
    this.borderWidth,
    this.style,
    this.textCapitalization = TextCapitalization.none,
  });
}
