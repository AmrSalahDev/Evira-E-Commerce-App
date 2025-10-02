import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
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
    return BlocConsumer<FillProfileCubit, FillProfileState>(
      buildWhen: (previous, current) => previous != current,
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is FillProfileError) {
          getIt<ToastService>().showErrorToast(
            context: context,
            message: state.message,
          );
        } else if (state is FillProfileSuccess) {
          print('fill profile success');
        }
      },
      builder: (context, state) {
        final isLoading = state is FillProfileLoading;
        return BlocBuilder<TextFieldCubit, TextFieldState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            final isEnabled =
                state is TextFieldsUpdated && state.allFieldsFilled;
            return CustomButton(
              isLoading: isLoading,
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
      },
    );
  }
}
