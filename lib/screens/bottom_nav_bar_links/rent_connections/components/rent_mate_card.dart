import 'package:flutter/material.dart';
import 'package:fyrm_frontend/api/rent_connections/dto/proposed_rent_mate_dto.dart';

import '../../../../helper/constants.dart';

class RentMateCard extends StatefulWidget {
  final ProposedRentMateDto rentMate;

  const RentMateCard({required this.rentMate, Key? key}) : super(key: key);

  @override
  State<RentMateCard> createState() => _RentMateCardState();
}

class _RentMateCardState extends State<RentMateCard> {
  Duration duration = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: AnimatedContainer(
        duration: duration,
        margin: const EdgeInsets.only(top: kDefaultPadding * 4),
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.25),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Transform.translate(
              offset: const Offset(0, -40),
              child: AnimatedContainer(
                duration: duration,
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 5),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 15),
                      blurRadius: 50,
                      color: Colors.black.withOpacity(0.5),
                    )
                  ],
                  image: const DecorationImage(
                    image: AssetImage("assets/images/profile-image.png"),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.rentMate.username!,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    child: const Icon(Icons.chat, color: kSecondaryColor, size: 30),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 140,
              child: Text(
                widget.rentMate.description ??
                    "Unfortunately ${widget.rentMate.username} has not provided any description.\nBut we suggest you still get in touch because you never know.",
                overflow: TextOverflow.visible,
                style: const TextStyle(
                  color: kTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
