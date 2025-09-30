import 'dart:io';

import 'package:evira_e_commerce/features/fill_profile/domain/repos/fill_profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadprofileimageUsecase {
  final FillProfileRepo fillProfileRepo;

  UploadprofileimageUsecase(this.fillProfileRepo);

  Future<String> call({required String uid, required File imageFile}) =>
      fillProfileRepo.uploadProfileImage(uid: uid, imageFile: imageFile);
}
