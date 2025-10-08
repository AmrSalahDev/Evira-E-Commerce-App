import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeActionMenuPart extends StatelessWidget {
  const HomeActionMenuPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          iconSize: 32.h,
          color: context.iconColor,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.favorite_border_outlined),
          iconSize: 32.h,
          color: context.iconColor,
          onPressed: () {},
        ),
      ],
    );
  }
}
