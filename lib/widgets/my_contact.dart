import 'package:flutter/material.dart';

import '../enum/remote_config.dart';
import '../model/contact_model.dart';
import '../res/fonts.dart';
import '../utils/common.dart';
import '../utils/remote_config.dart';
import 'special_name.dart';

class MyContact extends StatelessWidget {
  MyContact({Key? key}) : super(key: key) {
    listContacts = contactModelFromJson(
        RemoteConfigUtils.getValueString(RemoteConfigEnum.followMe.key));
  }

  late final List<ContactModel> listContacts;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight / 3,
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpecialTextName(),
          const SizedBox(height: 20),
          buildTextFollow(),
          const SizedBox(height: 20),
          buildIcons(),
        ],
      ),
    );
  }

  Widget buildTextFollow() {
    final followMeTitle =
        RemoteConfigUtils.getValueString(RemoteConfigEnum.followMeText.key);
    return Text(
      followMeTitle,
      style: MyAssetFonts.followText,
    );
  }

  Widget buildIcons() {
    return Container(
      height: MyAssetFonts.oneRem,
      alignment: Alignment.center,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, int index) {
          final ContactModel model = listContacts[index];
          if (model.isNull) {
            return Container();
          }
          return ContactIcon(model.icon!, model.link!);
        },
        separatorBuilder: (_, int index) => SizedBox(
            width: listContacts[index].isNull ? 0 : MyAssetFonts.oneRem * 2),
        itemCount: listContacts.length,
      ),
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
    return MouseRegion(
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
          child: Image.network(
            widget.image,
            width: MyAssetFonts.oneRem,
            height: MyAssetFonts.oneRem,
          ),
        ),
      ),
    );
  }
}
