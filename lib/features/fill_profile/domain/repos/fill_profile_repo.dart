import 'dart:io';

import 'package:evira_e_commerce/features/fill_profile/domain/entities/fill_profile_entity.dart';
import 'package:flutter/material.dart';

abstract class FillProfileRepo {
  Future<String> showDatePicker(BuildContext context);
  Future<String> uploadProfileImage({
    required String uid,
    required File imageFile,
  });
  Future<void> fillProfile(FillProfileEntity fillProfileEntity);
}
