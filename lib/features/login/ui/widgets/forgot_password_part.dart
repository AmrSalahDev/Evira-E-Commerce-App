import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPart extends StatelessWidget {
  const ForgotPasswordPart({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.push(AppPaths.forgotPassword),
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
      ),
      child: Text(
        EviraLang.of(context).forgetPassword,
        style: GoogleFonts.urbanist(
          fontSize: 17.sp,
          fontWeight: FontWeight.w600,
          color: context.textColor,
        ),
      ),
    );
  }
}
