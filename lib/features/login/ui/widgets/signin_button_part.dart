import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/cubits/text_field_cubit.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInButtonPart extends StatelessWidget {
  const SignInButtonPart({super.key, required GlobalKey<FormState> formKey})
    : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextFieldCubit, bool>(
      bloc: context.read<TextFieldCubit>(),
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return CustomButton(
          onPressed: state
              ? null
              : () {
                  _formKey.currentState?.validate();
                },
          backgroundColor: state
              ? context.buttonInactiveColor
              : context.buttonActiveColor,
          title: EviraLang.of(context).signIn,
          textColor: state
              ? context.textInactiveColor
              : context.textActiveColor,
        );
      },
    );
  }
}
