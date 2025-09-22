import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPasswordPart extends StatelessWidget {
  const ForgetPasswordPart({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => () {},
      child: Text(
        EviraLang.of(context).forgetPassword,
        style: GoogleFonts.urbanist(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: context.textColor,
        ),
      ),
    );
  }
}
