import 'package:flutter/material.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';

class ProfilePicture extends StatelessWidget {
  final double height;
  final double width;
  final double editIconRight;
  final void Function()? onProfilePicturePress;

  const ProfilePicture({
    Key? key,
    this.height = 115,
    this.width = 115,
    this.editIconRight = -5,
    this.onProfilePicturePress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConnectedUserProvider connectedUserProvider =
        Provider.of<ConnectedUserProvider>(context);

    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: onProfilePicturePress,
            child: CircleAvatar(
              child: randomAvatar(
                connectedUserProvider.userId.hashCode.toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
