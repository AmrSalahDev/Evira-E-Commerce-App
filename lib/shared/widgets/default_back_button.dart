import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DefaultBackButton extends StatelessWidget {
  const DefaultBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        iconSize: 30.h,
        color: context.iconColor,
        onPressed: () => context.pop(),
        // Add padding and constraints for better touch target
        constraints: BoxConstraints(minWidth: 48.w, minHeight: 48.h),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
