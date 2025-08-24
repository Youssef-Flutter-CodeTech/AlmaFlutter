import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static final CashHelper _instance = CashHelper._internal();
  late SharedPreferences _prefs;

  factory CashHelper() {
    return _instance;
  }

  CashHelper._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> set(String key, dynamic value) async {
    // Store data in SharedPreferences
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    } else {
      throw Exception("Unsupported data type for SharedPreferences");
    }
  }

  Object? get(String key) {
    // Retrieve data from SharedPreferences
    return _prefs.get(key);
  }

  Future<void> remove(String key) async {
    // Remove data from SharedPreferences
    await _prefs.remove(key);
  }
}
