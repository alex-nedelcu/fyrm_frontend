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
  final List<String> associatedRentMateGenderOptions = ['M', 'F', 'any'];
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
      print(rentPriceRange.start);
      print(rentPriceRange.end);
      print(isRentMateCountOptionSelected);
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
          SizedBox(height: getProportionateScreenHeight(15)),
          buildAlignedText(text: "Select rent price range", alignment: Alignment.centerLeft),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildPriceRangeSlider(),
          SizedBox(height: getProportionateScreenHeight(45)),
          buildAlignedText(text: "Long press on the desired rent location", alignment: Alignment.centerLeft),
          SizedBox(height: getProportionateScreenHeight(15)),
          FutureBuilder<Position>(
            future: locationService.getUserPosition(),
            builder: (context, snapshot) => snapshot.hasData
                ? buildLocationPicker(userPosition: snapshot.requireData)
                : SpinKitThreeInOut(color: kSecondaryColor.withOpacity(0.5)),
          ),
          SizedBox(height: getProportionateScreenHeight(45)),
          buildAlignedText(text: "Pick gender of rent mates", alignment: Alignment.centerLeft),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildRentMateGendersToggleButtons(options: associatedRentMateGenderOptions),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildAlignedText(text: "Pick number of rent mates", alignment: Alignment.centerLeft),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildRentMateCountToggleButtons(options: associatedRentMateCountOptions),
          SizedBox(height: getProportionateScreenHeight(15)),
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

  Align buildRentMateGendersToggleButtons({required List<String> options}) {
    List<Widget> optionsToWidgets = options
        .map((option) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: buildStyledText(text: option, size: 14),
            ))
        .toList();

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
        children: optionsToWidgets,
      ),
    );
  }

  Align buildRentMateCountToggleButtons({required List<String> options}) {
    List<Widget> optionsToWidgets = options
        .map((option) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: buildStyledText(text: option, size: 14),
            ))
        .toList();

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
        children: optionsToWidgets,
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
}
