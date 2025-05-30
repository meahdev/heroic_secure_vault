import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_vault/features/credential/presentation/bloc/credential_bloc.dart';
import 'package:secure_vault/features/credential/presentation/screen/widgets/category_dropdown.dart';
import 'package:secure_vault/features/credential/presentation/screen/widgets/password_strength_indicator.dart';
import 'package:secure_vault/shared/widgets/custom_button/custom_button.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/category_constants.dart';
import '../../../../core/inactive/inactive_cubit.dart';
import '../../../../core/security/password_strength.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../shared/widgets/custom_text/custom_text.dart';
import '../../../../shared/widgets/custom_text_field/custom_text_field.dart';
import '../../../../shared/widgets/custom_text_field/text_field_config.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/credential_entity.dart';

class AddUpdateCredentialScreen extends StatefulWidget {
  const AddUpdateCredentialScreen({
    super.key,
    required this.isEdit,
    this.credential,
  });

  final bool isEdit;
  final CredentialEntity? credential;

  @override
  State<AddUpdateCredentialScreen> createState() =>
      _AddUpdateCredentialScreenState();
}

class _AddUpdateCredentialScreenState extends State<AddUpdateCredentialScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _siteController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _userNameFocus = FocusNode();
  final FocusNode _siteFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  PasswordStrength _passwordStrength = PasswordStrength.none;
  Category? _selectedCategory;
  Timer? _clearClipboardTimer;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.credential != null) {
      _userNameController.text = widget.credential!.username;
      _siteController.text = widget.credential!.siteName;
      _passwordController.text = widget.credential!.password;
      _selectedCategory = widget.credential!.category;
    } else {
      _selectedCategory = categories[0];
    }
    _passwordController.addListener(_evaluatePasswordStrength);
  }


  void _evaluatePasswordStrength() {
    final strength = calculatePasswordStrength(_passwordController.text);
    setState(() {
      _passwordStrength = strength;
    });
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _siteController.dispose();
    _passwordController.dispose();
    _userNameFocus.dispose();
    _siteFocus.dispose();
    _passwordFocus.dispose();
    _clearClipboardTimer?.cancel();
    super.dispose();
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.fieldRequired;
    }
    return null;
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      final credential = CredentialEntity(
        id: widget.isEdit ? widget.credential!.id : DateTime.now().toString(),
        siteName: _siteController.text.trim(),
        username: _userNameController.text.trim(),
        password: _passwordController.text.trim(),
        category: _selectedCategory!,
        lastModified: DateTime.now(),
      );

      if (widget.isEdit) {
        context.read<CredentialBloc>().add(UpdateCredentialEvent(credential));
      } else {
        context.read<CredentialBloc>().add(AddCredentialEvent(credential));
      }

      context.pop(); // Go back after save/update
    }
  }

  void _copy() {
    final password = _passwordController.text;

    // Copy password to clipboard
    Clipboard.setData(ClipboardData(text: password));

    // Show confirmation SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password copied to clipboard')),
    );

    // Cancel previous timer if any
    _clearClipboardTimer?.cancel();

    // Start a timer to clear clipboard after 30 seconds
    _clearClipboardTimer = Timer(const Duration(seconds: 30), () async {
      debugPrint('Attempting to clear clipboard...');
      await Clipboard.setData(const ClipboardData(text: ''));

      // Verify if clipboard is cleared
      final result = await Clipboard.getData('text/plain');
      if (result?.text?.isEmpty ?? true) {
        debugPrint('Clipboard successfully cleared.');
      } else {
        debugPrint('Clipboard NOT cleared. Found: ${result?.text}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: CustomText(
          widget.isEdit
              ? AppStrings.updateCredentials
              : AppStrings.addCredentials,
        ),
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomText(
                AppStrings.category,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              CategoryDropdown(
                selectedCategory: _selectedCategory,
                onChanged: (cat) {
                  setState(() {
                    _selectedCategory = cat;
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomText(
                AppStrings.userName,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                config: TextFieldConfig(
                  controller: _userNameController,
                  focusNode: _userNameFocus,
                  hintText: AppStrings.enterUsername,
                  validator: _requiredValidator,
                  isHasBorder: true,
                  textInputAction: TextInputAction.next,
                  onChanged: (val){
                    context.read<InactivityCubit>().userActivity();
                  },
                  onSubmitted:
                      (_) => FocusScope.of(context).requestFocus(_siteFocus),
                ),
              ),
              const SizedBox(height: 20),

              CustomText(
                AppStrings.siteName,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                config: TextFieldConfig(
                  controller: _siteController,
                  focusNode: _siteFocus,
                  hintText: AppStrings.enterSiteName,
                  validator: _requiredValidator,
                  isHasBorder: true,
                  isOutLineInputBorder: true,
                  textInputAction: TextInputAction.next,
                  onChanged: (val){
                    context.read<InactivityCubit>().userActivity();
                  },
                  onSubmitted:
                      (_) =>
                          FocusScope.of(context).requestFocus(_passwordFocus),
                ),
              ),
              const SizedBox(height: 20),

              CustomText(
                AppStrings.password,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                config: TextFieldConfig(
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  hintText: AppStrings.enterPassword,
                  maxLines: 1,
                  validator: _requiredValidator,
                  isHasBorder: true,
                  isOutLineInputBorder: true,
                  onChanged: (val){
                    context.read<InactivityCubit>().userActivity();
                  },
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _onSubmit(),
                ),
              ),
              const SizedBox(height: 12),

              // Password strength indicator
              PasswordStrengthIndicator(strength: _passwordStrength),
              const SizedBox(height: 30),
              CustomButton(
                onPressed: _onSubmit,
                text: widget.isEdit ? AppStrings.update : AppStrings.save,
              ),
              if (widget.isEdit) ...[
                const SizedBox(height: 30),
                CustomButton(
                  onPressed: _copy,
                  text: AppStrings.copyPasswordToClipBoard,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
