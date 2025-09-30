import 'package:evira_e_commerce/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final bool isLoading;
  final Widget? loadingWidget;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    this.isLoading = false,
    this.loadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: isLoading ? () {} : onPressed ?? () {},
      minWidth: double.infinity,
      height: 65.h,
      elevation: 0,
      color: backgroundColor,
      textColor: textColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(65.h / 2), // 65.h / 2 = 32.5
      ),
      child: isLoading && loadingWidget == null
          ? LoadingAnimationWidget.threeRotatingDots(
              color: textColor,
              size: 50.h,
            )
          : isLoading && loadingWidget != null
          ? loadingWidget
          : Text(
              title,
              style: AppStyles.buttonTextStyle(
                context,
              ).copyWith(color: textColor),
            ),
    );
  }
}
