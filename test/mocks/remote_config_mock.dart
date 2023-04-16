import 'dart:convert' show jsonDecode;

import 'package:flutter_app_web/repository/remote_config.dart';

class MockRemoteConfigRepository implements RemoteConfigRepository {
  MockRemoteConfigRepository({Map<String, dynamic>? customMap}) {
    final Map<String, dynamic> defaultMap =
        RemoteConfigRepository.remoteConfigDefault;

    map = {};
    defaultMap.forEach((key, value) {
      if (customMap?.containsKey(key) ?? false) {
        map![key] = customMap![key];
        customMap.remove(key);
      } else {
        map![key] = defaultMap[key];
      }
    });
    map!.addAll(customMap ?? {});
  }

  late final Map<String, dynamic>? map;

  @override
  String getValueString(String? key) {
    if (map != null && map!.containsKey(key)) {
      return map![key];
    }

    return (super.noSuchMethod(Invocation.method(#getValueString, [key])));
  }

  @override
  bool getValueBool(String? key) {
    if (map != null && map!.containsKey(key)) {
      return map![key];
    }

    return (super.noSuchMethod(Invocation.method(#getValueBool, [key])));
  }

  @override
  int getValueInt(String? key) {
    if (map != null && map!.containsKey(key)) {
      return map![key];
    }

    return (super.noSuchMethod(Invocation.method(#getValueInt, [key])));
  }

  @override
  Map<String, dynamic> getValueJson(String? key) {
    if (map != null && map!.containsKey(key)) {
      return jsonDecode(map![key]);
    }

    return (super.noSuchMethod(Invocation.method(#getValueJson, [key])));
  }
}
