import 'package:flutter/material.dart';

import '../res/constants.dart';
import '../res/fonts.dart';
import '../res/images.dart';
import '../utils/common.dart';
import 'special_name.dart';

class MyContact extends StatelessWidget {
  const MyContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight / 3,
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpecialTextName(),
          const SizedBox(
            height: 20,
          ),
          buildTextFollow(),
          const SizedBox(
            height: 20,
          ),
          buildIcons(),
        ],
      ),
    );
  }

  Widget buildTextFollow() {
    return Text(
      "FOLLOW ME",
      style: MyAssetFonts.followText,
    );
  }

  Widget buildIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ContactIcon(MyAssetImages.imageFacebook, MyConstants.linkFb),
        ContactIcon(MyAssetImages.imageSkype, MyConstants.linkSkype),
        ContactIcon(MyAssetImages.imageLinkedin, MyConstants.linkLinkedin),
        ContactIcon(MyAssetImages.imageGithub, MyConstants.linkGithub),
      ],
    );
  }
}

class ContactIcon extends StatefulWidget {
  final String image;
  final String linkUrl;

  const ContactIcon(this.image, this.linkUrl, {Key? key}) : super(key: key);

  @override
  State<ContactIcon> createState() => _ContactIconState();
}

class _ContactIconState extends State<ContactIcon> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHover = false;
          });
        },
        child: InkWell(
          onTap: () {
            Common.launch(widget.linkUrl);
          },
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isHover ? 1 : 0.3,
            child: Image.asset(
              widget.image,
              width: MyAssetFonts.oneRem,
              height: MyAssetFonts.oneRem,
            ),
          ),
        ),
      ),
    );
  }
}
