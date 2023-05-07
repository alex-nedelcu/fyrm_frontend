import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fyrm_frontend/api/location/location_service.dart';
import 'package:fyrm_frontend/api/search_profile/dto/search_profile_dto.dart';
import 'package:fyrm_frontend/api/util/api_helper.dart';
import 'package:fyrm_frontend/components/default_button.dart';
import 'package:fyrm_frontend/components/form_error.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/helper/keyboard.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/helper/toast.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/providers/search_profile_provider.dart';
import 'package:fyrm_frontend/screens/profile_links/manage_search_profile/components/form_enums.dart';
import 'package:fyrm_frontend/screens/profile_links/search_profiles/search_profiles_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SearchProfileForm extends StatefulWidget {
  final bool isCreate;
  final SearchProfileDto? searchProfile;

  const SearchProfileForm(
      {super.key, required this.isCreate, this.searchProfile});

  @override
  _SearchProfileFormState createState() => _SearchProfileFormState();
}

class _SearchProfileFormState extends State<SearchProfileForm> {
  static const String uniqueMarkerId = "UNIQUE";
  static const double rentMaximumPrice = 800.0;
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final LocationService locationService = LocationService();
  late int? maximumAgeGapInYears;
  late List<bool> isRentMateCountOptionSelected;
  late List<String> associatedRentMateCountOptions;
  late List<bool> isHobbyOptionSelected;
  late List<String> associatedHobbyOption;
  late List<bool> isRentMateGenderOptionSelected;
  late List<Widget> associatedRentMateGenderOptions;
  late List<bool> isBedroomOptionSelected;
  late List<String> associatedBedroomOptions;
  late List<bool> isBathroomCountOptionSelected;
  late List<String> associatedBathroomCountOptions;
  late Map<MarkerId, Marker> markers;
  late LatLng? desiredRentLocation;
  late SfRangeValues rentPriceRange;
  bool isToastShown = false;

  @override
  void initState() {
    super.initState();

    maximumAgeGapInYears = widget.searchProfile?.maximumAgeGapInYears;
    associatedRentMateCountOptions = RentMateCountOption.options;
    associatedHobbyOption = HobbyOption.options;
    associatedRentMateGenderOptions = RentMateGenderOption.icons;
    associatedBedroomOptions = BedroomOption.options;
    associatedBathroomCountOptions = BathroomCountOption.options;

    isRentMateCountOptionSelected = initializeOptions(
      allOptions: RentMateCountOption.options,
      selectedOptions: widget.searchProfile?.rentMateCountOptions,
    );
    isHobbyOptionSelected = initializeOptions(
      allOptions: HobbyOption.options,
      selectedOptions: widget.searchProfile?.hobbyOptions,
    );
    isRentMateGenderOptionSelected = initializeOptions(
      allOptions: RentMateGenderOption.options,
      selectedOptions: widget.searchProfile?.rentMatesGenderOptions,
    );
    isBedroomOptionSelected = initializeOptions(
      allOptions: BedroomOption.options,
      selectedOptions: widget.searchProfile?.bedroomOptions,
    );
    isBathroomCountOptionSelected = initializeOptions(
      allOptions: BathroomCountOption.options,
      selectedOptions: widget.searchProfile?.bathroomOptions,
    );

    markers = initializeMarkersAndRentLocation(
      latitude: widget.searchProfile?.latitude,
      longitude: widget.searchProfile?.longitude,
    );

    rentPriceRange = initializeRentPriceRange(
      lowerBound: widget.searchProfile?.rentPriceLowerBound,
      upperBound: widget.searchProfile?.rentPriceUpperBound,
    );
  }

  List<bool> initializeOptions({
    required List<String> allOptions,
    List<String>? selectedOptions,
  }) {
    bool defaultValue = false;
    List<bool> options =
        List.filled(allOptions.length, defaultValue, growable: false);

    if (selectedOptions == null) {
      return options;
    }

    for (int index = 0; index < selectedOptions.length; index += 1) {
      String selected = selectedOptions[index];
      int globalIndex = allOptions.indexOf(selected);
      options[globalIndex] = true;
    }

    return options;
  }

