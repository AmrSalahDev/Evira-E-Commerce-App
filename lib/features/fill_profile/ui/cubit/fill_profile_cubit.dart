import 'dart:io';

import 'package:evira_e_commerce/features/fill_profile/domain/usecases/image_picker_usecase.dart';
import 'package:evira_e_commerce/features/fill_profile/domain/usecases/recover_lost_image_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'fill_profile_state.dart';

@injectable
class FillProfileCubit extends Cubit<FillProfileState> {
  final ImagePickerUsecase imagePickerUsecase;
  final RecoverLostImageUsecase recoverLostImageUsecase;
  FillProfileCubit(this.imagePickerUsecase, this.recoverLostImageUsecase)
    : super(FillProfileInitial());

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
}
