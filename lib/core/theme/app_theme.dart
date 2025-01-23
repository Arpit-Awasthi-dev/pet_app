import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static const darkTheme = 'dark_theme';
  static const lightTheme = 'light_theme';

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: false,
      appBarTheme: const AppBarTheme(
        color: AppColors.scaffoldDark,
        iconTheme: IconThemeData(
          color: AppColors.scaffoldLight,
        )
      ),
      primaryColor: AppColors.scaffoldDark,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: AppColors.textContrastDark,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textContrastDark,
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          color: AppColors.textContrastDark,
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          color: AppColors.deepBlue,
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          color: AppColors.deepBlue,
          fontWeight: FontWeight.normal,
        ),
        titleSmall: TextStyle(
          fontSize: 12,
          color: AppColors.deepBlue,
          fontWeight: FontWeight.normal,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          color: AppColors.textPlaceholdersDark,
          fontWeight: FontWeight.normal,
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        linearTrackColor: AppColors.scaffoldLight,
        color: AppColors.deepBlue,
      ),
      scaffoldBackgroundColor: AppColors.scaffoldDark,
      dividerColor: Colors.grey,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      shadowColor: Colors.black.withOpacity(0.1),
    );
  }

  static ThemeData get light {
    return ThemeData(
      useMaterial3: false,
      appBarTheme: const AppBarTheme(
        color: Colors.transparent,
          iconTheme: IconThemeData(
            color: AppColors.scaffoldDark,
          )
      ),
      primaryColor: AppColors.scaffoldLight,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: AppColors.textContrastLight,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textContrastLight,
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          color: AppColors.textContrastLight,
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          color: AppColors.deepBlue,
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          color: AppColors.deepBlue,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          fontSize: 12,
          color: AppColors.deepBlue,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          color: AppColors.textPlaceholdersLight,
          fontWeight: FontWeight.normal,
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        linearTrackColor: AppColors.scaffoldLight,
        color: AppColors.deepBlue,
      ),
      scaffoldBackgroundColor: AppColors.scaffoldLight,
      dividerColor: AppColors.lightDivider,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
    );
  }
}
