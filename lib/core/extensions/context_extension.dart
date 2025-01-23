import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ExtBuildContext on BuildContext {
  AppLocalizations get translations => AppLocalizations.of(this)!;

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  NavigatorState get navigator => Navigator.of(this);

  bool get isDarkMode => theme.colorScheme.brightness == Brightness.dark;
}
