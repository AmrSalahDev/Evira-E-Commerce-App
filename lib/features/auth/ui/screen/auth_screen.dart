import 'package:evira_e_commerce/core/constants/app_styles.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/cubits/theme_cubit.dart';
import 'package:evira_e_commerce/shared/widgets/base_stateful_screen.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:evira_e_commerce/shared/widgets/custom_sign_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/core/extensions/context_extensions.dart';
import 'package:my_flutter_toolkit/ui/widgets/custom_divider.dart';

class AuthScreen extends BaseStatefulScreen {
  const AuthScreen({super.key});

  @override
  BaseStatefulScreenState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends BaseStatefulScreenState<AuthScreen> {
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SafeArea(
  //       child: Padding(
  //         padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: const [HeaderSection(), BodySection()],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget buildBody(BuildContext context) {
    return const BodySection();
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      alignment: Alignment.topLeft,
      iconSize: 30.h,
      color: context.iconColor,
      onPressed: () {
        context.pop();
      },
    );
  }
}

class BodySection extends StatelessWidget {
  const BodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
          children: [
            Image.asset(
              Theme.of(context).brightness == Brightness.dark
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
                colorFilter: ColorFilter.mode(
                  context.iconColor,
                  BlendMode.srcIn,
                ),
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
                await context.read<ThemeCubit>().toggleTheme();
              },
            ),
            SizedBox(height: 25.h),
            Text.rich(
              TextSpan(
                text: EviraLang.of(context).dontHaveAccount,
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  color: Color(0xFFbababa),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '  ${EviraLang.of(context).signUp}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: context.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => context.push(AppPaths.signUp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
