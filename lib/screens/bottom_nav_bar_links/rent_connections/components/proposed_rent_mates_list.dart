import 'package:flutter/material.dart';
import 'package:fyrm_frontend/api/rent_connections/dto/proposed_rent_mate_dto.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/rent_connections/components/rent_mate_card.dart';

class ProposedRentMatesList extends StatefulWidget {
  final List<ProposedRentMateDto> rentMates;

  const ProposedRentMatesList({Key? key, required this.rentMates}) : super(key: key);

  @override
  State<ProposedRentMatesList> createState() => _ProposedRentMatesListState();
}

class _ProposedRentMatesListState extends State<ProposedRentMatesList> {
  @override
  Widget build(BuildContext context) {
    final rentMates = widget.rentMates;
    return rentMates.isEmpty
        ? buildEmptyProposalMessage()
        : SingleChildScrollView(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: rentMates.map((rentMate) => RentMateCard(rentMate: rentMate)).toList(),
            ),
          );
  }

  Widget buildEmptyProposalMessage() {
    return Padding(
      padding: const EdgeInsets.only(top: 60, right: 25, left: 25),
      child: Text(
        "Unfortunately there is no matching rent mate for you at the moment...",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black26,
          fontSize: getProportionateScreenWidth(17),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
