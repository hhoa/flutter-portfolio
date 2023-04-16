import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../widgets/base_widget.dart';
import '../cubit/my_project_cubit.dart';
import 'description.dart';
import 'filter.dart';
import 'image.dart';

class ProjectImageDescription extends BaseWidget {
  const ProjectImageDescription(
    this.image, {
    Key? key,
    this.description,
    this.isCurrent = false,
    this.link,
  }) : super(key: key);

  final String image;
  final bool isCurrent;
  final String? description;
  final String? link;

  @override
  Widget buildPhone(BuildContext context) {
    return ImageDescriptionMobile(
      image,
      description: description,
      isCurrent: isCurrent,
      link: link,
    );
  }

  @override
  Widget buildTablet(BuildContext context) {
    return ImageDescriptionWeb(
      image,
      description: description,
      isCurrent: isCurrent,
      link: link,
    );
  }

  @override
  Widget buildWeb(BuildContext context) {
    return ImageDescriptionWeb(
      image,
      description: description,
      isCurrent: isCurrent,
      link: link,
    );
  }
}

class ImageDescriptionMobile extends StatefulWidget {
  const ImageDescriptionMobile(
    this.image, {
    Key? key,
    this.description,
    this.isCurrent = false,
    this.link,
  }) : super(key: key);

  final String image;
  final bool isCurrent;
  final String? description;
  final String? link;

  @override
  State<ImageDescriptionMobile> createState() => _ImageDescriptionMobileState();
}

class _ImageDescriptionMobileState extends State<ImageDescriptionMobile> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        isTapped = !isTapped;
        context
            .read<MyProjectCubit>()
            .updateFocus(image: widget.image, isFocus: isTapped);
      },
      child: BlocBuilder<MyProjectCubit, MyProjectState>(
        buildWhen: (prev, current) => current is MyProjectInFocus,
        builder: (context, state) {
          bool isTapped = false;
          String stateImage = '';
          if (state is MyProjectInFocus) {
            stateImage = state.image;
            isTapped = stateImage == widget.image ? state.isFocus : false;
          }

          final double sigma = isTapped ? 2 : 0.5;
          double opacity = 1;
          if (isTapped) {
            opacity = 0.15;
          } else {
            opacity = widget.isCurrent ? 1 : 0.5;
          }

          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ProjectImage(
                  opacity: opacity,
                  image: widget.image,
                ),
                ProjectFilter(sigma: sigma),
                if (isTapped)
                  ProjectDescription(
                    link: widget.link,
                    description: widget.description,
                    isPhone: true,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ImageDescriptionWeb extends StatelessWidget {
  const ImageDescriptionWeb(
    this.image, {
    Key? key,
    this.description,
    this.isCurrent = false,
    this.link,
  }) : super(key: key);

  final String image;
  final bool isCurrent;
  final String? description;
  final String? link;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: MouseRegion(
        onEnter: (_) {
          context
              .read<MyProjectCubit>()
              .updateFocus(image: image, isFocus: true);
        },
        onExit: (_) {
          context
              .read<MyProjectCubit>()
              .updateFocus(image: image, isFocus: false);
        },
        child: BlocBuilder<MyProjectCubit, MyProjectState>(
          buildWhen: (prev, current) => current is MyProjectInFocus,
          builder: (context, state) {
            bool isHover = false;
            String stateImage = '';
            if (state is MyProjectInFocus) {
              stateImage = state.image;
              isHover = stateImage == image ? state.isFocus : false;
            }

            final double sigma = isHover ? 2 : 0.5;
            double opacity = 1;
            if (isHover) {
              opacity = 0.15;
            } else {
              opacity = isCurrent ? 1 : 0.5;
            }

            return Stack(
              fit: StackFit.expand,
              children: [
                ProjectImage(
                  opacity: opacity,
                  image: image,
                ),
                ProjectFilter(sigma: sigma),
                if (isHover)
                  ProjectDescription(
                    link: link,
                    description: description,
                    isPhone: false,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
