
class PinRules {
  /// Returns `true` if the PIN is valid (not identical or sequential).
  static bool isValid(String pin) {
    if (pin.length < 4) return false;

    // All digits the same
    if (pin.split('').every((d) => d == pin[0])) return false;

    // Ascending sequence
    bool isAscending = true;
    for (int i = 0; i < pin.length - 1; i++) {
      if (int.parse(pin[i]) + 1 != int.parse(pin[i + 1])) {
        isAscending = false;
        break;
      }
    }
    if (isAscending) return false;

    // Descending sequence
    bool isDescending = true;
    for (int i = 0; i < pin.length - 1; i++) {
      if (int.parse(pin[i]) - 1 != int.parse(pin[i + 1])) {
        isDescending = false;
        break;
      }
    }
    if (isDescending) return false;

    return true;
  }
}
