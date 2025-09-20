import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/onboarding/ui/cubit/onboarding_cubit.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NextButtonPart extends StatelessWidget {
  const NextButtonPart({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<OnboardingCubit, OnboardingState, int>(
      selector: (state) {
        return state is OnboardingPageState ? state.page : 0;
      },
      builder: (context, state) {
        return CustomButton(
          backgroundColor: context.buttonColor,
          textColor: context.buttonTextColor,
          title: state == 2
              ? EviraLang.of(context).getStarted
              : EviraLang.of(context).next,
          onPressed: () async {
            if (pageController.page == 2) {
              context.push(AppPaths.auth);
            } else {
              await pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            }
          },
        );
      },
    );
  }
}
