import 'package:flutter/material.dart';
import 'package:flutter_app_web/bloc/bloc_homepage.dart';
import 'package:flutter_app_web/bloc/bloc_provider.dart';
import 'package:flutter_app_web/res/colors.dart';
import 'package:flutter_app_web/widgets/my_appbar.dart';
import 'package:flutter_app_web/widgets/my_contact.dart';
import 'package:flutter_app_web/widgets/my_experience.dart';
import 'package:flutter_app_web/widgets/my_profile.dart';
import 'package:flutter_app_web/widgets/my_projects.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hi there, I'm Hoa",
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
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  BlocHomePage _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<BlocHomePage>(context);
    _bloc.itemScrollController = itemScrollController;
    itemPositionsListener.itemPositions.addListener(() {
      List<ItemPosition> itemPositions = itemPositionsListener.itemPositions.value.toList();
      if (!itemPositions.contains(_bloc.currentPage) && itemPositions[0].index != _bloc.currentPage) {
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
      child: ScrollablePositionedList.builder(
        itemCount: 4,
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return MyProfile();
            case 1:
              return MyExperience();
            case 2:
              return MyProjects();
            case 3:
              return MyContact();
            default:
              return Container();
          }
        },
      ),
    );
  }
}
