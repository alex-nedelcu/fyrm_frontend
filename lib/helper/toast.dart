import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:fyrm_frontend/api/util/api_helper.dart';
import 'package:fyrm_frontend/helper/constants.dart';
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

void showToastByCase({
  required BuildContext context,
  int? statusCode,
  String? optionalMessage,
}) {
  String? text = optionalMessage;

  if (text == null) {
    if (ApiHelper.isUnauthorized(statusCode)) {
      text = kBadCredentials;
    }

    if (ApiHelper.isServerError(statusCode)) {
      text = kDefaultErrorMessage;
    }

    if (ApiHelper.isSuccess(statusCode)) {
      text = kDefaultSuccessMessage;
    }

    if (ApiHelper.isExpectedError(statusCode)) {
      text = kDefaultErrorMessage;
    }
  }

  showCustomToast(
    text: text!,
    context: context,
    backgroundColor: ApiHelper.isSuccess(statusCode) ? kSuccessColor : kFailureColor,
  );
}
