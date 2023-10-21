import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todolist/features/auth/data/models/auth_user_model.dart';



class AppStorage {

  /// This will store the user detail in memory anytime user opens the app
  static AuthUserModel? currentUserSession;

  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
// Create storage
  static final storage =  FlutterSecureStorage(aOptions: _getAndroidOptions());

  static Future<void> saveToPref({required String key, required Map<String, dynamic> jsonValue}) async{
    // Write value
    await storage.write(key: key, value: json.encode(jsonValue));
  }

  static Future<Map<String, dynamic>?> getFromPref({required String key}) async {
// Read value
    String? value = await storage.read(key: key);
    if(value != null){
      return json.decode(value);
    }
    return null;
  }

  static removeFromPref({required String key}) async {
    // Delete value
    await storage.delete(key: key);
  }



}