import 'dart:io';

import 'package:evira_e_commerce/features/fill_profile/domain/repos/image_picker_repo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ImagePickerRepo)
class ImagePickerRepoImpl extends ImagePickerRepo {
  final ImagePicker _picker = ImagePicker();
  File? selectedFile;

  @override
  Future<File?> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedFile = File(image.path);
    } else {
      debugPrint("No image selected");
    }
    return selectedFile;
  }

  @override
  Future<File?> recoverLostImage() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return null;
    }

    if (response.files != null && response.files!.isNotEmpty) {
      selectedFile = File(response.files!.first.path);
    } else {
      debugPrint("LostData error: ${response.exception}");
    }
    return selectedFile;
  }
}
