// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../enum/remote_config.dart';
import '../../../model/experience_model.dart';
import '../../../res/fonts.dart';
import '../../../utils/remote_config.dart';
import '../../../widgets/base_widget.dart';
import '../../../widgets/my_title.dart';

class MyExperience extends BaseWidget {
  const MyExperience({Key? key}) : super(key: key);

  @override
  Widget buildPhone(BuildContext context) {
    return MyTimeLine();
  }

  @override
  Widget buildTablet(BuildContext context) {
    return MyTimeLine();
  }

  @override
  Widget buildWeb(BuildContext context) {
    return MyTimeLine();
  }
}

class MyTimeLine extends StatelessWidget {
  MyTimeLine({Key? key}) : super(key: key) {
    experiences = experienceModelFromJson(
        RemoteConfigUtils.getValueString(RemoteConfigEnum.experience.key));
  }

  late final List<ExperienceModel> experiences;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final expTitle =
        RemoteConfigUtils.getValueString(RemoteConfigEnum.workExperienceText.key);

    return ListView.builder(
      itemBuilder: (_, int index) {
        if (index == 0) {
          return Center(child: MyTitle(expTitle));
        }

        final ExperienceModel model = experiences[index - 1];
        return timelineExperience(
          screenWidth,
          time: model.time,
          company: model.company,
          description: model.description,
          isFirst: index == 1,
          isLast: index == experiences.length,
          logo: model.logo,
        );
      },
      itemCount: experiences.length + 1,
      primary: false,
      shrinkWrap: true,
    );
  }

  Widget timelineExperience(
    double screenWidth, {
    required String company,
    bool isFirst = false,
    bool isLast = false,
    String? logo,
    String? time,
    String? description,
  }) {
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
              child: logo != null
                  ? Image.network(
                      logo,
                      fit: BoxFit.cover,
                    )
                  : Container(),
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
                company,
                style: MyAssetFonts.companyName,
              ),
              if (time != null)
                Text(
                  time,
                  style: MyAssetFonts.companyTimeline,
                ),
              const SizedBox(height: 16),
              if (description != null)
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
