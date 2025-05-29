import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:secure_vault/core/constants/app_colors.dart';
import 'package:secure_vault/core/constants/app_strings.dart';

import '../widgets/custom_button/custom_text_button.dart';
import '../widgets/custom_text/custom_text.dart';

/// A platform-adaptive alert view supporting both Material and Cupertino styles.
/// It provides optional cancel and positive buttons, loading state, and content padding.
class AlertView extends StatelessWidget {
  const AlertView({
    super.key,
    required this.onPositiveTap,
    required this.title,
    required this.message,
    required this.positiveLabel,
    this.fontSize,
    this.isCancelButton = true,
    this.contentPadding,
    this.onCancelTap,
  });

  final VoidCallback onPositiveTap;
  final Function? onCancelTap;
  final String title;
  final String message;
  final String positiveLabel;
  final double? fontSize;
  final bool isCancelButton;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? _buildMaterialDialog(context)
        : _buildCupertinoDialog(context);
  }

  /// Builds a Material-style alert dialog.
  Widget _buildMaterialDialog(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AlertDialog(
      backgroundColor: isDark ? AppColors.darkInverse : AppColors.white,
      contentPadding:
          contentPadding ?? const EdgeInsets.fromLTRB(24, 20, 24, 24),
      title: CustomText(
        title,
        style: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: isDark ? AppColors.white : AppColors.black,
        ),
        textAlign: TextAlign.center,
      ),
      content: CustomText(
        message,
        style: textTheme.bodySmall?.copyWith(
          color: isDark ? AppColors.white : AppColors.black,
        ),
        textAlign: TextAlign.start,
      ),
      actions: [
        if (isCancelButton)
          CustomTextButton(
            onPressed: () {
              Navigator.pop(context);
              if (onCancelTap != null) onCancelTap!();
            },
            child: CustomText(
              AppStrings.cancel,
              style: Theme.of(context).inputDecorationTheme.errorStyle,
            ),
          ),
        CustomTextButton(
          onPressed: onPositiveTap,
          child: CustomText(
            positiveLabel,
            style: textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.blue,
            ),
          ),
        ),
      ],
    );
  }

  /// Builds a Cupertino-style alert dialog.
  Widget _buildCupertinoDialog(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CupertinoAlertDialog(
      title: CustomText(
        title,
        style: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: isDark ? AppColors.white : AppColors.black,
        ),
        textAlign: TextAlign.center,
      ),
      content: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: CustomText(
          message,
          style: textTheme.bodySmall?.copyWith(
            color: isDark ? AppColors.white : AppColors.black,
          ),
          textAlign: TextAlign.start,
        ),
      ),
      actions: [
        if (isCancelButton)
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
              if (onCancelTap != null) {
                onCancelTap!();
              }
            },
            child: CustomText(
              AppStrings.cancel,
              style: Theme.of(context).inputDecorationTheme.errorStyle,
            ),
          ),
        CupertinoDialogAction(
          onPressed: onPositiveTap,
          child: CustomText(
            positiveLabel,
            style: textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
