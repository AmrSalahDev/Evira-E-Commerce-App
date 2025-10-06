import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/create_pin/ui/cubit/pin_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/app_flow_cubit.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:evira_e_commerce/shared/widgets/pin_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({super.key});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen>
    with StatefulScreenMixin {
  late TextEditingController pinController;
  bool isPinCompleted = false;

  @override
  void initState() {
    super.initState();
    pinController = TextEditingController();
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget? buildBottomNavigationBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocSelector<PinCubit, PinState, bool>(
          selector: (state) => state is PinSaving,
          builder: (context, state) {
            return CustomButton(
              isLoading: state,
              backgroundColor: isPinCompleted
                  ? context.buttonActiveColor
                  : context.buttonInactiveColor,
              textColor: isPinCompleted
                  ? context.textActiveColor
                  : context.textInactiveColor,
              onPressed: () async {
                if (isPinCompleted) {
                  await context.read<PinCubit>().savePin(pinController.text);
                  if (context.mounted) {
                    await context.read<PinCubit>().registerPin();
                  }
                  if (context.mounted && !state) {
                    await context.read<AppFlowCubit>().checkUserState();
                  }
                }
              },
              title: EviraLang.of(context).continuee,
            );
          },
        ),
        SizedBox(height: 40.h),
      ],
    );
  }

  @override
  String get title => EviraLang.current.createNewPin;

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                EviraLang.of(context).addPin,
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  color: context.textColor,
                ),
              ),
            ),
            SizedBox(height: 70.h),
            PinTextField(
              pinController: pinController,
              isObscureText: true,
              onCompleted: (value) {},
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

            SizedBox(height: 70.h),
          ],
        ),
      ),
    );
  }
}
