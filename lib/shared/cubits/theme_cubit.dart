import 'package:evira_e_commerce/shared/domain/usecases/get_theme_mode_usecase.dart';
import 'package:evira_e_commerce/shared/domain/usecases/set_theme_mode_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ThemeCubit extends Cubit<ThemeMode> {
  final GetThemeModeUseCase getThemeMode;
  final SetThemeModeUseCase setThemeMode;

  ThemeCubit(this.getThemeMode, this.setThemeMode) : super(ThemeMode.system) {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final mode = await getThemeMode();
    emit(mode);
  }

  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(newMode);
    emit(newMode);
  }
}
