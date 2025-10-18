import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/core/extensions/context_extensions.dart';

class NotFoundProductsPart extends StatelessWidget {
  final String keyword;
  const NotFoundProductsPart({super.key, required this.keyword});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * 0.70,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          context.isDark
              ? Assets.images.searchResultNotFoundLogoDark.image(
                  width: context.screenWidth * 0.8,
                  height: context.screenHeight * 0.3,
                  fit: BoxFit.contain,
                )
              : Assets.images.searchResultNotFoundLight.image(
                  width: context.screenWidth * 0.8,
                  height: context.screenHeight * 0.3,
                  fit: BoxFit.contain,
                ),
          SizedBox(height: 30.h),
          Text(
            EviraLang.of(context).notFound,
            style: GoogleFonts.urbanist(
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
              color: context.textColor,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            EviraLang.of(context).notFoundDescription,
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: context.recentColor,
            ),
          ),
        ],
      ),
    );
  }
}
