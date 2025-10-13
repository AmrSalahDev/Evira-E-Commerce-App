import 'package:animated_emoji/emoji.dart';
import 'package:animated_emoji/emojis.g.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/cubits/greeting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeGreetingPart extends StatefulWidget {
  const HomeGreetingPart({super.key});

  @override
  State<HomeGreetingPart> createState() => _HomeGreetingPartState();
}

class _HomeGreetingPartState extends State<HomeGreetingPart> {
  bool animateHand = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          animateHand = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<GreetingCubit, String, String>(
      selector: (state) => state,
      builder: (context, greating) {
        return Row(
          children: [
            Text(
              greating,
              style: GoogleFonts.urbanist(
                fontSize: 18.sp,
                color: context.textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            AnimatedEmoji(
              AnimatedEmojis.wave,
              size: 24.sp,
              repeat: animateHand,
              errorWidget: const SizedBox.shrink(),
            ),
          ],
        );
      },
    );
  }
}
