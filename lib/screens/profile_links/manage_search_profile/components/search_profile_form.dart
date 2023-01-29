import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fyrm_frontend/api/location/LocationService.dart';
import 'package:fyrm_frontend/components/default_button.dart';
import 'package:fyrm_frontend/components/form_error.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/helper/keyboard.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/helper/toast.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SearchProfileForm extends StatefulWidget {
  final bool isCreate;

  const SearchProfileForm({super.key, required this.isCreate});

  @override
  _SearchProfileFormState createState() => _SearchProfileFormState();
}

class _SearchProfileFormState extends State<SearchProfileForm> {
  static const String uniqueMarkerId = "UNIQUE";
  static const double rentMaximumPrice = 800.0;
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final LocationService locationService = LocationService();
  final List<bool> isRentMateCountOptionSelected = [false, false, false, false];
  final List<String> associatedRentMateCountOptions = ['1', '2', '3', '> 3'];
  final List<bool> isRentMateGenderOptionSelected = [false, false, false];
  final List<Widget> associatedRentMateGenderOptions = [
    const Icon(Icons.man),
    const Icon(Icons.woman),
    Text(
      "any",
      style: TextStyle(
        color: kSecondaryColor,
        fontSize: getProportionateScreenWidth(14),
        fontWeight: FontWeight.bold,
      ),
    ),
  ];
  final List<bool> isBedroomOptionSelected = [false, false];
  final List<String> associatedBedroomOptions = ['own', 'shared'];
  final List<bool> isBathroomCountOptionSelected = [false, false, false];
  final List<String> associatedBathroomCountOptions = ['1', '2', '> 2'];
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  LatLng? desiredRentLocation;
  bool isToastShown = false;
  SfRangeValues rentPriceRange = const SfRangeValues(0.0, rentMaximumPrice);

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  void handleFormSubmission({required ConnectedUserProvider connectedUserProvider}) async {
    if (desiredRentLocation == null) {
      addError(error: kRentLocationNotSelected);
    }

    if (_formKey.currentState!.validate() && errors.isEmpty) {
      _formKey.currentState!.save();
      KeyboardUtil.hideKeyboard(context);

      // TODO: handle no selection for gender of rent mates, number of rent mates
      print(rentPriceRange.start);
      print(rentPriceRange.end);
      print(isRentMateCountOptionSelected);
      print(isRentMateGenderOptionSelected);
    } else {
      handleToast(message: kFormValidationErrorsMessage);
    }
  }

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

