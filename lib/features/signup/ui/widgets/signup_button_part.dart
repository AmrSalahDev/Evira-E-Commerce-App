import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/routes/args/fill_profile_screen_args.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/signup/domain/entities/signup_entity.dart';
import 'package:evira_e_commerce/features/signup/ui/cubit/signup_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/text_field_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/text_field_state.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupButtonPart extends StatelessWidget {
  const SignupButtonPart({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.email,
    required this.password,
    required this.remember,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final String email;
  final String password;
  final bool remember;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      bloc: context.read<SignupCubit>(),
      listener: (context, state) {
        if (state is SignupSuccess) {
          context.push(AppPaths.fillProfile);
        } else if (state is SignupError) {
          getIt<ToastService>().showErrorToast(
            context: context,
            message: state.message,
          );
        }
      },
      listenWhen: (previous, current) => previous != current,
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        bool isLoading = state is SignupLoading;
        return BlocBuilder<TextFieldCubit, TextFieldState>(
          bloc: context.read<TextFieldCubit>(),
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            return CustomButton(
              isLoading: isLoading,
              onPressed: state is TextFieldsUpdated && !state.allFieldsFilled
                  ? null
                  : () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        await context.read<SignupCubit>().signup(
                          signupEntity: SignupEntity(
                            email: email,
                            password: password,
                          ),
                        );
                        // context.push(
                        //   AppPaths.fillProfile,
                        //   extra: FillProfileScreenArgs(
                        //     email: email,
                        //     password: password,
                        //   ),
                        // );
                      }
                    },
              backgroundColor:
                  state is TextFieldsUpdated && !state.allFieldsFilled
                  ? context.buttonInactiveColor
                  : context.buttonActiveColor,
              title: EviraLang.of(context).signUp,
              textColor: state is TextFieldsUpdated && !state.allFieldsFilled
                  ? context.textInactiveColor
                  : context.textActiveColor,
            );
          },
        );
      },
    );
  }
}
