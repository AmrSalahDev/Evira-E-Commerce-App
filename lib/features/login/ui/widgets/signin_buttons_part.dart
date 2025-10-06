import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/cubits/app_flow_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/social_auth_cubit.dart';
import 'package:evira_e_commerce/shared/widgets/custom_sign_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInButtonsPart extends StatelessWidget {
  const SignInButtonsPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
              fullWidth: false,
              icon: Assets.icons.facebook.svg(width: 30.w, height: 30.h),
              onPressed: () {
                context.read<SocialAuthCubit>().signInWithFacebook();
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
              icon: Assets.icons.google.svg(width: 30.w, height: 30.h),
              onPressed: () {
                context.read<SocialAuthCubit>().signInWithGoogle();
              },
              fullWidth: false,
            );
          },
        ),
        SizedBox(height: 20.h),
        CustomSignButton(
          fullWidth: false,
          icon: Assets.icons.apple.svg(
            width: 30.w,
            height: 30.h,
            colorFilter: ColorFilter.mode(context.iconColor, BlendMode.srcIn),
          ),
          onPressed: () {
            getIt<ToastService>().showWarningToast(
              context: context,
              message: EviraLang.of(context).comingSoon,
            );
          },
        ),
      ],
    );
  }
}
