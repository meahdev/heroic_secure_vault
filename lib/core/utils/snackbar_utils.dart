import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:secure_vault/core/constants/app_colors.dart';

import '../../shared/widgets/custom_text/custom_text.dart';

/// Utility class for showing snack bars using the `flash` package.
class SnackBarUtils {
  /// Shows a flash snackbar with the given [message].
  ///
  /// [context] is required to get theme and show the flash.
  /// [seconds] is an optional duration for how long the snackbar is visible (default 2 seconds).
  static showSnackBar(BuildContext context, String message, {int? seconds}) {
    // Determine if the current theme is dark or light
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Show the flash bar with custom styling and duration
    context.showFlash<bool>(
      barrierDismissible: true,
      duration: Duration(seconds: seconds ?? 3),
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

  /// Creates a configured [FlashBar] widget for displaying the message.
  ///
  /// [controller] controls the flash animation and dismissal.
  /// [msg] is the message text to show.
  /// [backgroundColor] sets the flash bar's background color.
  /// [context] is used to style the text according to the current theme.
  static FlashBar<bool> flashBar(
      FlashController<bool> controller, {
        required String msg,
        required Color backgroundColor,
        required BuildContext context,
      }) {
    return FlashBar(
      backgroundColor: backgroundColor,
      controller: controller,
      forwardAnimationCurve: Curves.easeInCirc,  // Animation curve when showing
      reverseAnimationCurve: Curves.bounceInOut, // Animation curve when dismissing
      position: FlashPosition.top,                 // Position flash at the top of the screen
      content: CustomText(
        msg,
        textAlign: TextAlign.center,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: AppColors.white), // White text for contrast
      ),
    );
  }
}
