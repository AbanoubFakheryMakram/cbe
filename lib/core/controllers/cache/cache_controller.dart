import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../utils/constants/storage_keys.dart';
import '../../models/responses/token.dart';

class CacheController {
  // final SharedPreferences storage;
  final FlutterSecureStorage storage;

  CacheController(this.storage);

  void saveCurrentTheme(String themeName) {
    storage.write(key: StorageKeys.theme, value: themeName);
  }

  Future<String?> loadCurrentTheme() async {
    return await storage.read(key: StorageKeys.theme);
  }

  void saveCurrentLanguage(String langCode) {
    storage.write(key: StorageKeys.language, value: langCode);
  }

  Future<String?> loadCurrentLanguage() async {
    return await storage.read(key: StorageKeys.language);
  }

  void saveToken(Token token) {
    storage.write(key: StorageKeys.token, value: json.encode(token.toJson()));
  }

  Token? getToken() {
    return Token(expireAt: 100, refreshToken: '', accessToken: '');
  }

  Future<void> clearData(List<String> keys) async {
    for (var element in keys) {
      storage.delete(key: element);
    }
  }
}
