import 'dart:io';

import 'package:evira_e_commerce/features/fill_profile/domain/entities/fill_profile_entity.dart';
import 'package:evira_e_commerce/features/fill_profile/domain/usecases/fill_profile_usecase.dart';
import 'package:evira_e_commerce/features/fill_profile/domain/usecases/show_date_picker_usecase.dart';
import 'package:evira_e_commerce/features/fill_profile/domain/usecases/upload_profile_image_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'fill_profile_state.dart';

@injectable
class FillProfileCubit extends Cubit<FillProfileState> {
  final ShowDatePickerUsecase showDatePickerUsecase;
  final FillProfileUsecase fillProfileUsecase;
  final UploadprofileimageUsecase uploadProfileImageUsecase;

  FillProfileCubit(
    this.showDatePickerUsecase,
    this.fillProfileUsecase,
    this.uploadProfileImageUsecase,
  ) : super(FillProfileInitial());

  File? image;

  void changeImage(File? image) {
    this.image = image;
  }

  Future<void> showDatePicker(BuildContext context) async {
    emit(ProfileShowDatePickerLoading());
    try {
      final String datePicked = await showDatePickerUsecase.call(context);
      emit(ProfileShowDatePickerLoaded(datePicked));
    } catch (e) {
      emit(ProfileShowDatePickerError(e.toString()));
    }
  }

  Future<void> fillProfile(FillProfileEntity fillProfileEntity) async {
    emit(FillProfileLoading());
    final supabase = Supabase.instance.client;
    try {
      if (image != null && supabase.auth.currentUser != null) {
        final String? url = await uploadProfileImageUsecase.call(
          imageFile: image!,
          uid: supabase.auth.currentUser!.id,
        );
        if (url != null) {
          fillProfileEntity = fillProfileEntity.copyWith(profileImage: url);
        }
      }
      await fillProfileUsecase.call(fillProfileEntity);
      emit(FillProfileSuccess());
    } catch (e) {
      emit(FillProfileError(e.toString()));
    }
  }
}
