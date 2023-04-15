import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../res/fonts.dart';

class TimelineExperience extends StatelessWidget {
  const TimelineExperience({
    Key? key,
    required this.company,
    this.isFirst = false,
    this.isLast = false,
    this.logo,
    this.time,
    this.description,
  }) : super(key: key);

  final String company;
  final bool isFirst;
  final bool isLast;
  final String? logo;
  final String? time;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: screenWidth / 8),
      child: TimelineTile(
        alignment: TimelineAlign.start,
        lineXY: 0,
        isFirst: isFirst,
        isLast: isLast,
        indicatorStyle: _buildIndicatorStyle(),
        endChild: _buildEndChild(),
      ),
    );
  }

  IndicatorStyle _buildIndicatorStyle() {
    return IndicatorStyle(
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
          child: logo != null
              ? Image.network(
                  logo!,
                  fit: BoxFit.cover,
                )
              : Container(),
        ),
      ),
    );
  }

  Widget _buildEndChild() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            company,
            style: MyAssetFonts.companyName,
          ),
          if (time != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                time!,
                style: MyAssetFonts.companyTimeline,
              ),
            ),
          if (description != null)
            Text(
              description!,
              style: MyAssetFonts.companyDescription,
            ),
        ],
      ),
    );
  }
}
