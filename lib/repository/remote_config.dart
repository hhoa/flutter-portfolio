// ignore_for_file: lines_longer_than_80_chars
import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

import '../enum/remote_config.dart';

class RemoteConfigRepository {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  String getValueString(String key) => _remoteConfig.getString(key);

  bool getValueBool(String key) => _remoteConfig.getBool(key);

  int getValueInt(String key) => _remoteConfig.getInt(key);

  Map<String, dynamic> getValueJson(String key) {
    final jsonString = getValueString(key);
    try {
      return jsonDecode(jsonString);
    } on Exception catch (e) {
      if (!kIsWeb) {
        FirebaseCrashlytics.instance.recordError(e.toString(), null,
            reason: 'getValueJson: jsonDecode failed with value $jsonString');
      }
    }
    return {};
  }

  static Future<void> initialize() async {
    try {
      await FirebaseRemoteConfig.instance
          .setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 60),
      ));

      await FirebaseRemoteConfig.instance.setDefaults(remoteConfigDefault);

      try {
        await FirebaseRemoteConfig.instance.ensureInitialized();
        await FirebaseRemoteConfig.instance.fetchAndActivate();
      } on Exception {
        debugPrint('Unable to fetch remote config. '
            'Cached or default values will be used');
      }
    } on Exception catch (e) {
      // handle error
      debugPrint(e.toString());
    }
  }

  static Map<String, dynamic> get remoteConfigDefault => {
        RemoteConfigEnum.myNameText.key:
            RemoteConfigEnum.myNameText.defaultValue,
        RemoteConfigEnum.linkCV.key: RemoteConfigEnum.linkCV.defaultValue,
        RemoteConfigEnum.followMe.key: RemoteConfigEnum.followMe.defaultValue,
        RemoteConfigEnum.experience.key:
            RemoteConfigEnum.experience.defaultValue,
        RemoteConfigEnum.project.key: RemoteConfigEnum.project.defaultValue,
        RemoteConfigEnum.nameTitleText.key:
            RemoteConfigEnum.nameTitleText.defaultValue,
        RemoteConfigEnum.myselfIntroductionText.key:
            RemoteConfigEnum.myselfIntroductionText.defaultValue,
        RemoteConfigEnum.downloadCvText.key:
            RemoteConfigEnum.downloadCvText.defaultValue,
        RemoteConfigEnum.recentProjectsText.key:
            RemoteConfigEnum.recentProjectsText.defaultValue,
        RemoteConfigEnum.moreInfoText.key:
            RemoteConfigEnum.moreInfoText.defaultValue,
        RemoteConfigEnum.workExperienceText.key:
            RemoteConfigEnum.workExperienceText.defaultValue,
        RemoteConfigEnum.followMeText.key:
            RemoteConfigEnum.followMeText.defaultValue,
        RemoteConfigEnum.listAppBarTitleText.key:
            RemoteConfigEnum.listAppBarTitleText.defaultValue,
      };
}
