import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class GoSettingsDialog {
  GoSettingsDialog._();

  static FutureOr<void> show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: context.containerColor,
        titleTextStyle: GoogleFonts.urbanist(
          fontSize: 27.sp,
          fontWeight: FontWeight.w500,
          color: context.textColor,
        ),
        contentTextStyle: GoogleFonts.urbanist(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: context.textHintColor,
        ),
        title: Text(EviraLang.of(context).biometricAreNotSetUpTitle),
        content: Text(EviraLang.of(context).setUpBiometricDescription),
        actions: [
          TextButton(
            child: Text(
              EviraLang.of(context).cancel,
              style: GoogleFonts.urbanist(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: context.textColor,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text(
              EviraLang.of(context).settings,
              style: GoogleFonts.urbanist(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: context.textColor,
              ),
            ),

            onPressed: () async => await AppSettings.openAppSettings(
              type: AppSettingsType.security,
            ),
          ),
        ],
      ),
    );
  }
}
