import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/widgets/phone_number_textfield_part.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:evira_e_commerce/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FillProfileScreen extends StatefulWidget {
  const FillProfileScreen({super.key});

  @override
  State<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen>
    with StatefulScreenMixin {
  late final TextEditingController phoneNumberController;

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  String get title => EviraLang.current.fillYourProfile;

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50.h),
            ProfileImagePart(),
            SizedBox(height: 30.h),
            CustomTextField(hintText: "Full Name"),
            SizedBox(height: 25.h),
            CustomTextField(hintText: "Nickname"),
            SizedBox(height: 25.h),
            CustomTextField(
              hintText: "Date of Birth",
              suffixIcon: FontAwesomeIcons.calendar,
            ),
            SizedBox(height: 25.h),
            CustomTextField(
              hintText: "Email",
              suffixIcon: FontAwesomeIcons.envelope,
            ),
            SizedBox(height: 25.h),
            PhoneNumberTextFieldPart(controller: phoneNumberController),
            SizedBox(height: 25.h),
            CustomTextField(
              readOnly: true,
              hintText: "Gender",
              suffixIcon: FontAwesomeIcons.caretDown,
              onSuffixTap: () async {},
            ),
            SizedBox(height: 50.h),
            CustomButton(
              title: "Continue",
              onPressed: () {},
              backgroundColor: context.buttonInactiveColor,
              textColor: context.textInactiveColor,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileImagePart extends StatelessWidget {
  const ProfileImagePart({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 170.w,
          height: 170.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.profileBgColor,
          ),
          child: Assets.icons.profile.svg(
            width: 150.w,
            height: 150.h,
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(
              context.profileIconColor,
              BlendMode.srcIn,
            ),
          ),
        ),
        Positioned(
          right: 10.w,
          bottom: 5.h,
          child: GestureDetector(
            child: Container(
              width: 37.h,
              height: 37.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.iconColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                FontAwesomeIcons.pen,
                color: context.textActiveColor,
                size: 22.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
