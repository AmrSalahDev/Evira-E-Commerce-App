import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeUserNamePart extends StatelessWidget {
  final String? name;
  const HomeUserNamePart({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: GoogleFonts.urbanist(
        fontSize: 23.sp,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      child: name == null ? const SizedBox.shrink() : Text(name!),
    );
  }
}
