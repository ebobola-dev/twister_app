import 'package:shared_preferences/shared_preferences.dart';
import 'package:twister_app/config.dart';

class PrefTheme {
  static Future<void> save(bool dark) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(PrefKeys.theme, dark);
  }

  static Future<bool?> read() async {
    final prefs = await SharedPreferences.getInstance();
    final dark = prefs.getBool(PrefKeys.theme);
    return dark;
  }
}
