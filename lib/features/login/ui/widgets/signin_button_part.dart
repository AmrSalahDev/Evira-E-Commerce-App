import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/login/ui/cubit/login_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/text_field_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/text_field_state.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInButtonPart extends StatelessWidget {
  final Function() onSignInPressed;
  const SignInButtonPart({super.key, required this.onSignInPressed});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          getIt<ToastService>().showErrorToast(
            context: context,
            message: state.message,
          );
        } else if (state is LoginSuccess) {
          context.push(AppPaths.home);
        }
      },
      builder: (context, state) {
        bool isLoading = state is LoginLoading;
        return BlocBuilder<TextFieldCubit, TextFieldState>(
          bloc: context.read<TextFieldCubit>(),
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            bool isActive = state is TextFieldsUpdated && state.allFieldsFilled;
            return CustomButton(
              isLoading: isLoading,
              onPressed: isActive
                  ? () {
                      onSignInPressed();
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
      },
    );
  }
}
