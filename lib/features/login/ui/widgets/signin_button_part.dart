import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/cubits/text_field_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/text_field_state.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInButtonPart extends StatelessWidget {
  const SignInButtonPart({super.key, required GlobalKey<FormState> formKey})
    : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextFieldCubit, TextFieldState>(
      bloc: context.read<TextFieldCubit>(),
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        bool isActive = state is TextFieldsUpdated && state.allFieldsFilled;
        return CustomButton(
          onPressed: isActive
              ? () {
                  _formKey.currentState?.validate();
                }
              : null,
          backgroundColor: isActive
              ? context.buttonActiveColor
              : context.buttonInactiveColor,
          title: EviraLang.of(context).signIn,
          textColor: isActive
              ? context.textActiveColor
              : context.textInactiveColor,
        );
      },
    );
  }
}
