// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../res/fonts.dart';
import '../res/images.dart';
import 'base_widget.dart';
import 'my_title.dart';

class MyExperience extends BaseWidget {
  const MyExperience({Key? key}) : super(key: key);

  @override
  Widget buildPhone(BuildContext context) {
    return const MyTimeLine();
  }

  @override
  Widget buildTablet(BuildContext context) {
    return const MyTimeLine();
  }

  @override
  Widget buildWeb(BuildContext context) {
    return const MyTimeLine();
  }
}

class MyTimeLine extends StatelessWidget {
  const MyTimeLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        const MyTitle("Work Experience"),
        timelineExperience(
          screenWidth,
          "09/2020 - Present",
          "Be Group",
          "Be is a Vietnamese tech company which is the CONNECTORS between customers and service providers. At Be Group, I have been building Cake - a digital bank that helps users to quickly create a banking account for some fundamental needs such as transferring money, managing cards or paying bills, etc.",
          isFirst: false,
          logo: MyAssetImages.imageBe,
        ),
        timelineExperience(
          screenWidth,
          "05/2019 - 09/2020",
          "Sendo",
          "Sendo is one of the leading e-commerce in Vietnam. At sendo, I built high quality landing pages such as Flash Sale and Daily Deal to integrate with Buyer app.",
          isFirst: false,
          logo: MyAssetImages.imageSendo,
        ),
        timelineExperience(
          screenWidth,
          "01/2018 - 05/2019",
          "AIOZ",
          "AIOZ is a Singapore-based company. At AIOZ, I built mobile app that integrating cutting-edge technology like Computer Vision and Machine Learning to help resolve problems.",
          logo: MyAssetImages.imageAioz,
        ),
        timelineExperience(
          screenWidth,
          "07/2017 - 12/2017",
          "Robert BOSCH Vietnam",
          "The Bosch Group is a leading global supplier of technology and services. At Bosch, I worked with German customer to build software tool that log their work.",
          isLast: true,
          logo: MyAssetImages.imageBosch,
        ),
      ],
    );
  }

  Widget timelineExperience(
      double screenWidth, String time, String exp, String description,
      {bool isFirst = false, bool isLast = false, String logo = ""}) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: screenWidth / 8),
      child: TimelineTile(
        alignment: TimelineAlign.start,
        lineXY: 0,
        isFirst: isFirst,
        isLast: isLast,
        indicatorStyle: IndicatorStyle(
          width: 40,
          height: 40,
          indicator: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                logo,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        endChild: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                exp,
                style: MyAssetFonts.companyName,
              ),
              Text(
                time,
                style: MyAssetFonts.companyTimeline,
              ),
              const SizedBox(height: 16),
              Text(
                description,
                style: MyAssetFonts.companyDescription,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
