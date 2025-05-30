import 'package:flutter/material.dart';
import 'package:secure_vault/core/constants/app_colors.dart';
import 'package:secure_vault/shared/widgets/custom_text_field/text_field_config.dart';

class CustomTextField extends StatelessWidget {
  // Configuration object to customize behavior and appearance of this text field
  final TextFieldConfig config;

  const CustomTextField({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      // Controls capitalization of input text
      textCapitalization: config.textCapitalization,

      // Whether the text field is enabled for input
      enabled: config.isEnabled,

      // Vertical alignment of the text within the field, defaulting to center
      textAlignVertical: config.textAlignVertical ?? TextAlignVertical.center,

      // Input formatters to restrict/format input text
      inputFormatters: config.inputFormatter ?? [],

      // Controller to read and manipulate the text field's text
      controller: config.controller,

      // Focus node to manage focus
      focusNode: config.focusNode,

      // Horizontal text alignment inside the field
      textAlign: config.textAlign ?? TextAlign.start,

      // Max number of lines the text field can expand to
      maxLines: config.maxLines,

      // Keyboard action button type (e.g., done, next)
      textInputAction: config.textInputAction,

      // Whether the text is obscured (for passwords)
      obscureText: config.obscureText!,

      // Callback for when the text changes
      onChanged: config.onChanged,

      // Callback when text input is submitted
      onFieldSubmitted: config.onSubmitted,

      // If true, disables editing but allows selection and copying
      readOnly: config.isReadOnly,

      // Keyboard type (e.g., text, number, email)
      keyboardType: config.keyBoardType,

      // Builds the decoration for the text field using a helper method
      decoration: buildInputDecoration(theme),

      // Validation function for form validation
      validator: config.validator,

      // Maximum allowed length for input text
      maxLength: config.maxLength,

      // Text style inside the field, defaulting to given font size if no style provided
      style:
          config.style ??
          TextStyle(color: isDark ? AppColors.white : AppColors.black),
    );
  }

  // Helper method to build InputDecoration based on config and theme
  InputDecoration buildInputDecoration(ThemeData theme) {
    return InputDecoration(
      errorMaxLines: 2,
      // Limit error text to 2 lines max
      contentPadding: EdgeInsets.symmetric(
        horizontal: config.horizontalPadding ?? 15,
        vertical: config.verticalPadding ?? 12,
      ),
      counter: const Offstage(),
      // Hide the counter by default
      hintText: config.hintText,
      // Placeholder text
      hintStyle: TextStyle(
        color: config.hintColor ?? theme.inputDecorationTheme.hintStyle?.color,
        fontSize: config.fontSize ?? 12,
        fontWeight: config.hintFontWeight ?? FontWeight.w400,
      ),
      filled: true,
      // Background fill color enabled
      fillColor: config.fillColor ?? theme.inputDecorationTheme.fillColor,

      // Optional suffix icon widget and constraints
      suffixIcon: config.suffixIcon,
      suffixIconConstraints: BoxConstraints(
        minWidth: config.suffixConstraint ?? 50,
      ),

      // Optional prefix icon widget and constraints
      prefixIcon: config.prefixIcon,
      errorStyle: TextStyle(color: AppColors.white),
      prefixIconConstraints: BoxConstraints(
        minWidth: config.prefixConstraint ?? 30,
      ),

      isDense: true,
      // Reduce vertical space for a more compact look
      errorText: config.errorText,
      // Text shown when validation fails
      counterText: config.counterText, // Custom counter text if any
    );
  }
}
