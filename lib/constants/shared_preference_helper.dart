import 'package:eat/constants/shared_preference_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static Future<SharedPreferences> get _preference =>
      SharedPreferences.getInstance();

  static Future<bool> getBool(String key) async =>
      (await _preference).getBool(key) ?? false;

  static Future setBool(String key, bool value) async =>
      (await _preference).setBool(key, value);

  static Future<int> getInt(String key) async =>
      (await _preference).getInt(key) ?? 0;

  static Future setInt(String key, int value) async =>
      (await _preference).setInt(key, value);

  static Future<String> getString(String key) async =>
      (await _preference).getString(key) ?? '';

  static Future setString(String key, String value) async =>
      (await _preference).setString(key, value);

  static Future<double> getDouble(String key) async =>
      (await _preference).getDouble(key) ?? 0.0;

  static Future setDouble(String key, double value) async =>
      (await _preference).setDouble(key, value);

  static Future removeKey(String key) async =>
      (await _preference).remove(key);

  static clearPreference() async {
    try {
      var pref = await _preference;
      pref.remove(PreferenceConst.isUserLogin);
      pref.remove(PreferenceConst.userId);
      pref.remove(PreferenceConst.token);
    } catch (e) {
      print(e);
    }
  }
}
