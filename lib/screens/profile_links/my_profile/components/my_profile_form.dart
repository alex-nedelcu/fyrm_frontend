import 'package:flutter/material.dart';
import 'package:fyrm_frontend/api/user/user_service.dart';
import 'package:fyrm_frontend/api/util/api_helper.dart';
import 'package:fyrm_frontend/components/custom_suffix_icon_as_image.dart';
import 'package:fyrm_frontend/components/default_button.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/helper/keyboard.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/screens/profile_links/profile_menu/profile_menu_screen.dart';
import 'package:provider/provider.dart';

class MyProfileForm extends StatefulWidget {
  const MyProfileForm({super.key});

  @override
  _MyProfileFormState createState() => _MyProfileFormState();
}

class _MyProfileFormState extends State<MyProfileForm> {
  final UserService userService = UserService();
  final _formKey = GlobalKey<FormState>();
  late bool isSearching;
  bool switchedIsSearching = false;
  String? description;

  void handleFormSubmission(
      {required ConnectedUserProvider connectedUserProvider}) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      KeyboardUtil.hideKeyboard(context);

      int statusCode = await userService.updateUser(
        userId: connectedUserProvider.userId!,
        token: connectedUserProvider.token!,
        tokenType: connectedUserProvider.tokenType!,
        description: description,
        isSearching: isSearching,
      );

      if (ApiHelper.isSuccess(statusCode) && mounted) {
        connectedUserProvider.description = description;
        connectedUserProvider.isSearching = isSearching;
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          Navigator.pushReplacementNamed(context, ProfileMenuScreen.routeName);
        }
      }
    }
  }

  void initializeIsSearching(bool initialIsSearching) {
    isSearching = initialIsSearching;
  }

  @override
  Widget build(BuildContext context) {
    ConnectedUserProvider connectedUserProvider =
        Provider.of<ConnectedUserProvider>(context);
    if (!switchedIsSearching) {
      initializeIsSearching(connectedUserProvider.isSearching!);
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildReadOnlyField(
            content: connectedUserProvider.username!,
            label: "Username",
            svgIcon: "assets/icons/user-grey.svg",
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildReadOnlyField(
            content: connectedUserProvider.firstName!,
            label: "First name",
            svgIcon: "assets/icons/user-grey.svg",
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildReadOnlyField(
            content: connectedUserProvider.lastName!,
            label: "Last name",
            svgIcon: "assets/icons/user-grey.svg",
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildReadOnlyField(
            content: connectedUserProvider.birthYear!.toString(),
            label: "Birth year",
            svgIcon: "assets/icons/gift.svg",
            color: kSecondaryColor,
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildReadOnlyField(
            content: connectedUserProvider.gender!,
            label: "Gender",
            svgIcon: "assets/icons/lightning.svg",
            color: kSecondaryColor,
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildReadOnlyField(
            content: connectedUserProvider.email!,
            label: "Email",
            svgIcon: "assets/icons/envelope.svg",
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildReadOnlyField(
              content: connectedUserProvider.university!,
              label: "University",
              svgIcon: "assets/icons/star.svg",
              color: kSecondaryColor),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildDescriptionField(
              currentDescription: connectedUserProvider.description),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildIsSearchingSwitch(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Update",
            press: () => handleFormSubmission(
                connectedUserProvider: connectedUserProvider),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
        ],
      ),
    );
  }

  TextFormField buildReadOnlyField({
    required String content,
    required String label,
    required String svgIcon,
    Color? color,
  }) {
    return TextFormField(
      keyboardType: TextInputType.text,
      initialValue: content,
      readOnly: true,
      enabled: false,
      decoration: InputDecoration(
        floatingLabelStyle: const TextStyle(color: kPrimaryColor),
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: svgIcon,
          color: color,
        ),
      ),
    );
  }

  TextFormField buildDescriptionField({required String? currentDescription}) {
    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.text,
      initialValue: currentDescription,
      onSaved: (value) => description = value,
      onChanged: (value) {
        description = value;
      },
      maxLength: 180,
      maxLines: 5,
      decoration: const InputDecoration(
        floatingLabelStyle: TextStyle(color: kPrimaryColor),
        labelText: "Description",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  SwitchListTile buildIsSearchingSwitch() {
    return SwitchListTile(
      title: const Text('I am looking for a rent mate'),
      value: isSearching,
      activeColor: kPrimaryColor,
      onChanged: (bool value) {
        setState(() {
          isSearching = value;
          switchedIsSearching = true;
        });
      },
    );
  }
}
