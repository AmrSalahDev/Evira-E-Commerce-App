import 'package:evira_e_commerce/core/enums/gender.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:evira_e_commerce/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GenderTextFieldPart extends StatefulWidget {
  final TextEditingController controller;
  const GenderTextFieldPart({super.key, required this.controller});

  @override
  State<GenderTextFieldPart> createState() => _GenderTextFieldPartState();
}

class _GenderTextFieldPartState extends State<GenderTextFieldPart> {
  Gender? selectedGender = Gender.male;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: widget.controller,
      readOnly: true,
      hintText: EviraLang.of(context).gender,
      suffixIcon: FontAwesomeIcons.caretDown,
      onTap: () async {
        await _showGenderSheet();
      },
    );
  }

  Future<void> _showGenderSheet() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: context.containerColor,
      showDragHandle: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                systemNavigationBarColor: context.containerColor,
                systemNavigationBarIconBrightness: Brightness.light,
              ),
              child: Container(
                height: 370.h,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    RadioGroup<Gender>(
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setModalState(() {
                          selectedGender = value;
                          widget.controller.text = selectedGender!.title;
                        });

                        Navigator.pop(context);
                      },
                      child: Column(
                        children: [
                          RadioListTile<Gender>(
                            activeColor: context.iconColor,
                            value: Gender.male,
                            title: Text(EviraLang.of(context).male),
                          ),
                          RadioListTile<Gender>(
                            activeColor: context.iconColor,
                            value: Gender.female,
                            title: Text(EviraLang.of(context).female),
                          ),
                          RadioListTile<Gender>(
                            activeColor: context.iconColor,
                            value: Gender.other,
                            title: Text(EviraLang.of(context).other),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25.h),
                    CustomButton(
                      title: EviraLang.of(context).cancel,
                      onPressed: () => Navigator.pop(context),
                      backgroundColor: context.buttonActiveColor,
                      textColor: context.textActiveColor,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
