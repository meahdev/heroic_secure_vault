import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_vault/core/constants/app_colors.dart';
import 'package:secure_vault/core/constants/app_strings.dart';
import 'package:secure_vault/core/constants/route_constants.dart';
import 'package:secure_vault/features/credential/domain/entities/credential_entity.dart';
import 'package:secure_vault/features/credential/presentation/bloc/credential_bloc.dart';
import 'package:secure_vault/shared/widgets/custom_text/custom_text.dart';

import '../../../../core/theme/theme_cubit.dart';
import '../../../../shared/dialogs/alert_view.dart';

class CredentialScreen extends StatefulWidget {
  const CredentialScreen({super.key});

  @override
  State<CredentialScreen> createState() => _CredentialScreenState();
}

class _CredentialScreenState extends State<CredentialScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CredentialBloc>().add(LoadCredentials());
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: CustomText(AppStrings.yourCredentials),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(RouteConstants.addUpdateCredential);
        },
        tooltip: 'Add Credential',
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<CredentialBloc, CredentialState>(
        builder: (context, state) {
          if (state is CredentialLoaded) {
            if (state.credentials.isEmpty) {
              return const Center(child: CustomText('No credentials found.'));
            }
            return ListView.builder(
              itemCount: state.credentials.length,
              padding: EdgeInsets.only(top: 10),
              itemBuilder: (context, index) {
                final credential = state.credentials[index];
                return InkWell(
                  onTap: () {
                    context.pushNamed(
                      RouteConstants.addUpdateCredential,
                      extra: {
                        'isEdit': true,
                        'credential': credential, // Pass the CredentialEntity
                      },
                    );
                  },
                  child: Card(
                    color: AppColors.blue,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            "${AppStrings.userName}: ${credential.username}",
                          ),
                          SizedBox(height: 3),
                          CustomText(
                            "${AppStrings.category}: ${credential.category.name}",
                          ),
                          SizedBox(height: 3),
                          CustomText(
                            "${AppStrings.site}: ${credential.siteName}",
                          ),
                          SizedBox(height: 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                "${AppStrings.password}: ${credential.password}",
                              ),
                              InkWell(onTap: () {
                                _showAlert(context, credential);
                              }, child: Icon(Icons.delete)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is CredentialLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CredentialError) {
            return Center(child: CustomText(state.message));
          }

          return const SizedBox(); // default empty view
        },
      ),
    );
  }

  _showAlert(BuildContext context, CredentialEntity credential) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertView(
          isCancelButton: true,
          title: AppStrings.delete,
          onPositiveTap: () {
            Navigator.pop(context);
            context.read<CredentialBloc>().add(
              DeleteCredentialEvent(credential.id),
            );
          },
          message: AppStrings.areYouSureWantToDelete,
          positiveLabel: AppStrings.ok,
        );
      },
    );
  }
}
