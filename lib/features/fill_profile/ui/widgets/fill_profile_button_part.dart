import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/fill_profile/domain/entities/fill_profile_entity.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/cubit/fill_profile_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/text_field_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/text_field_state.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FillProfileButton extends StatelessWidget {
  const FillProfileButton({
    super.key,
    required this.formKey,
    required this.onPressed,
  });

  final GlobalKey<FormState> formKey;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextFieldCubit, TextFieldState>(
      builder: (context, state) {
        final isEnabled = state is TextFieldsUpdated && state.allFieldsFilled;
        return CustomButton(
          title: EviraLang.of(context).continuee,
          onPressed: isEnabled
              ? () {
                  if (formKey.currentState?.validate() ?? false) {
                    onPressed();
                  }
                }
              : null,
          backgroundColor: isEnabled
              ? context.buttonActiveColor
              : context.buttonInactiveColor,
          textColor: isEnabled
              ? context.textActiveColor
              : context.textInactiveColor,
        );
      },
    );
  }
}
