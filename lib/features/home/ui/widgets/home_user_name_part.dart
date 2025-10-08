import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeUserNamePart extends StatelessWidget {
  final String? name;
  const HomeUserNamePart({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name ?? '',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.urbanist(
        fontSize: 23.sp,
        color: context.textColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
