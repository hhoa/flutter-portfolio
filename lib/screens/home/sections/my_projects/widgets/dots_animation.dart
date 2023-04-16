import 'package:flutter/material.dart';

import '../../../../../res/colors.dart';

class DotsAnimation extends StatelessWidget {
  const DotsAnimation({
    Key? key,
    required this.listLength,
    required this.currentPage,
    required this.nextPage,
    required this.offset,
    this.isSwipeRight = true,
  }) : super(key: key);

  final int listLength;
  final int currentPage;
  final int nextPage;
  final double offset;
  final bool isSwipeRight;

  @override
  Widget build(BuildContext context) {
    double percentScroll = offset;
    if (!isSwipeRight) {
      percentScroll = percentScroll != 0 ? 1 - percentScroll : 0;
    }
    return SizedBox(
      height: 4,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          double widthContainer = 4;
          if (index == currentPage) {
            widthContainer = 16 - percentScroll * 12;
          } else if (index == nextPage) {
            widthContainer = 4 + percentScroll * 12;
          }

          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widthContainer,
            height: 4,
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: index == currentPage
                    ? MyAssetColor.appColor
                    : MyAssetColor.appColor.withOpacity(0.6)),
          );
        },
        itemCount: listLength,
      ),
    );
  }
}
