import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class DontHaveAccountPart extends StatelessWidget {
  const DontHaveAccountPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: EviraLang.of(context).dontHaveAccount,
        style: GoogleFonts.urbanist(fontSize: 16.sp, color: Color(0xFFbababa)),
        children: <TextSpan>[
          TextSpan(
            text: '  ${EviraLang.of(context).signUp}',
            style: GoogleFonts.urbanist(
              fontSize: 16.sp,
              color: context.textColor,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => context.push(AppPaths.signUp),
          ),
        ],
      ),
    );
  }
}
