import 'package:flutter/material.dart';

import 'app_colors.dart';

extension ColorSchemeExtension on ColorScheme {
  Color get borderColor => brightness == Brightness.light
      ? AppColors.borderDark
      : AppColors.borderLight;

  Color get appBarIconColor => brightness == Brightness.light
      ? const Color(0xFFF2F4FC)
      : const Color(0xFF354352);
}
