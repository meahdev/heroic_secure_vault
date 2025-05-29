import 'package:flutter/material.dart';
import 'package:secure_vault/core/constants/app_colors.dart';

import '../custom_text/custom_text.dart';

class CustomTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Widget? child;
  final TextStyle? textStyle;
  final bool isUnderLine;

  const CustomTextButton({
    super.key,
    this.text = "",
    required this.onPressed,
    this.horizontalPadding,
    this.verticalPadding,
    this.fontWeight,
    this.fontSize,
    this.child,
    this.textStyle,
    this.isUnderLine = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 0,
            vertical: verticalPadding ?? 0,
          ),
        ),
      ),
      child:
          child ??
          CustomText(
            text,
            style:
                textStyle ??
                Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: isDark ? AppColors.white : AppColors.black,
                  fontSize: fontSize,
                  decoration:
                      isUnderLine
                          ? TextDecoration.underline
                          : TextDecoration.none,
                ),
          ),
    );
  }
}
