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
  BlocHomePage _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<BlocHomePage>(context);
    _pageViewController = PageController();
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
                MyAppBar(),
                _buildPageView(),
              ],
            )
        );
      },
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
