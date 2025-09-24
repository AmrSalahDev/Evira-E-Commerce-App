import 'dart:io';

import 'package:evira_e_commerce/features/fill_profile/domain/repos/image_picker_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ImagePickerUsecase {
  final ImagePickerRepo imagePickerRepo;

  ImagePickerUsecase(this.imagePickerRepo);

  Future<File?> call() => imagePickerRepo.pickImage();
}
