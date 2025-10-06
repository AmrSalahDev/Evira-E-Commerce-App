import 'package:evira_e_commerce/core/constants/app_styles.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/login/domain/entities/login_entity.dart';
import 'package:evira_e_commerce/features/login/ui/cubit/login_cubit.dart';
import 'package:evira_e_commerce/features/login/ui/widgets/dont_have_account_part.dart';
import 'package:evira_e_commerce/features/login/ui/widgets/forgot_password_part.dart';
import 'package:evira_e_commerce/features/login/ui/widgets/signin_button_part.dart';
import 'package:evira_e_commerce/features/login/ui/widgets/signin_buttons_part.dart';
import 'package:evira_e_commerce/features/login/ui/widgets/signin_forms_part.dart';
import 'package:evira_e_commerce/shared/cubits/text_field_cubit.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/custom_checkbox.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_flutter_toolkit/ui/widgets/custom_divider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with StatefulScreenMixin<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();

    context.read<TextFieldCubit>().setRequiredFields(['email', 'password']);
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
              EviraLang.of(context).loginToYourAccount,
              style: AppStyles.largeTextStyle(context),
            ),
            SizedBox(height: 50.h),
            SignInFormsPart(
              formKey: _formKey,
              emailController: _emailController,
              passwordController: _passwordController,
            ),
            SizedBox(height: 25.h),
            CustomCheckbox(title: EviraLang.of(context).rememberMe),
            SizedBox(height: 25.h),
            SignInButtonPart(
              onSignInPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  context.read<LoginCubit>().login(
                    loginEntity: LoginEntity(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 15.h),
            ForgotPasswordPart(),
            SizedBox(height: 30.h),
            CustomDivider(
              title: EviraLang.of(context).orContinueWith,
              color: context.dividerColor,
              textStyle: AppStyles.dividerTextStyle(context),
            ),
            SizedBox(height: 30.h),
            SignInButtonsPart(),
            SizedBox(height: 40.h),
            DontHaveAccountPart(),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
