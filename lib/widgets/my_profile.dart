import 'dart:ui';
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_app_web/bloc/bloc_homepage.dart';
import 'package:flutter_app_web/res/colors.dart';
import 'package:flutter_app_web/res/fonts.dart';
import 'package:flutter_app_web/res/images.dart';
import 'package:flutter_app_web/res/constants.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
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
            SizedBox(
              height: 30,
            ),
            Text(
              "I'm a passionate Mobile Developer on HCM city",
              style: MyAssetFonts.descriptionName,
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              hoverColor: Colors.black,
              color: MyAssetColor.appColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {
                html.window.open(MyConstants.linkCV, 'Download CV');
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Download CV",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: MyAssetFonts.fontFamily,
                      fontSize: 16),
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
    double sigma = BlocHomePage.currentType == LayoutType.Web ? 0 : 3;
    double opacity = BlocHomePage.currentType == LayoutType.Web ? 1 : 0.4;

    return Positioned(
      right: 0,
      top: padding,
      bottom: padding,
      child: Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: Container(
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
