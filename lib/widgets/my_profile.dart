import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app_web/res/fonts.dart';
import 'package:flutter_app_web/res/images.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
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
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Positioned(
      right: 0,
      top: 0,
      bottom: 0,
      child: Stack(
        children: [
          Image.asset(
            MyAssetImages.imageProfile,
            fit: BoxFit.fitHeight,
          ),
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraint) {
                double sigma = constraint.minWidth < 991 ? 3 : 0;

                return BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: sigma,
                    sigmaY: sigma,
                  ),
                  child: Container(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
