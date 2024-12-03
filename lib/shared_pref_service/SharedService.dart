import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  // Singleton instance
  static final SharedService _instance = SharedService._internal();
  static late SharedPreferences _preferences;

  // Private constructor to enforce singleton pattern
  SharedService._internal();

  // Factory constructor to return the singleton instance
  factory SharedService() {
    return _instance;
  }

  // Initialization method (called before using SharedService)
  static Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
    log("Initialized shared preference");
  }

  String getUsername({String? key}) {
    return _preferences.getString(key ?? "username") ?? "";
  }

  String getToken({String? key}) {
    return _preferences.getString(key ?? "token") ?? "";
  }

  String getRefreshToken({String? key}) {
    return _preferences.getString(key ?? "refreshToken") ?? "";
  }

  String getUserid({String? key}) {
    return _preferences.getString(key ?? "userId") ?? "";
  }

  // Setter for String
  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  // Getter for String
  String? getString(String key) {
    return _preferences.getString(key);
  }

  // Setter for Integer
  Future<bool> setInt(String key, int value) async {
    return await _preferences.setInt(key, value);
  }

  // Getter for Integer
  int? getInt(String key) {
    return _preferences.getInt(key);
  }

  // Setter for Boolean
  Future<bool> setBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  // Getter for Boolean
  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  // Setter for Double
  Future<bool> setDouble(String key, double value) async {
    return await _preferences.setDouble(key, value);
  }

  // Getter for Double
  double? getDouble(String key) {
    return _preferences.getDouble(key);
  }

  // Remove a specific key
  Future<bool> remove(String key) async {
    return await _preferences.remove(key);
  }

  // Clear all preferences
  Future<bool> clear() async {
    return await _preferences.clear();
  }
}
