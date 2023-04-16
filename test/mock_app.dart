import 'package:flutter/material.dart';
import 'package:flutter_app_web/repository/remote_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mocks/remote_config_mock.dart';

class MockApp extends StatelessWidget {
  const MockApp({
    Key? key,
    required this.child,
    this.customMap,
  }) : super(key: key);

  final Widget child;
  final Map<String, dynamic>? customMap;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<RemoteConfigRepository>(
      create: (_) => MockRemoteConfigRepository(customMap: customMap),
      child: MaterialApp(
        title: 'Flutter Widget Test',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: child,
      ),
    );
  }
}
