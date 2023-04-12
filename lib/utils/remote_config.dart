// ignore_for_file: lines_longer_than_80_chars
import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class RemoteConfigUtils {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  String getValueString(String key) => _remoteConfig.getString(key);

  bool getValueBool(String key) => _remoteConfig.getBool(key);

  int getValueInt(String key) => _remoteConfig.getInt(key);

  Map<String, dynamic> getValueJson(String key) {
    final jsonString = getValueString(key);
    try {
      return jsonDecode(jsonString);
    } on Exception catch (e) {
      FirebaseCrashlytics.instance.recordError(e.toString(), null,
          reason: 'getValueJson: jsonDecode failed with value $jsonString');
    }
    return {};
  }

  Future<void> initialize() async {
    try {
      // Durations should be configure-able via env vars later
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 60),
      ));
      await _remoteConfig.setDefaults({

      });
      await fetchAndActivate();
    } on Exception {
      // handle error
      // print(e);
    }
  }

  Future<void> fetchAndActivate() async {
    try {
      await _remoteConfig.ensureInitialized();
      await _remoteConfig.fetchAndActivate();
    } on Exception {
      debugPrint('Unable to fetch remote config. '
          'Cached or default values will be used');
    }
  }
}
