import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';

final class OnboardingModel {
  final String title;
  final String image;

  OnboardingModel({required this.title, required this.image});

  static final List<OnboardingModel> onboardingList = [
    OnboardingModel(
      title: EviraLang.current.onboarding_title_1,
      image: Assets.images.onboarding.onboardingLight1.path,
    ),
    OnboardingModel(
      title: EviraLang.current.onboarding_title_2,
      image: Assets.images.onboarding.onboardingLight2.path,
    ),
    OnboardingModel(
      title: EviraLang.current.onboarding_title_3,
      image: Assets.images.onboarding.onboardingLight3.path,
    ),
  ];
}
