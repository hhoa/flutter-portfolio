import 'dart:ui';
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_app_web/bloc/bloc_homepage.dart';
import 'package:flutter_app_web/res/colors.dart';
import 'package:flutter_app_web/res/fonts.dart';
import 'package:flutter_app_web/res/images.dart';
import 'package:flutter_app_web/res/strings.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildImage(),
        _buildText(),
      ],
    );
  }

  Widget _buildText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "I'm Hoa Hoang",
              style: MyAssetFonts.bigBoldName,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "I'm a passionate Mobile Developer on HCM city",
              style: MyAssetFonts.descriptionName,
            ),
            SizedBox(
              height: 16,
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

  Widget _buildImage() {
    double sigma = BlocHomePage.currentType == LayoutType.Web ? 0 : 3;
    double opacity = BlocHomePage.currentType == LayoutType.Web ? 1 : 0.4;

    return Positioned(
      right: 0,
      top: 0,
      bottom: 0,
      child: Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: Image.asset(
              MyAssetImages.imageProfile,
              fit: BoxFit.fitHeight,
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
