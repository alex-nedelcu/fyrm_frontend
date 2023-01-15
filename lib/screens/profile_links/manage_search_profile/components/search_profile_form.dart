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
import 'package:provider/provider.dart';

class SearchProfileForm extends StatefulWidget {
  final bool isCreate;

  const SearchProfileForm({super.key, required this.isCreate});

  @override
  _SearchProfileFormState createState() => _SearchProfileFormState();
}

class _SearchProfileFormState extends State<SearchProfileForm> {
  static const String uniqueMarkerId = "UNIQUE";
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final LocationService locationService = LocationService();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  LatLng? desiredRentLocation;
  bool isToastShown = false;

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
          SizedBox(height: getProportionateScreenHeight(30)),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Long press on the desired rent location",
              style: TextStyle(
                color: kSecondaryColor,
                fontSize: getProportionateScreenWidth(16),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          FutureBuilder<Position>(
            future: locationService.getUserPosition(),
            builder: (context, snapshot) => snapshot.hasData
                ? buildLocationPicker(userPosition: snapshot.requireData)
                : SpinKitThreeInOut(color: kSecondaryColor.withOpacity(0.5)),
          ),
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
