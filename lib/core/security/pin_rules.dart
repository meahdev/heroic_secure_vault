class PinRules {
  /// Returns `true` if the PIN is valid.
  /// A valid PIN:
  /// - Has at least 4 digits
  /// - Is not composed of all identical digits (e.g., 1111)
  /// - Is not an ascending sequence (e.g., 1234)
  /// - Is not a descending sequence (e.g., 4321)
  static bool isValid(String pin) {
    // Reject PINs shorter than 4 digits
    if (pin.length < 4) return false;

    // Check if all digits are the same
    if (pin.split('').every((d) => d == pin[0])) return false;

    // Check for ascending sequence (e.g., 1234)
    bool isAscending = true;
    for (int i = 0; i < pin.length - 1; i++) {
      if (int.parse(pin[i]) + 1 != int.parse(pin[i + 1])) {
        isAscending = false;
        break;
      }
    }
    if (isAscending) return false;

    // Check for descending sequence (e.g., 4321)
    bool isDescending = true;
    for (int i = 0; i < pin.length - 1; i++) {
      if (int.parse(pin[i]) - 1 != int.parse(pin[i + 1])) {
        isDescending = false;
        break;
      }
    }
    if (isDescending) return false;

    // If none of the invalid patterns matched, return true
    return true;
  }
}
