import 'package:evira_e_commerce/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class SetThemeModeUseCase {
  final ThemeService _service;
  SetThemeModeUseCase(this._service);

  Future<void> call(ThemeMode mode) => _service.saveThemeMode(mode);
}
