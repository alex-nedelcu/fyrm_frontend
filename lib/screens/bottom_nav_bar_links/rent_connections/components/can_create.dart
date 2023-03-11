import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fyrm_frontend/api/search_profile/dto/search_profile_dto.dart';
import 'package:fyrm_frontend/api/util/api_helper.dart';
import 'package:fyrm_frontend/components/default_button.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/helper/toast.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/providers/rent_connections_provider.dart';
import 'package:fyrm_frontend/providers/search_profile_provider.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/rent_connections/rent_connections_screen.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class CanCreate extends StatefulWidget {
  const CanCreate({Key? key}) : super(key: key);

  @override
  State<CanCreate> createState() => _CanCreateState();
}

class _CanCreateState extends State<CanCreate> {
  List<int> selectedSearchProfileIds = [];
  bool isToastShown = false;
  bool loading = false;

  void handleToast({int? statusCode, String? message}) {
    if (isToastShown) {
      return;
    }

    isToastShown = true;

    showToastWrapper(
      context: context,
      statusCode: statusCode,
      optionalMessage: message,
    );

    isToastShown = false;
  }

  @override
  Widget build(BuildContext context) {
    ConnectedUserProvider connectedUserProvider = Provider.of<ConnectedUserProvider>(context);
    RentConnectionsProvider rentConnectionsProvider = Provider.of<RentConnectionsProvider>(context);
    SearchProfileProvider searchProfileProvider = Provider.of<SearchProfileProvider>(context);

    return SafeArea(
      child: loading
          ? SpinKitThreeInOut(color: kSecondaryColor.withOpacity(0.5))
          : Padding(
              padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
              child: ListView(
                children: [
                  SizedBox(height: SizeConfiguration.screenHeight * 0.04),
                  buildGreeting(username: connectedUserProvider.username!),
                  SizedBox(height: SizeConfiguration.screenHeight * 0.02),
                  buildInformativeText(),
                  SizedBox(height: SizeConfiguration.screenHeight * 0.1),
                  buildSearchProfilesMultiSelect(searchProfileProvider.searchProfiles),
                  SizedBox(height: SizeConfiguration.screenHeight * 0.04),
                  buildSubmitButton(
                    rentConnectionsProvider: rentConnectionsProvider,
                    connectedUserProvider: connectedUserProvider,
                    searchProfileProvider: searchProfileProvider,
                  ),
                ],
              ),
            ),
    );
  }

  Padding buildSubmitButton({
    required RentConnectionsProvider rentConnectionsProvider,
    required ConnectedUserProvider connectedUserProvider,
    required SearchProfileProvider searchProfileProvider,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: DefaultButton(
        text: "Initiate",
        press: () async {
          if (selectedSearchProfileIds.isEmpty) {
            handleToast(message: "No search profiles selected");
          } else {
            setState(() {
              loading = true;
            });
            int statusCode = await rentConnectionsProvider.getRentConnectionProposal(
              tokenType: connectedUserProvider.tokenType!,
              token: connectedUserProvider.token!,
              initiatorId: connectedUserProvider.userId!,
              selectedSearchProfiles: searchProfileProvider.searchProfiles
                  .where((searchProfile) => selectedSearchProfileIds.contains(searchProfile.id!))
                  .toList(),
            );
            await Future<void>.delayed(const Duration(seconds: 1));
            setState(() {
              loading = false;
            });
            if (ApiHelper.isSuccess(statusCode) && mounted) {
              Navigator.pushNamed(context, RentConnectionsScreen.routeName);
            }
          }
        },
      ),
    );
  }

  Widget buildGreeting({required String username}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Hi, ",
          style: TextStyle(
            color: Colors.black,
            fontSize: getProportionateScreenWidth(22),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          username,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: getProportionateScreenWidth(22),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "!",
          style: TextStyle(
            color: Colors.black,
            fontSize: getProportionateScreenWidth(22),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildInformativeText() {
    return Text(
      "Looks like you don't have any active rent connection. It's time to initiate one and meet your future rent mate!",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: getProportionateScreenWidth(17),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildSearchProfilesMultiSelect(List<SearchProfileDto> searchProfiles) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: MultiSelectDialogField(
        items: searchProfiles.asMap().entries.map((entry) {
          final index = entry.key;
          final searchProfile = entry.value;
          return MultiSelectItem(searchProfile.id!, "#${index + 1}");
        }).toList(),
        decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.15),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: kSecondaryColor,
            width: 2,
          ),
        ),
        title: Text(
          "Tap the desired search profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: getProportionateScreenWidth(16),
            fontWeight: FontWeight.bold,
          ),
        ),
        searchable: false,
        dialogHeight: 50,
        confirmText: Text(
          "Confirm",
          style: TextStyle(
            color: Colors.black,
            fontSize: getProportionateScreenWidth(16),
            fontWeight: FontWeight.bold,
          ),
        ),
        cancelText: Text(
          "Cancel",
          style: TextStyle(
            color: Colors.black,
            fontSize: getProportionateScreenWidth(16),
            fontWeight: FontWeight.bold,
          ),
        ),
        buttonIcon: const Icon(
          Icons.arrow_drop_down_sharp,
          color: Colors.black,
        ),
        buttonText: Text(
          "Choose search profiles",
          style: TextStyle(
            color: Colors.black,
            fontSize: getProportionateScreenWidth(16),
            fontWeight: FontWeight.w400,
          ),
        ),
        listType: MultiSelectListType.CHIP,
        separateSelectedItems: false,
        selectedColor: kPrimaryColor.withOpacity(0.5),
        unselectedColor: kSecondaryColor.withOpacity(0.25),
        itemsTextStyle: TextStyle(
          fontSize: getProportionateScreenWidth(14),
          fontWeight: FontWeight.w300,
        ),
        selectedItemsTextStyle: TextStyle(
          fontSize: getProportionateScreenWidth(14),
          fontWeight: FontWeight.w300,
        ),
        onConfirm: (values) {
          selectedSearchProfileIds = values;
        },
      ),
    );
  }
}
