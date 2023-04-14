import 'package:flutter/material.dart';

import '../enum/remote_config.dart';
import '../res/fonts.dart';
import '../utils/remote_config.dart';

class SpecialTextName extends StatelessWidget {
  const SpecialTextName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String myName =
        RemoteConfigUtils.getValueString(RemoteConfigEnum.myNameText.key);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: Text(
          myName,
          style: MyAssetFonts.specialAppBarText,
        ),
      ),
    );
  }
}
