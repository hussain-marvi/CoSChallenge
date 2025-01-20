import 'package:shared_preferences/shared_preferences.dart';

mixin class StorageUtility {
  static final StorageUtility _instance = StorageUtility._internal();

  factory StorageUtility() {
    return _instance;
  }

  StorageUtility._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveData(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  String? getData(String key) {
    return _prefs?.getString(key);
  }

  Future<void> removeData(String key) async {
    await _prefs?.remove(key);
  }

  Future<void> clearAllData() async {
    await _prefs?.clear();
  }
}
