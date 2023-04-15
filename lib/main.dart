import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'repository/remote_config.dart';
import 'route/router.dart';
import 'screens/home/view/page.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await RemoteConfigRepository.initialize();
    if (!kIsWeb) {
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    }
    runApp(const MyApp());
  }, (error, stack) {
    if (!kIsWeb) {
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<RemoteConfigRepository>(
      create: (_) => RemoteConfigRepository(),
      child: MaterialApp(
        title: "Hi there, I'm Hoa",
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: generateRoute,
        initialRoute: HomePage.routeName,
      ),
    );
  }
}
