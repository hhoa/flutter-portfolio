import 'dart:ui';

import 'package:flutter/material.dart';

class ProjectFilter extends StatelessWidget {
  const ProjectFilter({Key? key, required this.sigma}) : super(key: key);

  final double sigma;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: sigma,
        sigmaY: sigma,
      ),
      child: Container(),
    );
  }
}
