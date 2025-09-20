import 'package:evira_e_commerce/core/constants/app_colors.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/onboarding/data/models/onboarding_model.dart';
import 'package:evira_e_commerce/features/onboarding/ui/widgets/next_button_part.dart';
import 'package:evira_e_commerce/features/onboarding/ui/widgets/page_view_part.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

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
            PageViewPart(pageController: pageController),
            SizedBox(height: 20.h),
            SmoothPageIndicator(
              controller: pageController,
              count: OnboardingModel.onboardingList.length,
              effect: ExpandingDotsEffect(
                dotWidth: 10.w,
                dotHeight: 10.h,
                activeDotColor: context.iconColor,
                dotColor: context.gray300,
              ),
            ),
            SizedBox(height: 35.h),
            NextButtonPart(pageController: pageController),
          ],
        ),
      ),
    );
  }
}
