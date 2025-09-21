import 'package:evira_e_commerce/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetThemeModeUseCase {
  final ThemeService _service;
  GetThemeModeUseCase(this._service);

  Future<ThemeMode> call() => _service.loadThemeMode();
}
