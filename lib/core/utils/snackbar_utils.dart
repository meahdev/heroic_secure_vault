import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:secure_vault/core/constants/app_colors.dart';

import '../../shared/widgets/custom_text/custom_text.dart';

/// For showing success/error snackBar
class SnackBarUtils {
  static showSnackBar(BuildContext context, String message, {int? seconds}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    context.showFlash<bool>(
      barrierDismissible: true,
      duration: Duration(seconds: seconds ?? 2),
      builder:
          (context, controller) => flashBar(
            controller,
            msg: message,
            backgroundColor:
                isDark ? AppColors.darkInverse : AppColors.lightBackground,
            context: context,
          ),
    );
  }

  ///Creating flash-bar
  static FlashBar<bool> flashBar(
    FlashController<bool> controller, {
    required String msg,
    required Color backgroundColor,
    required BuildContext context,
  }) {
    return FlashBar(
      backgroundColor: backgroundColor,
      controller: controller,
      forwardAnimationCurve: Curves.easeInCirc,
      reverseAnimationCurve: Curves.bounceInOut,
      position: FlashPosition.top,
      content: CustomText(
        msg,
        textAlign: TextAlign.center,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: AppColors.white),
      ),
    );
  }
}
