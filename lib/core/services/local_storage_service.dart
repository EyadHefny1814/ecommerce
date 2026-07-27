import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setFirstTime(bool value) async {
    await prefs.setBool('isFirstTime', value);
  }

  static bool get isFirstTime {
    return prefs.getBool('isFirstTime') ?? true;
  }

  static Future<void> setLoggedIn(bool value) async {
    await prefs.setBool('isLoggedIn', value);
  }

  static bool get isLoggedIn {
    return prefs.getBool('isLoggedIn') ?? false;
  }
}