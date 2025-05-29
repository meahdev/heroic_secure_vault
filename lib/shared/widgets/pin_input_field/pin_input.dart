import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

import '../../../core/utils/no_paste_helper.dart';

/// A custom PIN input widget using the `Pinput` package.
///
/// Displays a 4-digit PIN input with obscured characters and disables
/// paste functionality for better security.
class PinInput extends StatelessWidget {
  /// Called when the user completes inputting the PIN.
  final void Function(String) onCompleted;

  /// Controller for the PIN input field.
  final TextEditingController pinController;

  /// Focus node to manage focus on the PIN input.
  final FocusNode pinFocusNode;

  /// Creates a [PinInput] widget.
  const PinInput({
    super.key,
    required this.onCompleted,
    required this.pinController,
    required this.pinFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    // Define the default PIN theme (box size, text style, and border)
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 60,
      textStyle: TextStyle(fontSize: 20, color: Theme.of(context).textTheme.bodyLarge!.color ?? Colors.black),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Pinput(
      controller: pinController,
      // focusNode: pinFocusNode, // Uncomment if you want to manage focus explicitly
      length: 4, // Number of PIN digits
      obscureText: true, // Hide digits for privacy
      toolbarEnabled: false, // Disable toolbar (cut/copy/paste)
      contextMenuBuilder: (context, editableTextState) {
        // Disable context menu completely
        return const SizedBox.shrink();
      },
      obscuringCharacter: '●', // Character used to hide the input
      defaultPinTheme: defaultPinTheme,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // Only allow digits
        LengthLimitingTextInputFormatter(4), // Max 4 digits
        NoPasteFormatter(4), // Custom formatter to prevent pasting (from your utils)
      ],
      onCompleted: onCompleted, // Callback when input is complete
      autofillHints: [], // Disable autofill hints for security
      autofocus: true, // Automatically focus the input field
      enableSuggestions: false, // Disable suggestions
      keyboardType: TextInputType.number, // Numeric keyboard
      textInputAction: TextInputAction.done, // Keyboard done action
      // cursor: SizedBox.shrink(), // Uncomment to hide cursor if desired
    );
  }
}
