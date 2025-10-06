import 'dart:io';

import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/fill_profile/data/models/fill_profile_model.dart';
import 'package:evira_e_commerce/features/fill_profile/domain/entities/fill_profile_entity.dart';
import 'package:evira_e_commerce/features/fill_profile/domain/repos/fill_profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: FillProfileRepo)
class FillProfileRepoImpl extends FillProfileRepo {
  final supabase = Supabase.instance.client;

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

  @override
  Future<String?> uploadProfileImage({
    required String uid,
    required File imageFile,
  }) async {
    try {
      final String filePath = "$uid/profile.png";

      await supabase.storage
          .from('profile_images')
          .upload(
            filePath,
            imageFile,
            fileOptions: const FileOptions(upsert: true),
          );

      // Get public URL
      final String publicUrl = supabase.storage
          .from('profile_images')
          .getPublicUrl(filePath);

      return publicUrl;
    } catch (e) {
      print("Upload error: $e");
      return null;
    }
  }

  @override
  Future<void> fillProfile(FillProfileEntity fillProfileEntity) async {
    final model = FillProfileModel(
      fullname: fillProfileEntity.fullname,
      nickname: fillProfileEntity.nickname,
      dateOfBirth: fillProfileEntity.dateOfBirth,
      anotherEmail: fillProfileEntity.anotherEmail,
      phone: fillProfileEntity.phone,
      gender: fillProfileEntity.gender,
      profileImage: fillProfileEntity.profileImage,
    );
    await supabase.auth.updateUser(UserAttributes(data: model.toJson()));

    final user = supabase.auth.currentUser;
    if (user != null) {
      await supabase
          .from('users')
          .update({'is_profile_filled': true})
          .eq('id', user.id);
    }
  }
}
