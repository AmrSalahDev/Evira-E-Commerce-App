import 'package:evira_e_commerce/core/constants/app_colors.dart';
import 'package:evira_e_commerce/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const CustomButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: double.infinity,
      height: 60.h,
      color: AppColors.black,
      textColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      child: Text(title, style: AppStyles.buttonTextStyle),
    );
  }
}
