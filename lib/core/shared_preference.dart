import 'package:shared_preferences/shared_preferences.dart';
import 'injection_container.dart';

class SharedAccess {
  final SharedPreferences _sharedPreferences = sl<SharedPreferences>();

  SharedAccess._();

  static final SharedAccess _instance = SharedAccess._();

  factory SharedAccess() => _instance;

  bool getBool(String key) {
    final value = _sharedPreferences.getBool(key);
    return value ?? false;
  }

  void storeBool(String key, bool value) {
    _sharedPreferences.setBool(key, value);
  }
}

class PreferenceKeys{
  static const String listStored = 'LIST_STORED';
}