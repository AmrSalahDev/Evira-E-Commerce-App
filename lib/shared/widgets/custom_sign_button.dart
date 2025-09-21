import 'package:evira_e_commerce/core/constants/app_styles.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomSignButton extends StatelessWidget {
  final Widget icon;
  final String? title;
  final bool fullWidth;
  final VoidCallback onPressed;
  final bool isLoading;

  const CustomSignButton({
    super.key,
    this.title,
    required this.onPressed,
    this.isLoading = false,
    this.fullWidth = true,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: isLoading ? null : onPressed,
      minWidth: fullWidth ? double.infinity : 100.w,
      height: 70.h,
      color: context.containerColor,
      elevation: 0,
      splashColor: Colors.transparent,
      textColor: context.textColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
        side: BorderSide(color: context.containerBorderColor),
      ),
      child: isLoading
          ? LoadingAnimationWidget.threeRotatingDots(
              color: context.iconColor,
              size: 50.h,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                title == null ? const SizedBox() : SizedBox(width: 15.w),
                title == null
                    ? const SizedBox()
                    : Text(
                        title ?? '',
                        style: AppStyles.buttonTextStyle(context),
                      ),
              ],
            ),
    );
  }
}
