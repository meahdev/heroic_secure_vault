import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../custom_text/custom_text.dart';

class CustomButton extends StatelessWidget {
  final double? borderWidth;
  final double? borderRadius;
  final void Function()? onPressed;
  final void Function()? onLongPress;
  final bool autofocus;
  final String text;
  final double? elevation;
  final FontWeight? fontWeight;
  final Color? borderColor;
  final bool enableFeedback;
  final double? fontSize;
  final double? horizontalPadding;
  final double? verticalPadding;
  final TextAlign? textAlign;
  final bool isUnderLine;
  final bool isStrike;

  const CustomButton({
    super.key,
    required this.text,
    this.enableFeedback = true,
    this.borderWidth,
    this.borderRadius,
    this.fontSize,
    this.onPressed,
    this.onLongPress,
    this.autofocus = false,
    this.elevation,
    this.borderColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.fontWeight,
    this.textAlign,
    this.isUnderLine = false,
    this.isStrike = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blue,
        elevation: elevation ?? 1,
        shape:
            borderRadius != null || borderColor != null
                ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    borderRadius ?? 4,
                  ), // Adjust the radius as needed
                  side:
                      isStrike
                          ? BorderSide(color: Colors.transparent)
                          : borderColor != null
                          ? BorderSide(color: borderColor ?? Colors.white)
                          : BorderSide(
                            color:
                                theme.elevatedButtonTheme.style?.backgroundColor
                                    ?.resolve({WidgetState.pressed}) ??
                                Colors.white,
                          ),
                )
                : null,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 10,
          vertical: verticalPadding ?? 10,
        ),
        splashFactory: InkRipple.splashFactory, // Splash effect
      ),
      onPressed: onPressed,
      onLongPress: onLongPress,
      autofocus: autofocus,
      child: CustomText(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: isDark ? AppColors.white : AppColors.black,
          fontSize: fontSize,
          decoration:
              isStrike ? TextDecoration.lineThrough : TextDecoration.none,
        ),
        textAlign: textAlign,
      ),
    );
  }
}
