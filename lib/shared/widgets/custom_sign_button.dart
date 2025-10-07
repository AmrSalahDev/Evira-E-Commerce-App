import 'package:evira_e_commerce/core/constants/app_styles.dart';
import 'package:evira_e_commerce/core/services/internet_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomSignButton extends StatefulWidget {
  final Widget icon;
  final String? title;
  final bool fullWidth;
  final VoidCallback onPressed;
  final bool handleNoInternet;
  final bool isLoading;
  //final Future<bool> Function()? onNoInternetMessagePressed;

  const CustomSignButton({
    super.key,
    this.title,
    required this.onPressed,
    this.isLoading = false,
    this.fullWidth = true,
    required this.icon,
    //this.onNoInternetMessagePressed,
    this.handleNoInternet = true,
  });

  @override
  State<CustomSignButton> createState() => _CustomSignButtonState();
}

class _CustomSignButtonState extends State<CustomSignButton> {
  bool _checking = false; // local state for internet check

  Future<void> _handlePress() async {
    if (_checking || widget.isLoading) return;

    setState(() => _checking = true);

    try {
      //final allowed = await widget.onNoInternetMessagePressed?.call();
      if (widget.handleNoInternet) {
        final allowed = await InternetService.handleNoInternetMessage(context);

        if (allowed) {
          widget.onPressed.call();
        }
      } else {
        widget.onPressed.call();
      }
    } finally {
      if (mounted) {
        setState(() => _checking = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isBusy = widget.isLoading || _checking;

    return MaterialButton(
      onPressed: isBusy ? null : _handlePress,
      minWidth: widget.fullWidth ? double.infinity : 100.w,
      height: 70.h,
      color: context.containerColor,
      elevation: 0,
      splashColor: Colors.transparent,
      textColor: context.textColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
        side: BorderSide(color: context.containerBorderColor),
      ),
      child: isBusy
          ? LoadingAnimationWidget.threeRotatingDots(
              color: context.iconColor,
              size: 50.h,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.icon,
                if (widget.title != null) SizedBox(width: 15.w),
                if (widget.title != null)
                  Text(
                    widget.title!,
                    style: AppStyles.buttonTextStyle(context),
                  ),
              ],
            ),
    );
  }
}
