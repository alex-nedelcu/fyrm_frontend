import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyrm_frontend/api/user/user_service.dart';
import 'package:fyrm_frontend/api/util/api_helper.dart';
import 'package:fyrm_frontend/components/custom_suffix_icon.dart';
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

  void handleFormSubmission({required ConnectedUserProvider connectedUserProvider}) async {
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
        Navigator.pushReplacementNamed(context, ProfileMenuScreen.routeName);
      }
    }
  }

  void initializeIsSearching(bool initialIsSearching) {
    isSearching = initialIsSearching;
  }

  @override
  Widget build(BuildContext context) {
    ConnectedUserProvider connectedUserProvider = Provider.of<ConnectedUserProvider>(context);
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
            content: connectedUserProvider.email!,
            label: "Email",
            svgIcon: "assets/icons/envelope.svg",
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildReadOnlyField(
            content: connectedUserProvider.birthDate!,
            label: "Birth date",
            svgIcon: "assets/icons/heart-empty.svg",
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildDescriptionField(currentDescription: connectedUserProvider.description),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildIsSearchingSwitch(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Update",
            press: () => handleFormSubmission(connectedUserProvider: connectedUserProvider),
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
  }) {
    return TextFormField(
      keyboardType: TextInputType.text,
      initialValue: content,
      readOnly: true,
      enabled: false,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: svgIcon),
      ),
    );
  }

  TextFormField buildDescriptionField({required String? currentDescription}) {
    return TextFormField(
      keyboardType: TextInputType.text,
      initialValue: currentDescription,
      onSaved: (value) => description = value,
      onChanged: (value) {
        description = value;
      },
      maxLength: 180,
      maxLines: 5,
      decoration: const InputDecoration(
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
