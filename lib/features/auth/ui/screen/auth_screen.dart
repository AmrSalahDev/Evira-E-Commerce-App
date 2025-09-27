import 'package:evira_e_commerce/core/constants/app_styles.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/auth/ui/widgets/dont_have_account_part.dart';
import 'package:evira_e_commerce/shared/cubits/theme_cubit.dart';
import 'package:evira_e_commerce/shared/mixins/stateless_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:evira_e_commerce/shared/widgets/custom_sign_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_toolkit/core/extensions/context_extensions.dart';
import 'package:my_flutter_toolkit/ui/widgets/custom_divider.dart';

class AuthScreen extends StatelessWidget with StatelessScreenMixin {
  const AuthScreen({super.key});

  @override
  bool get showAppBar => false;

  @override
  Widget buildBody(BuildContext context) {
    return BodySection();
  }
}

class BodySection extends StatelessWidget {
  const BodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: _BodySection(),
      ),
    );
  }
}

class _BodySection extends StatelessWidget {
  const _BodySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30.h),
        Image.asset(
          context.isDark
              ? Assets.images.letsYouInDark.path
              : Assets.images.letsYouInLight.path,
          width: context.screenWidth * 0.75,
          height: context.screenHeight * 0.25,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 30.h),
        Text(
          EviraLang.of(context).letsYouIn,
          style: AppStyles.largeTextStyle(context),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 30.h),
        CustomSignButton(
          title: EviraLang.of(context).continueWithFacebook,
          icon: Assets.icons.facebook.svg(width: 30.w, height: 30.h),
          onPressed: () {},
        ),
        SizedBox(height: 20.h),
        CustomSignButton(
          title: EviraLang.of(context).continueWithGoogle,
          icon: Assets.icons.google.svg(width: 30.w, height: 30.h),
          onPressed: () {},
        ),
        SizedBox(height: 20.h),
        CustomSignButton(
          title: EviraLang.of(context).continueWithApple,
          icon: Assets.icons.apple.svg(
            width: 30.w,
            height: 30.h,
            colorFilter: ColorFilter.mode(context.iconColor, BlendMode.srcIn),
          ),
          onPressed: () {},
        ),
        SizedBox(height: 30.h),
        CustomDivider(
          title: EviraLang.of(context).or.toUpperCase(),
          color: context.dividerColor,
          textStyle: AppStyles.dividerTextStyle(context),
        ),
        SizedBox(height: 30.h),
        CustomButton(
          title: EviraLang.of(context).signInWithPassword,
          backgroundColor: context.buttonColor,
          textColor: context.buttonTextColor,
          onPressed: () async {
            context.push(AppPaths.login);
          },
        ),
        SizedBox(height: 25.h),
        DontHaveAccountPart(),
      ],
    );
  }
}
