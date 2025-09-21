import 'package:evira_e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_transitions/go_transitions.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: GoTransitions.fade,
        TargetPlatform.iOS: GoTransitions.cupertino,
        TargetPlatform.macOS: GoTransitions.cupertino,
      },
    ),
    scaffoldBackgroundColor: AppColors.lightBackground,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.lightTextFieldBorder,
      selectionColor: AppColors.lightTextFieldBorder.withAlpha(100),
      selectionHandleColor: AppColors.lightTextFieldBorder,
    ),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: GoTransitions.fade,
        TargetPlatform.iOS: GoTransitions.cupertino,
        TargetPlatform.macOS: GoTransitions.cupertino,
      },
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.darkTextFieldBorder,
      selectionColor: AppColors.darkTextFieldBorder.withAlpha(100),
      selectionHandleColor: AppColors.darkTextFieldBorder,
    ),
  );
}

extension AppColorContext on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get backgroundColor =>
      isDark ? AppColors.darkBackground : AppColors.lightBackground;
  Color get containerColor =>
      isDark ? AppColors.darkContainer : AppColors.lightContainer;
  Color get containerBorderColor =>
      isDark ? AppColors.darkContainerBorder : AppColors.lightContainerBorder;
  Color get textColor => isDark ? AppColors.darkText : AppColors.lightText;
  Color get dividerColor =>
      isDark ? AppColors.darkDivider : AppColors.lightDivider;
  Color get buttonActiveColor =>
      isDark ? AppColors.darkActiveButton : AppColors.lightActiveButton;
  Color get textActiveColor =>
      isDark ? AppColors.darkActiveText : AppColors.lightActiveText;
  Color get textInactiveColor =>
      isDark ? AppColors.darkInActiveText : AppColors.lightInActiveText;
  Color get buttonInactiveColor =>
      isDark ? AppColors.darkInActiveButton : AppColors.lightInActiveButton;
  Color get iconColor => isDark ? AppColors.darkIcon : AppColors.lightIcon;
  Color get buttonColor =>
      isDark ? AppColors.darkButton : AppColors.lightButton;
  Color get buttonTextColor =>
      isDark ? AppColors.darkButtonText : AppColors.lightButtonText;
  Color get gray300 => isDark ? AppColors.darkGray300 : AppColors.lightGray300;
  Color get textFieldBorderColor =>
      isDark ? AppColors.darkTextFieldBorder : AppColors.lightTextFieldBorder;
  Color get textFieldColor =>
      isDark ? AppColors.darkTextField : AppColors.lightTextField;
  Color get textHintColor =>
      isDark ? AppColors.darkHintText : AppColors.lightHintText;
  Color get hintColor => isDark ? AppColors.darkHint : AppColors.lightHint;
  Color get checkBoxColor =>
      isDark ? AppColors.darkCheckbox : AppColors.lightCheckbox;
  Color get checkboxIconColor =>
      isDark ? AppColors.darkCheckboxIcon : AppColors.lightCheckboxIcon;
  Color get dividerTextColor =>
      isDark ? AppColors.darkDividerText : AppColors.lightDividerText;
}
