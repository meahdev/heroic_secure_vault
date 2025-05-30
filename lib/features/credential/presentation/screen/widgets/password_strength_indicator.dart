
import 'package:flutter/material.dart';

import '../../../../../core/security/password_strength.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final PasswordStrength strength;

  const PasswordStrengthIndicator({super.key, required this.strength});

  @override
  Widget build(BuildContext context) {
    String label;
    double value;
    Color color;

    switch (strength) {
      case PasswordStrength.weak:
        label = 'Weak';
        value = 0.33;
        color = Colors.red;
        break;
      case PasswordStrength.medium:
        label = 'Medium';
        value = 0.66;
        color = Colors.orange;
        break;
      case PasswordStrength.strong:
        label = 'Strong';
        value = 1.0;
        color = Colors.green;
        break;
      default:
        return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: value,
          minHeight: 6,
          backgroundColor: Colors.grey[300],
          color: color,
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: color)),
      ],
    );
  }
}
