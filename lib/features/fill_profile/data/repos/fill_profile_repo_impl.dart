import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/fill_profile/domain/repos/fill_profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@LazySingleton(as: FillProfileRepo)
class FillProfileRepoImpl extends FillProfileRepo {
  @override
  Future<String> showDatePicker(BuildContext context) async {
    DateTime? datePicked = await DatePicker.showSimpleDatePicker(
      context,
      backgroundColor: context.containerColor,
      textColor: context.textColor,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      dateFormat: "yyyy/MM/dd",
      titleText: EviraLang.of(context).selectDate,
      confirmText: EviraLang.of(context).ok,
      cancelText: EviraLang.of(context).cancel,
      looping: true,
    );

    if (datePicked != null) {
      String formattedDate = DateFormat('yyyy/MM/dd').format(datePicked);
      return formattedDate;
    } else {
      return '';
    }
  }
}
