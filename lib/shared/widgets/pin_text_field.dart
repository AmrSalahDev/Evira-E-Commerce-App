import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class PinTextField extends StatelessWidget {
  final TextEditingController pinController;
  final Function(String value)? onCompleted;
  final Function(String value) onChanged;
  final bool? isObscureText;

  const PinTextField({
    super.key,
    required this.pinController,
    this.onCompleted,
    required this.onChanged,
    this.isObscureText,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 80.w,
      height: 70.h,
      textStyle: GoogleFonts.urbanist(
        fontSize: 20.sp,
        color: context.textColor,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: context.textFieldColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
    );

    final focusedPinTheme = PinTheme(
      width: 80.w,
      height: 70.h,
      textStyle: GoogleFonts.urbanist(
        fontSize: 20.sp,
        color: context.textColor,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: context.textFieldBorderColor),
        borderRadius: BorderRadius.circular(12.r),
      ),
    );
    return Pinput(
      autofocus: true,
      controller: pinController,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      length: 4,
      obscureText: isObscureText ?? false,
      obscuringCharacter: '●',
      onCompleted: onCompleted,
      onChanged: onChanged,
    );
  }
}