  Map<MarkerId, Marker> initializeMarkersAndRentLocation(
      {double? latitude, double? longitude}) {
    Map<MarkerId, Marker> initialMarkers = {};

    if (latitude == null || longitude == null) {
      desiredRentLocation = null;
      return initialMarkers;
    }

    const MarkerId markerId = MarkerId(uniqueMarkerId);
    LatLng markerLatitudeLongitude = LatLng(latitude, longitude);

    Marker marker = Marker(
      markerId: markerId,
      draggable: true,
      position: markerLatitudeLongitude,
      infoWindow: const InfoWindow(title: "Desired rent location"),
      icon: BitmapDescriptor.defaultMarker,
    );

    initialMarkers[markerId] = marker;
    desiredRentLocation = marker.position;

    _controller.future.then((controller) {
      controller.animateCamera(
          CameraUpdate.newLatLngZoom(markerLatitudeLongitude, 17.0));
    });

    return initialMarkers;
  }

  SfRangeValues initializeRentPriceRange({
    required num? lowerBound,
    required num? upperBound,
  }) {
    return SfRangeValues(lowerBound ?? 0.0, upperBound ?? rentMaximumPrice);
  }

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

  void handleFormSubmission() async {
    catchValidationErrors();

    if (_formKey.currentState!.validate() && errors.isEmpty) {
      ConnectedUserProvider connectedUserProvider =
          Provider.of<ConnectedUserProvider>(context, listen: false);
      SearchProfileProvider searchProfileProvider =
          Provider.of<SearchProfileProvider>(context, listen: false);

      _formKey.currentState!.save();
      KeyboardUtil.hideKeyboard(context);

      int statusCode = widget.isCreate
          ? await searchProfileProvider.create(
              userId: connectedUserProvider.userId!,
              tokenType: connectedUserProvider.tokenType!,
              token: connectedUserProvider.token!,
              rentPriceLowerBound: rentPriceRange.start as num,
              rentPriceUpperBound: rentPriceRange.end as num,
              latitude: desiredRentLocation!.latitude,
              longitude: desiredRentLocation!.longitude,
              maximumAgeGapInYears: maximumAgeGapInYears!,
              rentMatesGenderOptions: RentMateGenderOption.findSelectedOptions(
                  isRentMateGenderOptionSelected),
              hobbyOptions:
                  HobbyOption.findSelectedOptions(isHobbyOptionSelected),
              rentMateCountOptions: RentMateCountOption.findSelectedOptions(
                  isRentMateCountOptionSelected),
              bedroomOptions:
                  BedroomOption.findSelectedOptions(isBedroomOptionSelected),
              bathroomOptions: BathroomCountOption.findSelectedOptions(
                  isBathroomCountOptionSelected),
            )
          : await searchProfileProvider.update(
              id: widget.searchProfile!.id!,
              userId: connectedUserProvider.userId!,
              tokenType: connectedUserProvider.tokenType!,
              token: connectedUserProvider.token!,
              rentPriceLowerBound: rentPriceRange.start as num,
              rentPriceUpperBound: rentPriceRange.end as num,
              latitude: desiredRentLocation!.latitude,
              longitude: desiredRentLocation!.longitude,
              maximumAgeGapInYears: maximumAgeGapInYears!,
              rentMatesGenderOptions: RentMateGenderOption.findSelectedOptions(
                  isRentMateGenderOptionSelected),
              rentMateCountOptions: RentMateCountOption.findSelectedOptions(
                  isRentMateCountOptionSelected),
              hobbyOptions:
                  HobbyOption.findSelectedOptions(isHobbyOptionSelected),
              bedroomOptions:
                  BedroomOption.findSelectedOptions(isBedroomOptionSelected),
              bathroomOptions: BathroomCountOption.findSelectedOptions(
                  isBathroomCountOptionSelected),
            );

      if (ApiHelper.isSuccess(statusCode) && mounted) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          Navigator.pushNamed(context, SearchProfilesScreen.routeName);
        }

        handleToast(
          statusCode: statusCode,
          message: widget.isCreate
              ? kSearchProfileCreateSuccess
              : kSearchProfileUpdateSuccess,
        );
      }
    } else {
      handleToast(message: kFormValidationErrorsMessage);
    }
  }

  void catchValidationErrors() {
    if (noOptionSelected(isRentMateGenderOptionSelected)) {
      addError(error: kRentMateGenderNotSelected);
    }

    if (noOptionSelected(isHobbyOptionSelected)) {
      addError(error: kHobbyNotSelected);
    }

    if (noOptionSelected(isRentMateCountOptionSelected)) {
      addError(error: kRentMateCountNotSelected);
    }

    if (noOptionSelected(isBedroomOptionSelected)) {
      addError(error: kBedroomOptionNotSelected);
    }

    if (noOptionSelected(isBathroomCountOptionSelected)) {
      addError(error: kBathroomCountNotSelected);
    }

    if (desiredRentLocation == null) {
      addError(error: kRentLocationNotSelected);
    }
  }

  bool noOptionSelected(List<bool> selection) {
    return !selection.contains(true);
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
    controller.animateCamera(
        CameraUpdate.newLatLngZoom(markerLatitudeLongitude, 17.0));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFormField(
            topSpacing: 10,
            title: "How much are you willing to pay?",
            helpNote: "unit is €/month",
            component: buildPriceRangeSlider(),
            textComponentSpacing: 10,
          ),
          buildFormField(
            topSpacing: 40,
            title: "Who do you want to stay with?",
            helpNote: "select one option",
            component: buildRentMateGendersToggleButtons(
                options: associatedRentMateGenderOptions),
            textComponentSpacing: 10,
          ),
          buildFormField(
            topSpacing: 25,
            title: "How many rent mates?",
            helpNote: "select multiple options",
            component: buildRentMateCountToggleButtons(
                options: associatedRentMateCountOptions),
            textComponentSpacing: 10,
          ),
          buildFormField(
            topSpacing: 25,
            title: "Maximum age gap to other rent mates",
            helpNote: "type a positive number",
            component: buildMaximumAgeGapField(),
            textComponentSpacing: 10,
          ),
          buildFormField(
            topSpacing: 25,
            title: "What about bedrooms?",
            helpNote: "select one option",
            component:
                buildBedroomToggleButtons(options: associatedBedroomOptions),
            textComponentSpacing: 10,
          ),
          buildFormField(
            topSpacing: 25,
            title: "How many bathrooms?",
            helpNote: "select multiple options",
            component: buildBathroomCountToggleButtons(
                options: associatedBathroomCountOptions),
            textComponentSpacing: 10,
          ),
          buildFormField(
            topSpacing: 25,
            title: "Choose some hobbies or interests",
            helpNote: "select multiple options",
            component:
                buildHobbiesToggleButtons(options: associatedHobbyOption),
            textComponentSpacing: 10,
            bottomSpacing: 15,
          ),
          buildFormField(
            topSpacing: 25,
            title: "Choose rent location",
            helpNote: "an approximate radius will be considered",
            component: FutureBuilder<Position>(
              future: locationService.getUserPosition(),
              builder: (context, snapshot) => snapshot.hasData
                  ? buildLocationPicker(userPosition: snapshot.requireData)
                  : SpinKitThreeInOut(color: kSecondaryColor.withOpacity(0.5)),
            ),
            textComponentSpacing: 15,
          ),
          if (errors.isNotEmpty)
            SizedBox(height: SizeConfiguration.screenHeight * 0.02),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(35)),
          DefaultButton(
            text: widget.isCreate ? "Create" : "Update",
            press: () => handleFormSubmission(),
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
        if (helpNote != null)
          buildHelpNote(text: helpNote, alignment: Alignment.centerLeft),
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
        onMapCreated: (GoogleMapController controller) =>
            _controller.complete(controller),
        compassEnabled: true,
        tiltGesturesEnabled: false,
        onLongPress: (latitudeLongitude) {
          removeError(error: kRentLocationNotSelected);
          _addMarkerLongPressed(latitudeLongitude);
        },
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        },
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
          removeError(error: kRentMateGenderNotSelected);
          setState(() {
            for (int buttonIndex = 0;
                buttonIndex < isRentMateGenderOptionSelected.length;
                buttonIndex++) {
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

  Widget buildMaximumAgeGapField() {
    return TextFormField(
      initialValue: maximumAgeGapInYears?.toString(),
      autocorrect: false,
      maxLines: null,
      style: const TextStyle(fontSize: 18),
      onChanged: (value) {
        if (int.tryParse(value) == null ||
            (int.tryParse(value) != null && int.parse(value) < 0)) {
          addError(error: kInvalidMaximumAgeGap);
        } else {
          removeError(error: kInvalidMaximumAgeGap);
        }

        maximumAgeGapInYears = int.tryParse(value);
      },
      validator: (value) {
        if (value == null ||
            int.tryParse(value) == null ||
            (int.tryParse(value) != null && int.parse(value) < 0)) {
          addError(error: kInvalidMaximumAgeGap);
        }

        return null;
      },
      keyboardType: TextInputType.number,
      textAlign: TextAlign.left,
      cursorColor: kSecondaryColor,
      decoration: const InputDecoration(
        hintText: "Maximum age gap in years...",
        hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),
        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
        floatingLabelStyle: TextStyle(color: kSecondaryColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onSaved: (value) => maximumAgeGapInYears = int.tryParse(value!),
    );
  }

  Align buildRentMateCountToggleButtons({required List<String> options}) {
    List<Widget> styledOptions = withPadding(
        widgets: toTextWidgets(values: options, size: 14.0), padding: 14.0);

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
          removeError(error: kRentMateCountNotSelected);
          setState(() {
            isRentMateCountOptionSelected[index] =
                !isRentMateCountOptionSelected[index];
          });
        },
        children: styledOptions,
      ),
    );
  }

  Align buildHobbiesToggleButtons({required List<String> options}) {
    List<Widget> styledOptions = withPadding(
        widgets: toTextWidgets(values: options, size: 14.0), padding: 14.0);

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
        isSelected: isHobbyOptionSelected,
        onPressed: (index) {
          removeError(error: kHobbyNotSelected);
          setState(() {
            isHobbyOptionSelected[index] = !isHobbyOptionSelected[index];
          });
        },
        children: styledOptions,
      ),
    );
  }

  Align buildBedroomToggleButtons({required List<String> options}) {
    List<Widget> styledOptions = withPadding(
        widgets: toTextWidgets(values: options, size: 14.0), padding: 14.0);

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
        constraints: BoxConstraints(
            minHeight: 36, minWidth: getProportionateScreenWidth(70)),
        isSelected: isBedroomOptionSelected,
        onPressed: (index) {
          removeError(error: kBedroomOptionNotSelected);
          setState(() {
            for (int buttonIndex = 0;
                buttonIndex < isBedroomOptionSelected.length;
                buttonIndex++) {
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
    List<Widget> styledOptions = withPadding(
        widgets: toTextWidgets(values: options, size: 14.0), padding: 14.0);

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
          removeError(error: kBathroomCountNotSelected);
          setState(() {
            isBathroomCountOptionSelected[index] =
                !isBathroomCountOptionSelected[index];
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

  List<Widget> toTextWidgets(
      {required List<String> values, required double size}) {
    return values
        .map((value) => buildStyledText(text: value, size: size))
        .toList();
  }

  List<Widget> withPadding(
      {required List<Widget> widgets, required double padding}) {
    return widgets
        .map((widget) => Padding(
            padding: EdgeInsets.symmetric(horizontal: padding), child: widget))
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
