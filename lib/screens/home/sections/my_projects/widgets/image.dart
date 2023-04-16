import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../res/images.dart';

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
      child: CachedNetworkImage(
        imageUrl: image,
        placeholder: (_, url) {
          return Image.asset(
            MyAssetImages.verticalPlaceholder,
            fit: BoxFit.fitHeight,
          );
        },
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
