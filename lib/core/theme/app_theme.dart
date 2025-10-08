import 'package:evira_e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_transitions/go_transitions.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightBackground,
    useMaterial3: true,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.lightIcon,
    ),
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
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.lightContainer,
      surfaceTintColor: AppColors.lightContainer,
      dayStyle: TextStyle(color: AppColors.lightText),
      yearStyle: TextStyle(color: AppColors.lightText),
      dividerColor: AppColors.lightDivider,

      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.lightText),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.lightText),
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkBackground,
    useMaterial3: true,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.darkIcon,
    ),
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
    datePickerTheme: DatePickerThemeData(
      todayBackgroundColor: WidgetStatePropertyAll(AppColors.lightBackground),
      todayForegroundColor: WidgetStatePropertyAll(AppColors.lightText),

      backgroundColor: AppColors.darkContainer,
      surfaceTintColor: AppColors.darkContainer,
      dayStyle: TextStyle(color: AppColors.darkText),
      dividerColor: AppColors.darkDivider,
      yearStyle: TextStyle(color: AppColors.darkText),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.darkText),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.darkText),
      ),
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
  Color get profileBgColor =>
      isDark ? AppColors.darkProfileBg : AppColors.lightProfileBg;
  Color get profileIconColor =>
      isDark ? AppColors.darkProfileIcon : AppColors.lightProfileIcon;
  Color get shimmerBaseColor =>
      isDark ? AppColors.darkShimmerBase : AppColors.lightShimmerBase;
  Color get shimmerHighlightColor =>
      isDark ? AppColors.darkShimmerHighlight : AppColors.lightShimmerHighlight;
  Color get grayBackgroundColor =>
      isDark ? AppColors.darkGrayBackground : AppColors.lightGrayBackground;
  Color get cardColor => isDark ? AppColors.darkCard : AppColors.lightCard;
}
