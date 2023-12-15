import 'package:shared_preferences/shared_preferences.dart';
import '../../../application/datasources/local/local_storage.dart';

class LocalStorageImpl extends LocalStorage {
  final SharedPreferences _prefs;

  LocalStorageImpl({required SharedPreferences prefs}) : _prefs = prefs;

  @override
  String? getValue(String key) => _prefs.getString(key);

  @override
  Future<bool> removeKey(String key) async => await _prefs.remove(key);

  @override
  Future<void> setKeyValue(String key, String value) async =>
      await _prefs.setString(key, value);
}
