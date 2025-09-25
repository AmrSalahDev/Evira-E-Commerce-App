import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/cubit/fill_profile_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/text_field_cubit.dart';
import 'package:evira_e_commerce/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DateTimeTextFieldPart extends StatelessWidget {
  const DateTimeTextFieldPart({super.key, required this.dateController});

  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FillProfileCubit, FillProfileState>(
      listenWhen: (prev, curr) => curr is ProfileShowDatePickerLoaded,
      buildWhen: (previous, current) => previous != current,

      listener: (context, state) {
        if (state is ProfileShowDatePickerLoaded) {
          if (state.datePicked.isEmpty) return;
          dateController.text = state.datePicked;
          context.read<TextFieldCubit>().updateField('date', state.datePicked);
        }
      },
      builder: (context, state) {
        bool isLoading = state is ProfileShowDatePickerLoading;
        return CustomTextField(
          controller: dateController,
          readOnly: true,
          keyboardType: TextInputType.number,
          hintText: EviraLang.of(context).dateOfBirth,
          suffixIcon: FontAwesomeIcons.calendar,
          suffixLoading: LoadingAnimationWidget.threeRotatingDots(
            color: context.iconColor,
            size: 27.h,
          ),
          isSuffixLoading: isLoading,
          onTap: () async {
            await context.read<FillProfileCubit>().showDatePicker(context);
          },
        );
      },
    );
  }
}
