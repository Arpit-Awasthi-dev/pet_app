import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/core/db/database_helper.dart';

import 'app.dart';
import 'core/app_config.dart';
import 'core/injection_container.dart' as di;
import 'core/shared_preference.dart';

void main() async {
  AppConfig();
  WidgetsFlutterBinding.ensureInitialized();

  /// Service Locator Initialization
  await di.init();

  /// store list in db if not stored
  if (!SharedAccess().getBool(PreferenceKeys.listStored)) {
    await DatabaseHelper.instance.storePetList();
  }

  /// Get Theme
  final savedThemeMode =
      await AdaptiveTheme.getThemeMode() ?? AdaptiveThemeMode.light;
  runApp(MyApp(theme: savedThemeMode));
}
