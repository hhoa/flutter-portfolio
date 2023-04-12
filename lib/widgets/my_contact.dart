import 'package:flutter/material.dart';
import 'package:flutter_app_web/res/constants.dart';

import 'package:flutter_app_web/res/fonts.dart';
import 'package:flutter_app_web/res/images.dart';
import 'package:flutter_app_web/utils/common.dart';
import 'package:flutter_app_web/widgets/special_name.dart';

class MyContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Container(
      height: screenHeight / 3,
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpecialTextName(),
          SizedBox(height: 20,),
          buildTextFollow(),
          SizedBox(height: 20,),
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

  ContactIcon(this.image, this.linkUrl);

  @override
  _ContactIconState createState() => _ContactIconState();
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
            duration: Duration(milliseconds: 200),
            opacity: isHover ? 1 : 0.3,
            child: Image.asset(
              widget.image, width: MyAssetFonts.oneRem, height: MyAssetFonts.oneRem,),
          ),
        ),
      ),
    );
  }
}
