import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyrm_frontend/api/rent_connections/dto/proposed_rent_mate_dto.dart';
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
    return SingleChildScrollView(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: rentMates.map((rentMate) => RentMateCard(rentMate: rentMate)).toList(),
      ),
    );
  }
}
