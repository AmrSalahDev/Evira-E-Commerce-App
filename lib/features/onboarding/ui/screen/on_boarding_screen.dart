import 'package:evira_e_commerce/core/constants/app_colors.dart';
import 'package:evira_e_commerce/core/constants/app_styles.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/features/onboarding/data/models/onboarding_model.dart';
import 'package:evira_e_commerce/features/onboarding/ui/cubit/onboarding_cubit.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_flutter_toolkit/core/extensions/context_extensions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
          child: const BodySection(),
        ),
      ),
    );
  }
}

class BodySection extends StatefulWidget {
  const BodySection({super.key});

  @override
  State<BodySection> createState() => _BodySectionState();
}

class _BodySectionState extends State<BodySection> {
  late final PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _PageViewPart(pageController: pageController),
            SizedBox(height: 20.h),
            SmoothPageIndicator(
              controller: pageController,
              count: OnboardingModel.onboardingList.length,
              effect: ExpandingDotsEffect(
                dotWidth: 10.w,
                dotHeight: 10.h,
                activeDotColor: AppColors.black,
                dotColor: Colors.grey.shade300,
              ),
            ),
            SizedBox(height: 35.h),
            _NextButtonPart(pageController: pageController),
          ],
        ),
      ),
    );
  }
}

class _NextButtonPart extends StatelessWidget {
  const _NextButtonPart({required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<OnboardingCubit, OnboardingState, int>(
      selector: (state) {
        return state is OnboardingPageState ? state.page : 0;
      },
      builder: (context, state) {
        return CustomButton(
          title: state == 2
              ? EviraLang.of(context).getStarted
              : EviraLang.of(context).next,
          onPressed: () async {
            await pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
        );
      },
    );
  }
}

class _PageViewPart extends StatelessWidget {
  const _PageViewPart({required this.pageController});

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
                style: AppStyles.onboardingTitleStyle,
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}
