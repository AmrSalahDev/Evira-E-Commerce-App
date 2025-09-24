import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/widgets/datetime_textfield_part.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/widgets/gender_textfield_part.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/widgets/phone_number_textfield_part.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/widgets/profile_image_part.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:evira_e_commerce/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_flutter_toolkit/core/utils/text_field_utils/validators.dart';

class FillProfileScreen extends StatefulWidget {
  const FillProfileScreen({super.key});

  @override
  State<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen>
    with StatefulScreenMixin {
  late final TextEditingController phoneNumberController;
  late final TextEditingController dateController;
  late final TextEditingController genderController;

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController();
    dateController = TextEditingController();
    genderController = TextEditingController();
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
        clipBehavior: Clip.none,
        child: BodySection(
          genderController: genderController,
          dateController: dateController,
          phoneNumberController: phoneNumberController,
        ),
      ),
    );
  }
}

class BodySection extends StatelessWidget {
  const BodySection({
    super.key,
    required this.dateController,
    required this.phoneNumberController,
    required this.genderController,
  });

  final TextEditingController dateController;
  final TextEditingController phoneNumberController;
  final TextEditingController genderController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 50.h),
        ProfileImagePart(),
        SizedBox(height: 30.h),
        CustomTextField(hintText: EviraLang.of(context).fullName),
        SizedBox(height: 25.h),
        CustomTextField(hintText: EviraLang.of(context).nickName),
        SizedBox(height: 25.h),
        DateTimeTextFieldPart(dateController: dateController),
        SizedBox(height: 25.h),
        CustomTextField(
          keyboardType: TextInputType.emailAddress,
          validator: (value) => Validators.email(value: value),
          hintText: EviraLang.of(context).email,
          suffixIcon: FontAwesomeIcons.envelope,
        ),
        SizedBox(height: 25.h),
        PhoneNumberTextFieldPart(controller: phoneNumberController),
        SizedBox(height: 25.h),
        GenderTextFieldPart(controller: genderController),
        SizedBox(height: 50.h),
        CustomButton(
          title: EviraLang.of(context).continuee,
          onPressed: () {},
          backgroundColor: context.buttonInactiveColor,
          textColor: context.textInactiveColor,
        ),
        SizedBox(height: 50.h),
      ],
    );
  }
}
