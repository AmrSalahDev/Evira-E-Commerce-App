import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCheckbox extends StatefulWidget {
  final String? title;
  final Function(bool value)? onChecked;
  const CustomCheckbox({super.key, this.title, this.onChecked});

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => isChecked = !isChecked);
        widget.onChecked?.call(isChecked);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            width: 27.h,
            height: 27.h,
            decoration: BoxDecoration(
              color: isChecked ? context.checkBoxColor : Colors.transparent,
              border: Border.all(color: context.checkBoxColor, width: 2.5),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: isChecked
                ? Icon(
                    Icons.check,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    size: 20.h,
                  )
                : null,
          ),

          SizedBox(width: 10.w),
          Text(
            widget.title ?? '',
            style: GoogleFonts.urbanist(
              color: context.textColor,
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
