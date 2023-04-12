import 'dart:ui';

import 'package:flutter/material.dart';

import '../bloc/bloc_homepage.dart';
import '../res/colors.dart';
import '../res/constants.dart';
import '../res/fonts.dart';
import '../res/images.dart';
import '../utils/common.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight - MyConstants.heightAppBar,
      child: Stack(
        children: [
          _buildImage(screenHeight),
          _buildText(screenWidth),
        ],
      ),
    );
  }

  Widget _buildText(double screenWidth) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth / 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "I'm Hoa Hoang",
              style: MyAssetFonts.bigBoldName,
            ),
            const SizedBox(height: 30),
            Text(
              "I'm a passionate Mobile Developer in HCMC",
              style: MyAssetFonts.descriptionName,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyAssetColor.appColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () {
                Common.launch(MyConstants.linkCV);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Download CV",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: MyAssetFonts.fontFamily,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(double screenHeight) {
    double padding = screenHeight / 8;
    double sigma = BlocHomePage.currentType == LayoutType.web ? 0.1 : 3;
    double opacity = BlocHomePage.currentType == LayoutType.web ? 1 : 0.4;

    return Positioned(
      right: 0,
      top: padding,
      bottom: padding,
      child: Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: SizedBox(
              height: screenHeight,
              child: Image.asset(
                MyAssetImages.imageProfile,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: sigma,
                sigmaY: sigma,
              ),
              child: Container(),
            ),
          ),
        ],
      ),
    );
  }
}
