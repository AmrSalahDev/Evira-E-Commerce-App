import 'package:evira_e_commerce/core/constants/app_styles.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/create_new_password/ui/dialogs/reset_password_successful_dialog.dart';
import 'package:evira_e_commerce/shared/cubits/text_field_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/text_field_state.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:evira_e_commerce/shared/widgets/custom_checkbox.dart';
import 'package:evira_e_commerce/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_flutter_toolkit/core/extensions/context_extensions.dart';
import 'package:my_flutter_toolkit/core/utils/text_field_utils/validators.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen>
    with StatefulScreenMixin<CreateNewPasswordScreen> {
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    formKey = GlobalKey<FormState>();

    context.read<TextFieldCubit>().setRequiredFields([
      'password',
      'confirmPassword',
    ]);
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  String get title => EviraLang.current.createNewPassword;

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.h),
            context.isDark
                ? Assets.images.createNewPasswordLogoDark.image(
                    width: context.screenWidth * 0.8,
                    height: context.screenHeight * 0.3,
                    fit: BoxFit.contain,
                  )
                : Assets.images.createNewPasswordLogoLight.image(
                    width: context.screenWidth * 0.8,
                    height: context.screenHeight * 0.3,
                    fit: BoxFit.contain,
                  ),
            SizedBox(height: 70.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                EviraLang.of(context).createYourNewPassword,
                style: AppStyles.smallTextStyle18(context),
              ),
            ),
            SizedBox(height: 30.h),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    fieldKey: 'password',
                    controller: passwordController,
                    validator: (value) => Validators.password(value: value),
                    hintText: EviraLang.of(context).password,
                    perfixIcon: FontAwesomeIcons.lock,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 25.h),
                  CustomTextField(
                    fieldKey: 'confirmPassword',
                    controller: confirmPasswordController,
                    validator: (value) => Validators.confirmPassword(
                      value: value,
                      password: passwordController.text,
                    ),
                    hintText: EviraLang.of(context).confirmPassword,
                    perfixIcon: FontAwesomeIcons.lock,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            CustomCheckbox(title: EviraLang.of(context).rememberMe),
            SizedBox(height: 50.h),
            BlocBuilder<TextFieldCubit, TextFieldState>(
              builder: (context, state) {
                final isActive =
                    state is TextFieldsUpdated && state.allFieldsFilled;
                return CustomButton(
                  title: EviraLang.of(context).continuee,
                  backgroundColor: isActive
                      ? context.buttonActiveColor
                      : context.buttonInactiveColor,
                  textColor: isActive
                      ? context.textActiveColor
                      : context.textInactiveColor,
                  onPressed: isActive
                      ? () async {
                          if (formKey.currentState?.validate() ?? false) {
                            await ResetPasswordSuccessfulDialog.show(context);
                          }
                        }
                      : null,
                );
              },
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
