import 'package:flutter/material.dart';
import 'package:fyrm_frontend/components/profile_picture.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/helper/date.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/screens/profile/profile_screen.dart';
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              buildTimer(1, getCurrentDate().month, kPrimaryColor),
              SizedBox(width: getProportionateScreenWidth(8)),
              buildTimer(1, getCurrentDate().day, kSecondaryColor),
            ],
          ),
          ProfilePicture(
            height: 48,
            width: 48,
            isUpdatable: false,
            onProfilePicturePress: () {
              Navigator.pushNamed(context, ProfileScreen.routeName);
            },
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
