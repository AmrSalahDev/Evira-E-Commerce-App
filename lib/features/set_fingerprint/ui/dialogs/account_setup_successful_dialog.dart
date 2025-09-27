import 'dart:async';

import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_flutter_toolkit/core/extensions/context_extensions.dart';

class AccountSetupSuccessfulDialog {
  AccountSetupSuccessfulDialog._();

  static FutureOr<void> show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 35.w),
        backgroundColor: context.containerColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            context.isDark
                ? Assets.images.accountSetupSuccessfulLogoDark.image(
                    height: context.screenHeight * 0.3,
                    width: context.screenWidth * 0.5,
                  )
                : Assets.images.accountSetupSuccessfulLogoLight.image(
                    height: context.screenHeight * 0.3,
                    width: context.screenWidth * 0.5,
                  ),

            Text(
              EviraLang.of(context).congratulations,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: context.textColor,

                fontSize: 25.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 25.h),
            Text(
              EviraLang.of(context).accountIsReady,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: context.textColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 30.h),
            LoadingAnimationWidget.hexagonDots(
              color: context.iconColor,
              size: 60.h,
            ),
          ],
        ),
      ),
    );
  }
}
