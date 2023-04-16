import 'package:flutter/material.dart';

class ProjectImage extends StatelessWidget {
  const ProjectImage({
    Key? key,
    required this.opacity,
    required this.image,
  }) : super(key: key);

  final double opacity;
  final String image;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: opacity,
      child: Image.network(
        image,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
