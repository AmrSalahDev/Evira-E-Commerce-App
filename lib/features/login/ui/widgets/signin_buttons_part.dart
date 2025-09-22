import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/widgets/custom_sign_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInButtonsPart extends StatelessWidget {
  const SignInButtonsPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomSignButton(
          fullWidth: false,
          icon: Assets.icons.facebook.svg(width: 30.w, height: 30.h),
          onPressed: () {},
        ),
        SizedBox(height: 20.h),
        CustomSignButton(
          icon: Assets.icons.google.svg(width: 30.w, height: 30.h),
          onPressed: () {},
          fullWidth: false,
        ),
        SizedBox(height: 20.h),
        CustomSignButton(
          fullWidth: false,
          icon: Assets.icons.apple.svg(
            width: 30.w,
            height: 30.h,
            colorFilter: ColorFilter.mode(context.iconColor, BlendMode.srcIn),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
