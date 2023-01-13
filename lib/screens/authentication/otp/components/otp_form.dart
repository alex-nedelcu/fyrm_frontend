import 'package:flutter/material.dart';
import 'package:fyrm_frontend/components/default_button.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';

class OtpForm extends StatefulWidget {
  final void Function(String confirmationCode) onConfirmCallback;

  const OtpForm({Key? key, required this.onConfirmCallback}) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  String? confirmationCodeFirstCharacter;
  String? confirmationCodeSecondCharacter;
  String? confirmationCodeThirdCharacter;
  String? confirmationCodeFourthCharacter;
  String? confirmationCodeFifthCharacter;
  String? confirmationCodeSixthCharacter;

  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;
  FocusNode? pin6FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    pin5FocusNode!.dispose();
    pin6FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  void onConfirm() {
    String confirmationCode = _assembleConfirmationCode();
    widget.onConfirmCallback(confirmationCode);
  }

  String _assembleConfirmationCode() {
    return confirmationCodeFirstCharacter! +
        confirmationCodeSecondCharacter! +
        confirmationCodeThirdCharacter! +
        confirmationCodeFourthCharacter! +
        confirmationCodeFifthCharacter! +
        confirmationCodeSixthCharacter!;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(height: SizeConfiguration.screenHeight * 0.15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(45),
                height: getProportionateScreenHeight(50),
                child: TextFormField(
                  style: const TextStyle(fontSize: 18),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    confirmationCodeFirstCharacter = value;
                    nextField(value, pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(45),
                height: getProportionateScreenHeight(50),
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  style: const TextStyle(fontSize: 18),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    confirmationCodeSecondCharacter = value;
                    nextField(value, pin3FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(45),
                height: getProportionateScreenHeight(50),
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  style: const TextStyle(fontSize: 18),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    confirmationCodeThirdCharacter = value;
                    nextField(value, pin4FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(45),
                height: getProportionateScreenHeight(50),
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  style: const TextStyle(fontSize: 18),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    confirmationCodeFourthCharacter = value;
                    nextField(value, pin5FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(45),
                height: getProportionateScreenHeight(50),
                child: TextFormField(
                  focusNode: pin5FocusNode,
                  style: const TextStyle(fontSize: 18),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    confirmationCodeFifthCharacter = value;
                    nextField(value, pin6FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(45),
                height: getProportionateScreenHeight(50),
                child: TextFormField(
                  focusNode: pin6FocusNode,
                  style: const TextStyle(fontSize: 18),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    confirmationCodeSixthCharacter = value;
                    if (value.length == 1) {
                      pin6FocusNode!.unfocus();
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfiguration.screenHeight * 0.15),
          DefaultButton(
            text: "Confirm",
            press: onConfirm,
          )
        ],
      ),
    );
  }
}
