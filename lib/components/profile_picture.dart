import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePicture extends StatelessWidget {
  final double height;
  final double width;
  final double editIconRight;
  final bool isUpdatable;
  final void Function()? onProfilePicturePress;

  const ProfilePicture({
    Key? key,
    this.height = 115,
    this.width = 115,
    this.editIconRight = -5,
    this.isUpdatable = false,
    this.onProfilePicturePress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: onProfilePicturePress,
            child: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/profile-image.png"),
            ),
          ),
          if (isUpdatable)
            Positioned(
              right: editIconRight,
              bottom: 0,
              child: SizedBox(
                height: height / 2.5,
                width: width / 2.5,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: const BorderSide(color: Colors.white),
                    ),
                    backgroundColor: const Color(0xFFF5F6F9),
                  ),
                  onPressed: () {
                    // TODO: handle change profile picture icon click
                  },
                  child: SvgPicture.asset("assets/icons/photo-camera.svg"),
                ),
              ),
            )
        ],
      ),
    );
  }
}
