import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../enum/layout_type.dart';
import '../../../enum/remote_config.dart';
import '../../../res/colors.dart';
import '../../../res/constants.dart';
import '../../../res/fonts.dart';
import '../../../res/images.dart';
import '../../../utils/common.dart';
import '../cubit/home_cubit.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight - MyConstants.heightAppBar,
      child: Stack(
        children: [
          _buildImage(context, screenHeight),
          _buildText(context, screenWidth),
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context, double screenWidth) {
    final HomeCubit homeCubit = context.read<HomeCubit>();
    final nameTitle =
        homeCubit.getRemoteConfigString(RemoteConfigEnum.nameTitleText);
    final introductionTitle = homeCubit
        .getRemoteConfigString(RemoteConfigEnum.myselfIntroductionText);
    final downloadCvTitle =
        homeCubit.getRemoteConfigString(RemoteConfigEnum.downloadCvText);

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth / 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nameTitle,
              style: MyAssetFonts.bigBoldName,
            ),
            const SizedBox(height: 30),
            Text(
              introductionTitle,
              style: MyAssetFonts.descriptionName,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              key: const Key('profile-downloadcv'),
              style: ElevatedButton.styleFrom(
                backgroundColor: MyAssetColor.appColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () {
                final String link =
                    homeCubit.getRemoteConfigString(RemoteConfigEnum.linkCV);

                Common.launch(link);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  downloadCvTitle,
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

  Widget _buildImage(BuildContext context, double screenHeight) {
    final LayoutType currentType = context.read<HomeCubit>().currentType;
    final double padding = screenHeight / 8;
    final double sigma = currentType == LayoutType.web ? 0.1 : 3;
    final double opacity = currentType == LayoutType.web ? 1 : 0.4;

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
