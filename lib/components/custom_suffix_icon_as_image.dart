import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';

class CustomSuffixIcon extends StatelessWidget {
  const CustomSuffixIcon({
    Key? key,
    required this.svgIcon,
    this.color,
  }) : super(key: key);

  final String svgIcon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
      ),
      child: SvgPicture.asset(
        svgIcon,
        height: getProportionateScreenWidth(18),
        color: color,
      ),
    );
  }
}
