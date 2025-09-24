import 'dart:io';

abstract class ImagePickerRepo {
  Future<File?> pickImage();
  Future<File?> recoverLostImage();
}
