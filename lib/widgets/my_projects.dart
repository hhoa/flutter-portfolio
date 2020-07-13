import 'package:flutter/material.dart';
import 'package:flutter_app_web/bloc/bloc_homepage.dart';
import 'package:flutter_app_web/res/constants.dart';
import 'package:flutter_app_web/res/images.dart';
import 'package:flutter_app_web/widgets/base_widget.dart';

class MyProjects extends BaseWidget {
  @override
  Widget buildPhone(BuildContext context) {
    return AllProjects();
  }

  @override
  Widget buildTable(BuildContext context) {
    return AllProjects();
  }

  @override
  Widget buildWeb(BuildContext context) {
    return AllProjects();
  }
}

class AllProjects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> listImages = [
      MyAssetImages.imageFlashSale,
      MyAssetImages.imageDailyDeal,
      MyAssetImages.imageLmx,
      MyAssetImages.imageLuckySale,
      MyAssetImages.imageGos,
    ];

    int itemPerRow = 3;
    if (BlocHomePage.currentType == LayoutType.Web) {
      itemPerRow = 3;
    } else if (BlocHomePage.currentType == LayoutType.Tablet) {
      itemPerRow = 2;
    } else {
      itemPerRow = 1;
    }
    double padding = 30;
    double ratioImage = 2.16;
    double widthImage = (MediaQuery.of(context).size.width -
            MyConstants.paddingHorizontal * 2 -
            itemPerRow * padding) /
        itemPerRow;
    double heightImage = ratioImage * widthImage;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: MyConstants.paddingHorizontal),
      child: Wrap(
        spacing: 30,
        runSpacing: 30,
        children: List.generate(
            listImages.length,
            (index) => Container(
                  width: widthImage,
                  height: heightImage,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      listImages[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                )).toList(),
      ),
    );
  }
}
