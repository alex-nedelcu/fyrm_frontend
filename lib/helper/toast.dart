import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';

void showCustomToast({
  required String text,
  required BuildContext context,
  required Color backgroundColor,
}) {
  showToast(
    text,
    context: context,
    animation: StyledToastAnimation.slideFromRightFade,
    reverseAnimation: StyledToastAnimation.slideToRightFade,
    position: StyledToastPosition.top,
    animDuration: const Duration(milliseconds: 600),
    duration: const Duration(seconds: 3),
    curve: Curves.linear,
    reverseCurve: Curves.linearToEaseOut,
    borderRadius: BorderRadius.circular(12.0),
    textAlign: TextAlign.center,
    textStyle: TextStyle(
      fontSize: getProportionateScreenWidth(14),
      color: Colors.white,
    ),
    backgroundColor: backgroundColor,
    toastHorizontalMargin: 50.0,
  );
}
