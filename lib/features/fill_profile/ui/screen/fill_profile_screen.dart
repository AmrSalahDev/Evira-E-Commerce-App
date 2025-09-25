import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/widgets/datetime_textfield_part.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/widgets/gender_textfield_part.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/widgets/phone_number_textfield_part.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/widgets/profile_image_part.dart';
import 'package:evira_e_commerce/shared/cubits/text_field_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/text_field_state.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:evira_e_commerce/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late final TextEditingController fullNameController;
  late final TextEditingController nickNameController;
  late final TextEditingController emailController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController();
    dateController = TextEditingController();
    genderController = TextEditingController();
    fullNameController = TextEditingController();
    nickNameController = TextEditingController();
    emailController = TextEditingController();
    _formKey = GlobalKey<FormState>();

    context.read<TextFieldCubit>().setRequiredFields([
      'name',
      'email',
      'phone',
      'nickName',
      'gender',
      'date',
    ]);
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    dateController.dispose();
    genderController.dispose();
    fullNameController.dispose();
    nickNameController.dispose();
    emailController.dispose();
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
          fullNameController: fullNameController,
          nickNameController: nickNameController,
          emailController: emailController,
          formKey: _formKey,
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
    required this.fullNameController,
    required this.nickNameController,
    required this.emailController,
    required this.formKey,
  });

  final TextEditingController dateController;
  final TextEditingController phoneNumberController;
  final TextEditingController genderController;
  final TextEditingController fullNameController;
  final TextEditingController nickNameController;
  final TextEditingController emailController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50.h),
          ProfileImagePart(),
          SizedBox(height: 30.h),
          CustomTextField(
            controller: fullNameController,
            hintText: EviraLang.of(context).fullName,
            fieldKey: 'name',
            validator: (value) => Validators.name(value: value),
          ),
          SizedBox(height: 25.h),
          CustomTextField(
            controller: nickNameController,
            hintText: EviraLang.of(context).nickName,
            fieldKey: 'nickName',
            validator: (value) => Validators.name(value: value),
          ),
          SizedBox(height: 25.h),
          DateTimeTextFieldPart(dateController: dateController),
          SizedBox(height: 25.h),
          CustomTextField(
            fieldKey: 'email',
            controller: emailController,
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
          FillProfileButton(formKey: formKey),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }
}

class FillProfileButton extends StatelessWidget {
  const FillProfileButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextFieldCubit, TextFieldState>(
      builder: (context, state) {
        final isEnabled = state is TextFieldsUpdated && state.allFieldsFilled;
        return CustomButton(
          title: EviraLang.of(context).continuee,
          onPressed: isEnabled
              ? () {
                  if (formKey.currentState?.validate() ?? false) {
                    // context.read<FillProfileCubit>().fillProfile(
                    //     fullName: fullNameController.text,
                    //     nickName: nickNameController.text,
                    //     email: emailController.text,
                    //     date: dateController.text,
                    //     gender: genderController.text,
                    //     phoneNumber: phoneNumberController.text);
                  }
                }
              : null,
          backgroundColor: isEnabled
              ? context.buttonActiveColor
              : context.buttonInactiveColor,
          textColor: isEnabled
              ? context.textActiveColor
              : context.textInactiveColor,
        );
      },
    );
  }
}
