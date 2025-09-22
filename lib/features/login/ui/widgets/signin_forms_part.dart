import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_flutter_toolkit/core/utils/text_field_utils/validators.dart';

class SignInFormsPart extends StatelessWidget {
  const SignInFormsPart({
    super.key,
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
    return Form(
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
    );
  }
}
