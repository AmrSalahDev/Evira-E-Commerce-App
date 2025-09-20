import 'package:evira_e_commerce/core/constants/app_styles.dart';
import 'package:evira_e_commerce/features/onboarding/data/models/onboarding_model.dart';
import 'package:evira_e_commerce/features/onboarding/ui/cubit/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_flutter_toolkit/core/extensions/context_extensions.dart';

class PageViewPart extends StatelessWidget {
  const PageViewPart({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * 0.7,
      width: context.screenWidth * 0.8,
      child: PageView.builder(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: OnboardingModel.onboardingList.length,
        clipBehavior: Clip.none,
        onPageChanged: (page) => context.read<OnboardingCubit>().next(page),
        itemBuilder: (context, index) {
          final onboarding = OnboardingModel.onboardingList[index];
          return Column(
            children: [
              Image.asset(
                onboarding.image,
                fit: BoxFit.contain,
                width: context.screenWidth * 0.8,
                height: context.screenHeight * 0.5,
              ),
              SizedBox(height: 20.h),
              Text(
                onboarding.title,
                style: AppStyles.onboardingTitleStyle(context),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}
