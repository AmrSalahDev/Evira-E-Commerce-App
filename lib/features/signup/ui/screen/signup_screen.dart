import 'package:evira_e_commerce/core/constants/app_styles.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/signup/ui/widgets/already_have_account_part.dart';
import 'package:evira_e_commerce/features/signup/ui/widgets/signup_button_part.dart';
import 'package:evira_e_commerce/features/signup/ui/widgets/signup_buttons_part.dart';
import 'package:evira_e_commerce/features/signup/ui/widgets/signup_forms_part.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/custom_checkbox.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        child: _BodySection(
          formKey: _formKey,
          emailController: _emailController,
          passwordController: _passwordController,
        ),
      ),
    );
  }
}

class _BodySection extends StatelessWidget {
  const _BodySection({
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) : _formKey = formKey,
       _emailController = emailController,
       _passwordController = passwordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          EviraLang.of(context).createYourAccount,
          style: AppStyles.largeTextStyle(context),
        ),
        SizedBox(height: 50.h),
        SignupFormsPart(
          formKey: _formKey,
          emailController: _emailController,
          passwordController: _passwordController,
        ),
        SizedBox(height: 25.h),
        CustomCheckbox(title: EviraLang.of(context).rememberMe),
        SizedBox(height: 25.h),
        SignupButtonPart(formKey: _formKey),
        SizedBox(height: 50.h),
        CustomDivider(
          title: EviraLang.of(context).orContinueWith,
          color: context.dividerColor,
          textStyle: AppStyles.dividerTextStyle(context),
        ),
        SizedBox(height: 30.h),
        SignupButtonsPart(),
        SizedBox(height: 50.h),
        AlreadyHaveAccountPart(),
        SizedBox(height: 30.h),
      ],
    );
  }
}
