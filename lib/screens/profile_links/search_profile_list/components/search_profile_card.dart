import 'package:flutter/material.dart';
import 'package:fyrm_frontend/api/search_profile/dto/search_profile_dto.dart';
import 'package:fyrm_frontend/api/util/api_helper.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/helper/toast.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/providers/search_profile_provider.dart';
import 'package:fyrm_frontend/screens/profile_links/manage_search_profile/manage_search_profile_screen.dart';
import 'package:provider/provider.dart';

class SearchProfileCard extends StatefulWidget {
  final SearchProfileDto searchProfile;
  final int index;

  const SearchProfileCard(
      {Key? key, required this.searchProfile, required this.index})
      : super(key: key);

  @override
  State<SearchProfileCard> createState() => _SearchProfileCardState();
}

class _SearchProfileCardState extends State<SearchProfileCard> {
  bool isToastShown = false;

  String listToCommaSeparatedValues({required List<String> list}) {
    return list.reduce((value, element) => "$value, $element");
  }

  void handleToast({Color? color, int? statusCode, String? message}) {
    if (isToastShown) {
      return;
    }

    isToastShown = true;

    showToastWrapper(
      context: context,
      statusCode: statusCode,
      optionalMessage: message,
      color: color,
    );

    isToastShown = false;
  }

  @override
  Widget build(BuildContext context) {
    ConnectedUserProvider connectedUserProvider =
        Provider.of<ConnectedUserProvider>(context);
    SearchProfileProvider searchProfileProvider =
        Provider.of<SearchProfileProvider>(context);
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ManageSearchProfileScreen.routeName,
          arguments: ManageSearchProfileScreenArguments(
              isCreate: false, searchProfile: widget.searchProfile),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 3,
        ),
        height: 175,
        child: InkWell(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: kPrimaryColor,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 15),
                      blurRadius: 27,
                      color: Colors.black12,
                    )
                  ],
                ),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
              ),
              Positioned(
                bottom: 21,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () {
                      handleToast(
                          message: "Long press to delete", color: kInfoColour);
                    },
                    onLongPress: () async {
                      int statusCode = await searchProfileProvider.delete(
                        tokenType: connectedUserProvider.tokenType!,
                        token: connectedUserProvider.token!,
                        id: widget.searchProfile.id!,
                        userId: connectedUserProvider.userId!,
                      );

                      if (ApiHelper.isSuccess(statusCode) && mounted) {
                        handleToast(
                            statusCode: statusCode,
                            message: kSearchProfileDeleteSuccess);
                      }
                    },
                    child: const Icon(
                      Icons.delete_outline,
                      color: kPrimaryColor,
                      size: 36,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: SizedBox(
                  height: 136,
                  width: size.width - 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              decoration: const BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(22),
                                  topRight: Radius.circular(22),
                                ),
                              ),
                              child: Text(
                                "#${widget.index}",
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
                            const SizedBox(width: 7),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(22),
                                  topRight: Radius.circular(22),
                                ),
                              ),
                              child: Text(
                                "${widget.searchProfile.rentPriceLowerBound.toStringAsFixed(0)}-${widget.searchProfile.rentPriceUpperBound.toStringAsFixed(0)}\$",
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
                            const SizedBox(width: 7),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(22),
                                  topRight: Radius.circular(22),
                                ),
                              ),
                              child: Text(
                                "bedroom: ${listToCommaSeparatedValues(list: widget.searchProfile.bedroomOptions)}",
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(22),
                                  topRight: Radius.circular(22),
                                ),
                              ),
                              child: Text(
                                "bathrooms: ${listToCommaSeparatedValues(list: widget.searchProfile.bathroomOptions)}",
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(22),
                                  topRight: Radius.circular(22),
                                ),
                              ),
                              child: Text(
                                "rent mate count: ${listToCommaSeparatedValues(list: widget.searchProfile.rentMateCountOptions)}",
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
