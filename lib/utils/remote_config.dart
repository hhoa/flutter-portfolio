// ignore_for_file: lines_longer_than_80_chars
import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class RemoteConfigUtils {
  RemoteConfigUtils._();

  static final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  static String getValueString(String key) => _remoteConfig.getString(key);

  static bool getValueBool(String key) => _remoteConfig.getBool(key);

  static int getValueInt(String key) => _remoteConfig.getInt(key);

  static Map<String, dynamic> getValueJson(String key) {
    final jsonString = getValueString(key);
    try {
      return jsonDecode(jsonString);
    } on Exception catch (e) {
      FirebaseCrashlytics.instance.recordError(e.toString(), null,
          reason: 'getValueJson: jsonDecode failed with value $jsonString');
    }
    return {};
  }

  static Future<void> initialize() async {
    try {
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 60),
      ));
      await _remoteConfig.setDefaults({});
      await fetchAndActivate();
    } on Exception catch (e) {
      // handle error
      print(e);
    }
  }

  static Future<void> fetchAndActivate() async {
    try {
      await _remoteConfig.ensureInitialized();
      await _remoteConfig.fetchAndActivate();
    } on Exception {
      debugPrint('Unable to fetch remote config. '
          'Cached or default values will be used');
    }
  }
}
