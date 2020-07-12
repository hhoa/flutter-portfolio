import 'package:flutter/material.dart';
import 'package:flutter_app_web/bloc/bloc_homepage.dart';
import 'package:flutter_app_web/bloc/bloc_provider.dart';
import 'package:flutter_app_web/res/colors.dart';
import 'package:flutter_app_web/widgets/my_appbar.dart';
import 'package:flutter_app_web/widgets/my_profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web Portfolio',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        bloc: BlocHomePage(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageViewController;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAssetColor.backgroundColor,
      body: Column(
        children: [
          MyAppBar(),
          _buildPageView(),
        ],
      )
    );
  }

  Widget _buildPageView() {
    return Expanded(
      child: PageView(
        controller: _pageViewController,
        children: [
          MyProfile(),
        ],
      ),
    );
  }
}
