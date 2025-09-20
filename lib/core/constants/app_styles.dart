import 'package:evira_e_commerce/core/constants/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

final class AppStyles {
  AppStyles._();

  static final TextStyle onboardingTitleStyle = GoogleFonts.poppins(
    fontSize: 30.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static final TextStyle buttonTextStyle = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );
}
