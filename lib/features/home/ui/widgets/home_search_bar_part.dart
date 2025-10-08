import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSearchBarPart extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onSettingsPressed;
  const HomeSearchBarPart({super.key, this.onTap, this.onSettingsPressed});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: context.textFieldColor,
        prefixIcon: Icon(Icons.search, color: context.hintColor, size: 30.h),
        suffixIcon: GestureDetector(
          onTap: onSettingsPressed,
          child: Transform.scale(
            scale: 0.5,
            child: Assets.icons.slidersSimple.svg(
              width: 30.w,
              height: 30.h,
              colorFilter: ColorFilter.mode(context.iconColor, BlendMode.srcIn),
            ),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none,
        ),
        hintText: EviraLang.of(context).search,
        hintStyle: GoogleFonts.urbanist(
          color: context.textHintColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