  Future<void> _addMarkerLongPressed(LatLng markerLatitudeLongitude) async {
    setState(() {
      const MarkerId markerId = MarkerId(uniqueMarkerId);
      Marker marker = Marker(
        markerId: markerId,
        draggable: true,
        position: markerLatitudeLongitude,
        infoWindow: const InfoWindow(title: "Desired rent location"),
        icon: BitmapDescriptor.defaultMarker,
      );

      markers[markerId] = marker;
      desiredRentLocation = marker.position;
      removeError(error: kRentLocationNotSelected);
    });

    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(markerLatitudeLongitude, 17.0));
  }

  @override
  Widget build(BuildContext context) {
    ConnectedUserProvider connectedUserProvider = Provider.of<ConnectedUserProvider>(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFormField(
            topSpacing: 15,
            title: "How much are you willing to pay?",
            helpNote: "unit is €/month",
            component: buildPriceRangeSlider(),
            textComponentSpacing: 10,
          ),
          buildFormField(
            topSpacing: 45,
            title: "Choose rent location",
            helpNote: "a 3km radius will be considered",
            component: FutureBuilder<Position>(
              future: locationService.getUserPosition(),
              builder: (context, snapshot) => snapshot.hasData
                  ? buildLocationPicker(userPosition: snapshot.requireData)
                  : SpinKitThreeInOut(color: kSecondaryColor.withOpacity(0.5)),
            ),
            textComponentSpacing: 15,
          ),
          buildFormField(
            topSpacing: 45,
            title: "Who do you want to stay with?",
            helpNote: "select one option",
            component: buildRentMateGendersToggleButtons(options: associatedRentMateGenderOptions),
            textComponentSpacing: 10,
          ),
          buildFormField(
            topSpacing: 20,
            title: "How many rent mates?",
            helpNote: "select multiple options",
            component: buildRentMateCountToggleButtons(options: associatedRentMateCountOptions),
            textComponentSpacing: 10,
          ),
          buildFormField(
            topSpacing: 20,
            title: "What about bedrooms?",
            helpNote: "select one option",
            component: buildBedroomToggleButtons(options: associatedBedroomOptions),
            textComponentSpacing: 10,
          ),
          buildFormField(
            topSpacing: 20,
            title: "How many bathrooms?",
            helpNote: "select multiple options",
            component: buildBathroomCountToggleButtons(options: associatedBathroomCountOptions),
            textComponentSpacing: 10,
            bottomSpacing: 15,
          ),
          if (errors.isNotEmpty) SizedBox(height: SizeConfiguration.screenHeight * 0.02),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: widget.isCreate ? "Create" : "Update",
            press: () => handleFormSubmission(connectedUserProvider: connectedUserProvider),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
        ],
      ),
    );
  }

  Widget buildFormField({
    required double topSpacing,
    required String title,
    required Widget component,
    required double textComponentSpacing,
    String? helpNote,
    double? bottomSpacing,
  }) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(topSpacing)),
        buildAlignedText(text: title, alignment: Alignment.centerLeft),
        if (helpNote != null) buildHelpNote(text: helpNote, alignment: Alignment.centerLeft),
        SizedBox(height: getProportionateScreenHeight(textComponentSpacing)),
        component,
        SizedBox(height: getProportionateScreenHeight(bottomSpacing ?? 0)),
      ],
    );
  }

  Widget buildLocationPicker({required Position userPosition}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      width: double.infinity,
      child: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: CameraPosition(
          target: LatLng(userPosition.latitude, userPosition.longitude),
          zoom: 15,
        ),
        zoomControlsEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) => _controller.complete(controller),
        compassEnabled: true,
        tiltGesturesEnabled: false,
        onLongPress: (latitudeLongitude) => _addMarkerLongPressed(latitudeLongitude),
        markers: Set<Marker>.of(markers.values),
      ),
    );
  }

  Align buildRentMateGendersToggleButtons({required List<Widget> options}) {
    List<Widget> styledOptions = withPadding(widgets: options, padding: 14.0);

    return Align(
      alignment: Alignment.centerLeft,
      child: ToggleButtons(
        borderWidth: 1.5,
        color: Colors.black.withOpacity(0.60),
        selectedColor: kPrimaryColor,
        selectedBorderColor: kPrimaryColor,
        fillColor: kPrimaryColor.withOpacity(0.02),
        splashColor: kPrimaryColor.withOpacity(0.08),
        hoverColor: kPrimaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
        constraints: const BoxConstraints(minHeight: 36),
        isSelected: isRentMateGenderOptionSelected,
        onPressed: (index) {
          setState(() {
            for (int buttonIndex = 0; buttonIndex < isRentMateGenderOptionSelected.length; buttonIndex++) {
              if (buttonIndex == index) {
                isRentMateGenderOptionSelected[buttonIndex] = true;
              } else {
                isRentMateGenderOptionSelected[buttonIndex] = false;
              }
            }
          });
        },
        children: styledOptions,
      ),
    );
  }

  Align buildRentMateCountToggleButtons({required List<String> options}) {
    List<Widget> styledOptions = withPadding(widgets: toTextWidgets(values: options, size: 14.0), padding: 14.0);

    return Align(
      alignment: Alignment.centerLeft,
      child: ToggleButtons(
        borderWidth: 1.5,
        color: Colors.black.withOpacity(0.60),
        selectedColor: kPrimaryColor,
        selectedBorderColor: kPrimaryColor,
        fillColor: kPrimaryColor.withOpacity(0.02),
        splashColor: kPrimaryColor.withOpacity(0.08),
        hoverColor: kPrimaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
        constraints: const BoxConstraints(minHeight: 36),
        isSelected: isRentMateCountOptionSelected,
        onPressed: (index) {
          setState(() {
            isRentMateCountOptionSelected[index] = !isRentMateCountOptionSelected[index];
          });
        },
        children: styledOptions,
      ),
    );
  }

  Align buildBedroomToggleButtons({required List<String> options}) {
    List<Widget> styledOptions = withPadding(widgets: toTextWidgets(values: options, size: 14.0), padding: 14.0);

    return Align(
      alignment: Alignment.centerLeft,
      child: ToggleButtons(
        borderWidth: 1.5,
        color: Colors.black.withOpacity(0.60),
        selectedColor: kPrimaryColor,
        selectedBorderColor: kPrimaryColor,
        fillColor: kPrimaryColor.withOpacity(0.02),
        splashColor: kPrimaryColor.withOpacity(0.08),
        hoverColor: kPrimaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
        constraints: BoxConstraints(minHeight: 36, minWidth: getProportionateScreenWidth(70)),
        isSelected: isBedroomOptionSelected,
        onPressed: (index) {
          setState(() {
            for (int buttonIndex = 0; buttonIndex < isBedroomOptionSelected.length; buttonIndex++) {
              if (buttonIndex == index) {
                isBedroomOptionSelected[buttonIndex] = true;
              } else {
                isBedroomOptionSelected[buttonIndex] = false;
              }
            }
          });
        },
        children: styledOptions,
      ),
    );
  }

  Align buildBathroomCountToggleButtons({required List<String> options}) {
    List<Widget> styledOptions = withPadding(widgets: toTextWidgets(values: options, size: 14.0), padding: 14.0);

    return Align(
      alignment: Alignment.centerLeft,
      child: ToggleButtons(
        borderWidth: 1.5,
        color: Colors.black.withOpacity(0.60),
        selectedColor: kPrimaryColor,
        selectedBorderColor: kPrimaryColor,
        fillColor: kPrimaryColor.withOpacity(0.02),
        splashColor: kPrimaryColor.withOpacity(0.08),
        hoverColor: kPrimaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
        constraints: const BoxConstraints(minHeight: 36),
        isSelected: isBathroomCountOptionSelected,
        onPressed: (index) {
          setState(() {
            isBathroomCountOptionSelected[index] = !isBathroomCountOptionSelected[index];
          });
        },
        children: styledOptions,
      ),
    );
  }

  SfRangeSlider buildPriceRangeSlider() {
    return SfRangeSlider(
      min: 0.0,
      max: rentMaximumPrice,
      values: rentPriceRange,
      interval: 200,
      showTicks: true,
      showLabels: true,
      enableTooltip: true,
      minorTicksPerInterval: 1,
      inactiveColor: kSecondaryColor.withOpacity(0.3),
      activeColor: kPrimaryColor,
      stepSize: 20.0,
      numberFormat: NumberFormat("€"),
      onChanged: (SfRangeValues values) {
        setState(() {
          rentPriceRange = values;
        });
      },
    );
  }

  Align buildAlignedText({required String text, required Alignment alignment}) {
    return Align(
      alignment: alignment,
      child: Text(
        text,
        style: TextStyle(
          color: kSecondaryColor,
          fontSize: getProportionateScreenWidth(16),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Align buildHelpNote({required String text, required Alignment alignment}) {
    return Align(
      alignment: alignment,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.mark_chat_read_outlined,
            color: kSecondaryColor.withOpacity(0.6),
            size: 15,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              color: Colors.black.withOpacity(0.4),
              fontSize: getProportionateScreenWidth(11),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> toTextWidgets({required List<String> values, required double size}) {
    return values.map((value) => buildStyledText(text: value, size: size)).toList();
  }

  List<Widget> withPadding({required List<Widget> widgets, required double padding}) {
    return widgets
        .map((widget) => Padding(padding: EdgeInsets.symmetric(horizontal: padding), child: widget))
        .toList();
  }

  Text buildStyledText({required String text, required double size}) {
    return Text(
      text,
      style: TextStyle(
        color: kSecondaryColor,
        fontSize: getProportionateScreenWidth(size),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
