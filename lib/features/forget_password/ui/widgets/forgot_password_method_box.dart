import 'package:evira_e_commerce/core/constants/app_styles.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordMethodBox extends StatefulWidget {
  const ForgotPasswordMethodBox({super.key});

  @override
  State<ForgotPasswordMethodBox> createState() =>
      _ForgotPasswordMethodBoxState();
}

class _ForgotPasswordMethodBoxState extends State<ForgotPasswordMethodBox> {
  bool isEmailSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() {
            isEmailSelected = false;
          }),
          child: Container(
            height: 130.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.containerColor,
              border: Border.all(
                color: isEmailSelected
                    ? context.containerBorderColor
                    : context.textFieldBorderColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundColor: context.grayBackgroundColor,
                    child: Icon(
                      Icons.message,
                      color: context.iconColor,
                      size: 30.h,
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        EviraLang.current.viaSMS,
                        style: AppStyles.smallTextStyle16(context).copyWith(
                          fontWeight: FontWeight.w500,
                          color: context.textColor.withAlpha(120),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        '+20 1120636215',
                        style: AppStyles.smallTextStyle18(
                          context,
                        ).copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 30.h),
        GestureDetector(
          onTap: () => setState(() {
            isEmailSelected = true;
          }),
          child: Container(
            height: 130.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.containerColor,
              border: Border.all(
                color: isEmailSelected
                    ? context.textFieldBorderColor
                    : context.containerBorderColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundColor: context.grayBackgroundColor,
                    child: Icon(
                      Icons.email,
                      color: context.iconColor,
                      size: 30.h,
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        EviraLang.of(context).viaEmail,
                        style: AppStyles.smallTextStyle16(context).copyWith(
                          fontWeight: FontWeight.w500,
                          color: context.textColor.withAlpha(120),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        'blackcode018@gmailcom',
                        style: AppStyles.smallTextStyle18(
                          context,
                        ).copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
