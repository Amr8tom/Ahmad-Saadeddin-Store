// ignore_for_file: avoid_print, constant_identifier_names

import '../main.dart';

class Prefs {
  static const String USER_ID = 'userId';
  static String accessToken = "accessToken";

  static setString(String key, String value) {
    return getStorage!.write(key, value);
  }

  static getString(String key) {
    return getStorage!.read(key);
  }

  static setBool(String key, bool value) {
    return getStorage!.write(key, value);
  }

  static getBool(String key) {
    return getStorage!.read(key) ?? false;
  }

  static String getToken() {
    return getStorage!.read(accessToken) ?? '';
  }

  static setToken(String token) {
    return getStorage!.write(accessToken, token);
  }

  static String getUserID() {
    return getStorage!.read(USER_ID) ?? '';
  }

  static setUserID(String userID) {
    return getStorage!.write(USER_ID, userID);
  }

  static remove(String key) {
    return getStorage!.remove(key);
  }

  static clear() {
    print('PREFS CLEARED');
    return getStorage!.erase();
  }
}
