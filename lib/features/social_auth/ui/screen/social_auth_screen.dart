import 'package:evira_e_commerce/core/constants/app_styles.dart';
import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/social_auth/ui/widgets/dont_have_account_part.dart';
import 'package:evira_e_commerce/shared/cubits/app_flow_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/social_auth_cubit.dart';
import 'package:evira_e_commerce/shared/mixins/stateless_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:evira_e_commerce/shared/widgets/custom_sign_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_toolkit/core/extensions/context_extensions.dart';
import 'package:my_flutter_toolkit/ui/widgets/custom_divider.dart';

class SocialAuthScreen extends StatelessWidget with StatelessScreenMixin {
  const SocialAuthScreen({super.key});

  @override
  bool get showAppBar => false;

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
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
            BlocConsumer<SocialAuthCubit, SocialAuthState>(
              listener: (context, state) {
                if (state is FacebookAuthSuccess) {
                  context.read<AppFlowCubit>().checkUserState();
                } else if (state is FacebookAuthFailure) {
                  getIt<ToastService>().showErrorToast(
                    message: state.message,
                    context: context,
                  );
                }
              },
              builder: (context, state) {
                bool isLoading = state is FacebookAuthLoading;
                return CustomSignButton(
                  isLoading: isLoading,
                  title: EviraLang.of(context).continueWithFacebook,
                  icon: Assets.icons.facebook.svg(width: 30.w, height: 30.h),

                  onPressed: () async {
                    await context.read<SocialAuthCubit>().signInWithFacebook();
                  },
                );
              },
            ),
            SizedBox(height: 20.h),
            BlocConsumer<SocialAuthCubit, SocialAuthState>(
              listener: (context, state) {
                if (state is GoogleAuthSuccess) {
                  context.read<AppFlowCubit>().checkUserState();
                } else if (state is GoogleAuthFailure) {
                  getIt<ToastService>().showErrorToast(
                    message: state.message,
                    context: context,
                  );
                }
              },
              builder: (context, state) {
                bool isLoading = state is GoogleAuthLoading;
                return CustomSignButton(
                  isLoading: isLoading,
                  title: EviraLang.of(context).continueWithGoogle,
                  icon: Assets.icons.google.svg(width: 30.w, height: 30.h),
                  onPressed: () async {
                    await context.read<SocialAuthCubit>().signInWithGoogle();
                  },
                );
              },
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
              onPressed: () {
                getIt<ToastService>().showWarningToast(
                  message: EviraLang.of(context).comingSoon,
                  context: context,
                );
              },
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
        ),
      ),
    );
  }
}
