import 'package:evira_e_commerce/core/constants/app_styles.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/cubits/text_field_cubit.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:evira_e_commerce/shared/widgets/custom_checkbox.dart';
import 'package:evira_e_commerce/shared/widgets/custom_sign_button.dart';
import 'package:evira_e_commerce/shared/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/core/utils/text_field_utils/validators.dart';
import 'package:my_flutter_toolkit/ui/widgets/custom_divider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with StatefulScreenMixin<SignupScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              EviraLang.of(context).createYourAccount,
              style: AppStyles.largeTextStyle(context),
            ),
            SizedBox(height: 50.h),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    validator: (value) => Validators.email(value: value),
                    controller: _emailController,
                    hintText: EviraLang.of(context).email,
                    perfixIcon: FontAwesomeIcons.solidEnvelope,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 25.h),
                  CustomTextField(
                    controller: _passwordController,
                    validator: (value) => Validators.password(value: value),
                    hintText: EviraLang.of(context).password,
                    perfixIcon: FontAwesomeIcons.lock,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.h),
            CustomCheckbox(title: EviraLang.of(context).rememberMe),
            SizedBox(height: 25.h),
            BlocBuilder<TextFieldCubit, bool>(
              bloc: context.read<TextFieldCubit>(),
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                return CustomButton(
                  onPressed: state
                      ? null
                      : () {
                          _formKey.currentState?.validate();
                        },
                  backgroundColor: state
                      ? context.buttonInactiveColor
                      : context.buttonActiveColor,
                  title: EviraLang.of(context).signUp,
                  textColor: state
                      ? context.textInactiveColor
                      : context.textActiveColor,
                );
              },
            ),
            SizedBox(height: 50.h),
            CustomDivider(
              title: EviraLang.of(context).orContinueWith,
              color: context.dividerColor,
              textStyle: AppStyles.dividerTextStyle(context),
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomSignButton(
                  fullWidth: false,
                  icon: Assets.icons.facebook.svg(width: 30.w, height: 30.h),
                  onPressed: () {},
                ),
                SizedBox(height: 20.h),
                CustomSignButton(
                  icon: Assets.icons.google.svg(width: 30.w, height: 30.h),
                  onPressed: () {},
                  fullWidth: false,
                ),
                SizedBox(height: 20.h),
                CustomSignButton(
                  fullWidth: false,
                  icon: Assets.icons.apple.svg(
                    width: 30.w,
                    height: 30.h,
                    colorFilter: ColorFilter.mode(
                      context.iconColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),

            SizedBox(height: 50.h),

            Text.rich(
              TextSpan(
                text: EviraLang.of(context).alreadyHaveAccount,
                style: GoogleFonts.urbanist(
                  fontSize: 16.sp,
                  color: Color(0xFFbababa),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '  ${EviraLang.of(context).signIn}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: context.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => context.push(AppPaths.login),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
