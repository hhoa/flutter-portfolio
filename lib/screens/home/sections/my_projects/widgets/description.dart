import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../enum/remote_config.dart';
import '../../../../../res/fonts.dart';
import '../../../../../utils/common.dart';
import '../../../cubit/home_cubit.dart';

class ProjectDescription extends StatelessWidget {
  const ProjectDescription({
    Key? key,
    required this.link,
    required this.description,
    this.isPhone = false,
  }) : super(key: key);

  final String? link;
  final String? description;
  final bool isPhone;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildText(),
            const SizedBox(height: 8),
            _buildMoreInfoButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildText() {
    return Text(
      description ?? '',
      textAlign: TextAlign.center,
      style: isPhone
          ? MyAssetFonts.descriptionProjects
          : MyAssetFonts.descriptionName,
    );
  }

  Widget _buildMoreInfoButton(BuildContext context) {
    if (link != null && link!.isEmpty) {
      return Container();
    }

    final String moreInfoTitle = context
        .read<HomeCubit>()
        .getRemoteConfigString(RemoteConfigEnum.moreInfoText);
    return InkWell(
      onTap: () {
        Common.launch(link!);
      },
      child: Text(
        moreInfoTitle,
        style: MyAssetFonts.descriptionNameLink,
      ),
    );
  }
}
