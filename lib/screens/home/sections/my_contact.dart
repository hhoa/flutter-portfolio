import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../enum/remote_config.dart';
import '../../../model/contact_model.dart';
import '../../../res/fonts.dart';
import '../../../utils/common.dart';
import '../../../widgets/special_name.dart';
import '../cubit/home_cubit.dart';

class MyContact extends StatelessWidget {
  const MyContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final String myName = context
        .read<HomeCubit>()
        .getRemoteConfigString(RemoteConfigEnum.myNameText);

    return Container(
      height: screenHeight / 3,
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpecialTextName(myName),
          const SizedBox(height: 20),
          buildTextFollow(context),
          const SizedBox(height: 20),
          buildIcons(context),
        ],
      ),
    );
  }

  Widget buildTextFollow(BuildContext context) {
    final followMeTitle = context
        .read<HomeCubit>()
        .getRemoteConfigString(RemoteConfigEnum.followMeText);
    return Text(
      followMeTitle,
      style: MyAssetFonts.followText,
    );
  }

  Widget buildIcons(BuildContext context) {
    final List<ContactModel> contacts = contactModelFromJson(context
        .read<HomeCubit>()
        .getRemoteConfigString(RemoteConfigEnum.followMe));

    return Container(
      height: MyAssetFonts.oneRem,
      alignment: Alignment.center,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, int index) {
          final ContactModel model = contacts[index];
          if (model.isNull) {
            return Container();
          }
          return ContactIcon(model.icon!, model.link!);
        },
        separatorBuilder: (_, int index) => SizedBox(
            width: contacts[index].isNull ? 0 : MyAssetFonts.oneRem * 2),
        itemCount: contacts.length,
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
