import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:fyrm_frontend/helper/constants.dart';

class StatisticsBar extends StatelessWidget {
  final String text;
  final int value;
  final IconData icon;

  const StatisticsBar({
    Key? key,
    required this.text,
    required this.value,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: kPrimaryColor,
            size: 25,
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 17),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          AnimatedDigitWidget(
            value: value,
            textStyle: const TextStyle(
              fontSize: 20,
              color: kPrimaryColor,
              fontWeight: FontWeight.w400,
            ),
            duration: const Duration(seconds: 2),
          ),
          const Divider(color: Colors.black, thickness: 0.5, height: 100),
        ],
      ),
    );
  }
}
