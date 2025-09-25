import 'package:evira_e_commerce/features/fill_profile/domain/repos/fill_profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class ShowDatePickerUsecase {
  final FillProfileRepo repo;
  ShowDatePickerUsecase(this.repo);

  Future<String> call(BuildContext context) => repo.showDatePicker(context);
}
