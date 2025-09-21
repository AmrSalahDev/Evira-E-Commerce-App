import 'package:evira_e_commerce/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final Color backgroundColor;
  final Color textColor;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed ?? () {},
      minWidth: double.infinity,
      height: 65.h,
      color: backgroundColor,
      textColor: textColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(65.h / 2), // 65.h / 2 = 32.5
      ),
      child: Text(
        title,
        style: AppStyles.buttonTextStyle(context).copyWith(color: textColor),
      ),
    );
  }
}
