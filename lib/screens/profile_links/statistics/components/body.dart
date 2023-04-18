import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fyrm_frontend/api/user/dto/user_statistics_dto.dart';
import 'package:fyrm_frontend/api/user/user_service.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/screens/profile_links/statistics/components/statistics_bar.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    ConnectedUserProvider connectedUserProvider =
        Provider.of<ConnectedUserProvider>(context);

    return SafeArea(
      child: FutureBuilder(
        future: userService.getStatisticsByUser(
          tokenType: connectedUserProvider.tokenType!,
          token: connectedUserProvider.token!,
          userId: connectedUserProvider.userId!,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final statistics = snapshot.requireData;
            return buildStatisticsBars(statistics);
          }

          return SpinKitThreeInOut(color: kSecondaryColor.withOpacity(0.5));
        },
      ),
    );
  }

  Widget buildStatisticsBars(UserStatisticsDto statistics) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Summary of your activity so far",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 60),
            StatisticsBar(
              text: "How many users you have chatted with",
              icon: Icons.mark_unread_chat_alt_outlined,
              value: statistics.chattedWithUsers!.length,
            ),
            StatisticsBar(
              text: "How many rent mates were suggested to you",
              icon: Icons.people_alt,
              value: statistics.suggestedUsers!.length,
            ),
            StatisticsBar(
              text: "How many times you were suggested to others",
              icon: Icons.autorenew_outlined,
              value: statistics.suggestedToUsers!.length,
            ),
          ],
        ),
      ),
    );
  }
}
