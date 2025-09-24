import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/date_formatter.dart';

class DateTimeTextFieldPart extends StatelessWidget {
  const DateTimeTextFieldPart({super.key, required this.dateController});

  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: dateController,
      keyboardType: TextInputType.number,
      inputFormatters: [DateInputFormatter()],
      hintText: EviraLang.of(context).dateOfBirth,
      suffixIcon: FontAwesomeIcons.calendar,
      onSuffixTap: () async {
        var datePicked = await DatePicker.showSimpleDatePicker(
          context,
          backgroundColor: context.containerColor,
          textColor: context.textColor,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          dateFormat: "dd-MMMM-yyyy",
          titleText: EviraLang.of(context).selectDate,
          confirmText: EviraLang.of(context).ok,
          cancelText: EviraLang.of(context).cancel,
          looping: true,
        );
        if (datePicked != null) {
          dateController.text = DateFormat('dd-MM-yyyy').format(datePicked);
        }
      },
    );
  }
}
