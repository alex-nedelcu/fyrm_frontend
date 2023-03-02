import 'package:flutter/material.dart';
import 'package:fyrm_frontend/api/search_profile/dto/search_profile_dto.dart';

import 'components/body.dart';

class ManageSearchProfileScreen extends StatelessWidget {
  static String routeName = "/manage-search-profile";

  const ManageSearchProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ManageSearchProfileScreenArguments arguments =
        ModalRoute.of(context)!.settings.arguments as ManageSearchProfileScreenArguments;
    String title = arguments.isCreate ? "New search profile" : "Update search profile";

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Body(isCreate: arguments.isCreate, searchProfile: arguments.searchProfile),
      ),
    );
  }
}

class ManageSearchProfileScreenArguments {
  final bool isCreate;
  final SearchProfileDto? searchProfile;

  ManageSearchProfileScreenArguments({required this.isCreate, this.searchProfile});
}
