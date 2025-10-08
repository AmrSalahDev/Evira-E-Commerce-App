import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SeeAllWidgetPart extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const SeeAllWidgetPart({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.urbanist(
            fontSize: 23.sp,
            color: context.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onTap,
          child: Text(
            EviraLang.of(context).seeAll,
            style: GoogleFonts.urbanist(
              fontSize: 18.sp,
              color: context.textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
