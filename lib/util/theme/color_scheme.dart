import 'package:flutter/material.dart';

import 'app_colors.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,

  primary: AppColors.primary,
  onPrimary: AppColors.white,

  secondary: AppColors.secondary,
  onSecondary: AppColors.black,

  tertiary: AppColors.tertiary,
  onTertiary: AppColors.black,

  error: AppColors.error,
  onError: AppColors.white,

  surface: AppColors.white,
  onSurface: AppColors.black,

  surfaceTint: AppColors.grey,

  background: AppColors.neutral,
  onBackground: AppColors.black,
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  primary: AppColors.tertiary, // fica mais elegante no dark
  onPrimary: AppColors.black,

  secondary: AppColors.secondary,
  onSecondary: AppColors.black,

  tertiary: AppColors.primary,
  onTertiary: AppColors.white,

  error: AppColors.error,
  onError: AppColors.white,

  surface: Color(0xFF1E1E1E),
  onSurface: AppColors.white,

  surfaceTint: AppColors.grey,


  background: Color(0xFF121212),
  onBackground: AppColors.white,
);