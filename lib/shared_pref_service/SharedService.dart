import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  // Singleton instance
  static final SharedService _instance = SharedService._internal();
  static SharedPreferences? _preferences;

  // Private constructor to enforce singleton pattern
  SharedService._internal() {
    SharedService.initialize();
  }

  // Factory constructor to return the singleton instance
  factory SharedService() {
    return _instance;
  }

  // Initialization method (call before using SharedService)
  static Future<void> initialize() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
      log("======= Initialized SharedPreferences");
    }
  }

  // Getter for SharedPreferences instance
  SharedPreferences get _prefs {
    if (_preferences == null) {
      throw Exception(
          "SharedService is not initialized. Call SharedService.initialize() before using it.");
    }
    return _preferences!;
  }

  String getUsername({String? key}) {
    return _prefs.getString(key ?? "username") ?? "";
  }

  String getToken({String? key}) {
    return _prefs.getString(key ?? "token") ?? "";
  }

  String getRefreshToken({String? key}) {
    return _prefs.getString(key ?? "refreshToken") ?? "";
  }

  String getUserid({String? key}) {
    return _prefs.getString(key ?? "userId") ?? "";
  }

  // Setter for String
  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  // Getter for String
  String? getString(String key) {
    return _prefs.getString(key);
  }

  // Setter for Integer
  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  // Getter for Integer
  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  // Setter for Boolean
  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  // Getter for Boolean
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  // Setter for Double
  Future<bool> setDouble(String key, double value) async {
    return await _prefs.setDouble(key, value);
  }

  // Getter for Double
  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  // Remove a specific key
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  // Clear all preferences
  Future<bool> clear() async {
    return await _prefs.clear();
  }
}
