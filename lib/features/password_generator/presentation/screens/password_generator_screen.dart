import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_vault/shared/widgets/custom_button/custom_button.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../shared/widgets/custom_text/custom_text.dart';
import '../../domain/entity/password_options.dart';
import '../blocs/password_generator_bloc.dart';

class PasswordGeneratorScreen extends StatefulWidget {
  const PasswordGeneratorScreen({super.key});

  @override
  State<PasswordGeneratorScreen> createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen> {
  double _length = 12;
  bool _includeNumbers = true;
  bool _includeSymbols = true;

  void _generatePassword() {
    final options = PasswordOptions(
      length: _length.toInt(),
      includeNumbers: _includeNumbers,
      includeSymbols: _includeSymbols,
    );

    context.read<PasswordGeneratorBloc>().add(GeneratePasswordEvent(options));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: CustomText(AppStrings.passwordGenerator),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Slider for password length
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText('Length'),
                CustomText('${_length.toInt()}'),
              ],
            ),
            Slider(
              value: _length,
              min: 6,
              max: 32,
              divisions: 26,
              label: _length.toInt().toString(),
              onChanged: (value) {
                setState(() => _length = value);
              },
            ),

            // Checkbox for numbers
            CheckboxListTile(
              value: _includeNumbers,
              onChanged: (value) {
                setState(() => _includeNumbers = value ?? true);
              },
              title: const CustomText(AppStrings.includeNumbers),
            ),

            // Checkbox for symbols
            CheckboxListTile(
              value: _includeSymbols,
              onChanged: (value) {
                setState(() => _includeSymbols = value ?? true);
              },
              title: const CustomText(AppStrings.includeSymbols),
            ),

            const SizedBox(height: 16),

            // Generate button
            CustomButton(
              onPressed: _generatePassword,
              text: AppStrings.generatePassword,
            ),

            const SizedBox(height: 24),

            // Result display
            BlocBuilder<PasswordGeneratorBloc, PasswordGeneratorState>(
              builder: (context, state) {
                if (state is PasswordLoading) {
                  return const CircularProgressIndicator();
                } else if (state is PasswordGenerated) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SelectableText(
                        '🔑 ${state.password}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        '${AppStrings.strength}: ${state.strength}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: _getStrengthColor(state.strength),
                        ),
                      ),
                    ],
                  );
                }
                return const CustomText(
                  "🧰 ${AppStrings.useThePageToGenerateAPassword}",
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getStrengthColor(String strength) {
    switch (strength.toLowerCase()) {
      case 'weak':
        return Colors.red;
      case 'fair':
        return Colors.orange;
      case 'good':
        return Colors.blue;
      case 'strong':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
