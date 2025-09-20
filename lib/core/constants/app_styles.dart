import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

final class AppStyles {
  AppStyles._();

  // static final TextStyle onboardingTitleStyle = GoogleFonts.poppins(
  //   fontSize: 30.sp,
  //   fontWeight: FontWeight.w600,
  //   color: AppColors.black,
  // );

  // static final TextStyle largeTextStyle = GoogleFonts.poppins(
  //   fontSize: 40.sp,
  //   fontWeight: FontWeight.w700,
  //   color: AppColors.black,
  // );

  // static final TextStyle buttonTextStyle = GoogleFonts.poppins(
  //   fontSize: 16.sp,
  //   fontWeight: FontWeight.w500,
  //   color: AppColors.white,
  // );

  // static final TextStyle dividerTextStyle = GoogleFonts.poppins(
  //   color: Color(0xFF6d6d6d),
  //   fontSize: 16.sp,
  //   fontWeight: FontWeight.w500,
  // );

  static TextStyle onboardingTitleStyle(BuildContext context) =>
      GoogleFonts.poppins(
        fontSize: 30.sp,
        fontWeight: FontWeight.w600,
        color: context.textColor,
      );

  static TextStyle largeTextStyle(BuildContext context) => GoogleFonts.poppins(
    fontSize: 40.sp,
    fontWeight: FontWeight.w700,
    color: context.textColor,
  );

  static TextStyle buttonTextStyle(BuildContext context) => GoogleFonts.poppins(
    fontSize: 17.sp,
    fontWeight: FontWeight.w500,
    color: context.textColor,
  );

  static TextStyle dividerTextStyle(BuildContext context) =>
      GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).colorScheme.outline, // or `hintColor`
      );
}
