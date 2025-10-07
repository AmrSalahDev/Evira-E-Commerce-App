import 'package:evira_e_commerce/core/constants/app_styles.dart';
import 'package:evira_e_commerce/core/services/internet_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final Function()? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final bool isLoading;
  final bool handleNoInternet;
  final Widget? loadingWidget;
  //final Future<bool> Function()? onNoInternetMessagePressed;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    this.isLoading = false,
    this.loadingWidget,
    //this.onNoInternetMessagePressed,
    this.handleNoInternet = false,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _checking = false; // local state for internet check

  Future<void> _handlePress() async {
    if (_checking || widget.isLoading) return;

    setState(() => _checking = true);

    try {
      //final allowed = await widget.onNoInternetMessagePressed?.call();
      if (widget.handleNoInternet) {
        final allowed = await InternetService.handleNoInternetMessage(context);

        if (allowed) {
          widget.onPressed?.call();
        }
      } else {
        widget.onPressed?.call();
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
      minWidth: double.infinity,
      height: 65.h,
      elevation: 0,
      disabledColor: widget.backgroundColor,
      disabledTextColor: widget.textColor,
      color: widget.backgroundColor,
      textColor: widget.textColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(65.h / 2), // 65.h / 2 = 32.5
      ),
      child: isBusy && widget.loadingWidget == null
          ? LoadingAnimationWidget.threeRotatingDots(
              color: widget.textColor,
              size: 50.h,
            )
          : widget.isLoading && widget.loadingWidget != null
          ? widget.loadingWidget
          : Text(
              widget.title,
              style: AppStyles.buttonTextStyle(
                context,
              ).copyWith(color: widget.textColor),
            ),
    );
  }
}
