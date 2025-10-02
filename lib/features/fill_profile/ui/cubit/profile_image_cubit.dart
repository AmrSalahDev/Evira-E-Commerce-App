import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:evira_e_commerce/features/fill_profile/domain/usecases/image_picker_usecase.dart';
import 'package:evira_e_commerce/features/fill_profile/domain/usecases/recover_lost_image_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'profile_image_state.dart';

@injectable
class ProfileImageCubit extends Cubit<ProfileImageState> {
  ProfileImageCubit(this.imagePickerUsecase, this.recoverLostImageUsecase)
    : super(ProfileImageInitial());

  final ImagePickerUsecase imagePickerUsecase;
  final RecoverLostImageUsecase recoverLostImageUsecase;

  File? image;

  File? get getImage => image;

  Future<void> pickImage() async {
    emit(ProfileImageLoading());

    try {
      final File? image = await imagePickerUsecase.call();
      if (image != null) {
        this.image = image;
        emit(ProfileImageLoaded(image));
      } else {
        this.image = null;
        return;
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
        this.image = image;
        emit(ProfileImageLoaded(image));
      } else {
        this.image = null;
        return;
      }
    } catch (e) {
      emit(ProfileImageError(e.toString()));
    }
  }
}
