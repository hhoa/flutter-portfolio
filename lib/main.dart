import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'bloc/bloc_homepage.dart';
import 'bloc/bloc_provider.dart';
import 'firebase_options.dart';
import 'res/colors.dart';
import 'utils/remote_config.dart';
import 'widgets/my_appbar.dart';
import 'widgets/my_contact.dart';
import 'widgets/my_experience.dart';
import 'widgets/my_profile.dart';
import 'widgets/my_projects.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(!kDebugMode);
    await RemoteConfigUtils.initialize();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    runApp(const MyApp());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hi there, I'm Hoa",
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<BlocHomePage>(
        bloc: BlocHomePage(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  late BlocHomePage _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<BlocHomePage>(context);
    _bloc.itemScrollController = itemScrollController;
    itemPositionsListener.itemPositions.addListener(() {
      List<ItemPosition> itemPositions =
          itemPositionsListener.itemPositions.value.toList();
      _bloc.updateShadow(itemPositions[0].index);
      if (!itemPositions
              .map((e) => e.index)
              .toList()
              .contains(_bloc.currentPage) &&
          itemPositions[0].index != _bloc.currentPage) {
        _bloc.changePageIndex(itemPositions[0].index, isScroll: false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        _bloc.updateLayoutType(constraint.maxWidth);
        return Scaffold(
            backgroundColor: MyAssetColor.backgroundColor,
            body: Column(
              children: [
                const MyAppBar(),
                Expanded(child: _buildPageView()),
              ],
            ));
      },
    );
  }

  Widget _buildPageView() {
    return ScrollablePositionedList.builder(
      itemCount: 4,
      scrollDirection: Axis.vertical,
      physics: const ClampingScrollPhysics(),
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return const MyProfile();
          case 1:
            return const MyExperience();
          case 2:
            return const MyProjects();
          case 3:
            return const MyContact();
          default:
            return Container();
        }
      },
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
