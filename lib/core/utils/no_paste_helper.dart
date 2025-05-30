import 'package:flutter/services.dart';

/// A [TextInputFormatter] that prevents pasting and restricts input length.
///
/// It ensures that only one character is added at a time and the total length
/// does not exceed the specified [length], effectively blocking paste actions.
class NoPasteFormatter extends TextInputFormatter {
  final int length;

  NoPasteFormatter(this.length);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Reject if multiple characters are added at once (likely a paste)
    // or if new input exceeds the allowed length.
    if (newValue.text.length - oldValue.text.length > 1 ||
        newValue.text.length > length) {
      return oldValue;
    }
    return newValue;
  }
}
