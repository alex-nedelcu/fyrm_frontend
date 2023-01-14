import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fyrm_frontend/helper/keyboard.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SearchProfileForm extends StatefulWidget {
  final bool isCreate;

  const SearchProfileForm({super.key, required this.isCreate});

  @override
  _SearchProfileFormState createState() => _SearchProfileFormState();
}

class _SearchProfileFormState extends State<SearchProfileForm> {
  final _formKey = GlobalKey<FormState>();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  void handleFormSubmission({required ConnectedUserProvider connectedUserProvider}) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      KeyboardUtil.hideKeyboard(context);
      // TODO: continue handling create/update search profile form submission
    }
  }

  @override
  Widget build(BuildContext context) {
    ConnectedUserProvider connectedUserProvider = Provider.of<ConnectedUserProvider>(context);

    return Form(
      key: _formKey,
      child: buildLocationPicker(),
      // child: Column(
      //   children: [
      //     SizedBox(height: getProportionateScreenHeight(30)),
      //     // TODO: add all the search profile dimensions but start with location picker
      //     buildLocationPicker(),
      //     DefaultButton(
      //       text: widget.isCreate ? "Create" : "Update",
      //       press: () => handleFormSubmission(connectedUserProvider: connectedUserProvider),
      //     ),
      //     SizedBox(height: getProportionateScreenHeight(30)),
      //   ],
      // ),
    );
  }

  Future _addMarkerLongPressed(LatLng latlang) async {
    setState(() {
      final MarkerId markerId = MarkerId("RANDOM_ID");
      Marker marker = Marker(
        markerId: markerId,
        draggable: true,
        position: latlang, //With this parameter you automatically obtain latitude and longitude
        infoWindow: InfoWindow(
          title: "Marker here",
          snippet: 'This looks good',
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      markers[markerId] = marker;
    });

    //This is optional, it will zoom when the marker has been created
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(latlang, 17.0));
  }

  Widget buildLocationPicker() {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 2.5,
          width: double.infinity,
          child: GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: CameraPosition(
              target: LatLng(47.7, 23.6),
              zoom: 10,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            compassEnabled: true,
            tiltGesturesEnabled: false,
            onLongPress: (latlang) {
              _addMarkerLongPressed(latlang); //we will call this function when pressed on the map
            },
            markers: Set<Marker>.of(markers.values),
          ),
        ),
        // Positioned(
        //   top: 15,
        //   left: 10,
        //   right: 10,
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: TextField(
        //       autocorrect: false,
        //       decoration: InputDecoration(
        //         filled: true,
        //         fillColor: Colors.white,
        //         hintText: "Enter rent location...",
        //         suffixIcon: const Icon(Icons.search, color: kSecondaryColor),
        //         contentPadding: const EdgeInsets.only(left: 20, bottom: 5, right: 5),
        //         focusedBorder: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(10),
        //           borderSide: const BorderSide(color: Colors.white),
        //         ),
        //         enabledBorder: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(10),
        //           borderSide: const BorderSide(color: Colors.white),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
