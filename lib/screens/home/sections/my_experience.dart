// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../enum/remote_config.dart';
import '../../../model/experience_model.dart';
import '../../../widgets/my_title.dart';
import '../../../widgets/timeline_experience.dart';
import '../cubit/home_cubit.dart';

class MyExperience extends StatelessWidget {
  const MyExperience({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeCubit homeCubit = context.read<HomeCubit>();
    final List<ExperienceModel> experiences = experienceModelFromJson(
        homeCubit.getRemoteConfigString(RemoteConfigEnum.experience));
    final String expTitle =
        homeCubit.getRemoteConfigString(RemoteConfigEnum.workExperienceText);

    return ListView.builder(
      itemBuilder: (_, int index) {
        if (index == 0) {
          return Center(child: MyTitle(expTitle));
        }

        final ExperienceModel model = experiences[index - 1];
        return TimelineExperience(
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
}
