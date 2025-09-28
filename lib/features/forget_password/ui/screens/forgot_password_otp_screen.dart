import 'package:evira_e_commerce/core/constants/app_styles.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:evira_e_commerce/shared/widgets/pin_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_resend_timer/otp_resend_timer.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  const ForgotPasswordOtpScreen({super.key});

  @override
  State<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen>
    with StatefulScreenMixin<ForgotPasswordOtpScreen> {
  late TextEditingController pinController;
  late OtpResendTimerController otpResendTimerController;
  bool isTimerFinished = false;
  bool isPinCompleted = false;

  @override
  void initState() {
    super.initState();
    pinController = TextEditingController();
    otpResendTimerController = OtpResendTimerController(initialTime: 60);
  }

  @override
  void dispose() {
    pinController.dispose();
    otpResendTimerController.dispose();
    super.dispose();
  }

  @override
  String get title => EviraLang.current.forgetPasswordTitle;

  @override
  Widget? buildBottomNavigationBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: CustomButton(
            title: EviraLang.of(context).verify,
            onPressed: isPinCompleted
                ? () {
                    context.push(AppPaths.createNewPassword);
                  }
                : null,
            backgroundColor: isPinCompleted
                ? context.buttonActiveColor
                : context.buttonInactiveColor,
            textColor: isPinCompleted
                ? context.textActiveColor
                : context.textInactiveColor,
          ),
        ),
        SizedBox(height: 50.h),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
          children: [
            Text(
              '${EviraLang.of(context).codeHasBeenSend} +01120636215',
              style: AppStyles.smallTextStyle18(context),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 70.h),
            PinTextField(
              pinController: pinController,
              onChanged: (value) {
                setState(() {
                  if (value.length == 4) {
                    isPinCompleted = true;
                  } else {
                    isPinCompleted = false;
                  }
                });
              },
            ),
            SizedBox(height: 50.h),
            OtpResendTimer(
              controller: otpResendTimerController,
              autoStart: true,
              timerMessage: EviraLang.of(context).resendCode,
              readyMessage: "",
              resendMessage: isTimerFinished
                  ? EviraLang.of(context).resend
                  : "",
              timerMessageStyle: GoogleFonts.urbanist(
                color: context.textColor,
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
              ),

              resendMessageStyle: TextStyle(
                color: context.textColor,
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
              ),

              onFinish: () {
                safeSetState(() => isTimerFinished = true);
              },
              onResendClicked: () {
                safeSetState(() => isTimerFinished = false);
              },
              onStart: () {
                safeSetState(() => isTimerFinished = false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
