import 'package:evira_e_commerce/core/constants/app_styles.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/forget_password/ui/widgets/forgot_password_method_box.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_toolkit/core/extensions/context_extensions.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with StatefulScreenMixin {
  @override
  String get title => EviraLang.current.forgetPasswordTitle;

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.h),
            context.isDark
                ? Assets.images.forgotPasswordLogoDark.image(
                    width: context.screenWidth * 0.8,
                    height: context.screenHeight * 0.3,
                    fit: BoxFit.contain,
                  )
                : Assets.images.forgotPasswordLogoLight.image(
                    width: context.screenWidth * 0.8,
                    height: context.screenHeight * 0.3,
                    fit: BoxFit.contain,
                  ),
            SizedBox(height: 30.h),
            Text(
              EviraLang.current.forgetPasswordDescription,
              style: AppStyles.smallTextStyle18(context),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.h),
            const ForgotPasswordMethodBox(),
            SizedBox(height: 30.h),
            CustomButton(
              title: EviraLang.of(context).continuee,
              onPressed: () {
                context.push(AppPaths.forgotPasswordVerify);
              },
              backgroundColor: context.buttonColor,
              textColor: context.buttonTextColor,
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
