import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/cubits/greeting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeGreetingPart extends StatelessWidget {
  const HomeGreetingPart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<GreetingCubit, String, String>(
      selector: (state) => state,
      builder: (context, greating) {
        return Text(
          greating,
          style: GoogleFonts.urbanist(
            fontSize: 18.sp,
            color: context.textColor,
            fontWeight: FontWeight.w500,
          ),
        );
      },
    );
  }
}
