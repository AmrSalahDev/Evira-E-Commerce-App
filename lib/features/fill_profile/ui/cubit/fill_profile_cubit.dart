import 'dart:io';

import 'package:evira_e_commerce/features/fill_profile/domain/entities/fill_profile_entity.dart';
import 'package:evira_e_commerce/features/fill_profile/domain/usecases/fill_profile_usecase.dart';
import 'package:evira_e_commerce/features/fill_profile/domain/usecases/image_picker_usecase.dart';
import 'package:evira_e_commerce/features/fill_profile/domain/usecases/recover_lost_image_usecase.dart';
import 'package:evira_e_commerce/features/fill_profile/domain/usecases/show_date_picker_usecase.dart';
import 'package:evira_e_commerce/features/fill_profile/domain/usecases/upload_profile_image_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'fill_profile_state.dart';

@injectable
class FillProfileCubit extends Cubit<FillProfileState> {
  final ImagePickerUsecase imagePickerUsecase;
  final RecoverLostImageUsecase recoverLostImageUsecase;
  final ShowDatePickerUsecase showDatePickerUsecase;
  final FillProfileUsecase fillProfileUsecase;
  final UploadprofileimageUsecase uploadProfileImageUsecase;

  FillProfileCubit(
    this.imagePickerUsecase,
    this.recoverLostImageUsecase,
    this.showDatePickerUsecase,
    this.fillProfileUsecase,
    this.uploadProfileImageUsecase,
  ) : super(FillProfileInitial());

  Future<void> pickImage() async {
    emit(ProfileImageLoading());
    try {
      final File? image = await imagePickerUsecase.call();
      if (image != null) {
        emit(ProfileImageLoaded(image));
      } else {
        emit(ProfileImageError("No image selected"));
      }
    } catch (e) {
      emit(ProfileImageError(e.toString()));
    }
  }

  Future<void> recoverLostImage() async {
    emit(ProfileImageLoading());
    try {
      final File? image = await recoverLostImageUsecase.call();
      if (image != null) {
        emit(ProfileImageLoaded(image));
      } else {
        emit(ProfileImageError("No Lost image found"));
      }
    } catch (e) {
      emit(ProfileImageError(e.toString()));
    }
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
    try {
      await fillProfileUsecase.call(fillProfileEntity);
      emit(FillProfileSuccess());
    } catch (e) {
      emit(FillProfileError(e.toString()));
    }
  }
}
