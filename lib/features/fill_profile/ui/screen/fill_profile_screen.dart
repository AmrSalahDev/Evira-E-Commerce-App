import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/features/fill_profile/domain/entities/fill_profile_entity.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/cubit/fill_profile_cubit.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/widgets/datetime_textfield_part.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/widgets/fill_profile_button_part.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/widgets/gender_textfield_part.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/widgets/phone_number_textfield_part.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/widgets/profile_image_part.dart';
import 'package:evira_e_commerce/shared/cubits/text_field_cubit.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/custom_text_field.dart';
import 'package:firebase_core/firebase_core.dart';
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
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController();
    dateController = TextEditingController();
    genderController = TextEditingController();
    fullNameController = TextEditingController();
    nickNameController = TextEditingController();
    emailController = TextEditingController();
    formKey = GlobalKey<FormState>();

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
        child: Form(
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
                keyboardType: TextInputType.name,
                fieldKey: 'name',
                validator: (value) => Validators.name(value: value),
              ),
              SizedBox(height: 25.h),
              CustomTextField(
                controller: nickNameController,
                hintText: EviraLang.of(context).nickName,
                fieldKey: 'nickName',
                keyboardType: TextInputType.name,
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

              FillProfileButton(
                formKey: formKey,

                onPressed: () {
                  final fillProfileEntity = FillProfileEntity(
                    fullname: fullNameController.text.trim(),
                    nickname: nickNameController.text.trim(),
                    anotherEmail: emailController.text.trim(),
                    phone: phoneNumberController.text.trim(),
                    gender: genderController.text.trim(),
                    dateOfBirth: dateController.text.trim(),
                    uid: '',
                    profileImage: '',
                  );

                  context.read<FillProfileCubit>().fillProfile(
                    fillProfileEntity,
                  );
                },
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
