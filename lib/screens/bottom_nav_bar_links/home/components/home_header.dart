import 'package:flutter/material.dart';
import 'package:fyrm_frontend/components/profile_picture.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/helper/date.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/screens/profile_links/profile_menu/profile_menu_screen.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  CustomDate getCurrentDate() {
    DateTime now = DateTime.now();
    return CustomDate(
      day: DateFormat.d().format(now),
      month: DateFormat.MMMM().format(now),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding * 2.5),
      height: size.height * 0.25,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: kDefaultPadding,
            ),
            height: size.height * 0.2,
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(1),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 75),
              child: Row(
                children: <Widget>[
                  buildTimer(1, getCurrentDate().month, Colors.white),
                  SizedBox(width: getProportionateScreenWidth(8)),
                  buildTimer(1, getCurrentDate().day, Colors.white70),
                  const Spacer(),
                  ProfilePicture(
                    height: 64,
                    width: 64,
                    isUpdatable: false,
                    onProfilePicturePress: () {
                      Navigator.pushNamed(context, ProfileMenuScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TimerBuilder buildTimer(int refreshRateInHours, String content, Color color) {
    return TimerBuilder.periodic(
      Duration(hours: refreshRateInHours),
      builder: (context) {
        return Text(
          content,
          style: TextStyle(
            color: color,
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        );
      },
    );
  }
}
