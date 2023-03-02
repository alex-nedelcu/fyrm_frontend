import 'package:flutter/material.dart';
import 'package:fyrm_frontend/api/search_profile/dto/search_profile_dto.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/screens/profile_links/manage_search_profile/components/search_profile_form.dart';

class Body extends StatelessWidget {
  final bool isCreate;
  final SearchProfileDto? searchProfile;

  const Body({super.key, required this.isCreate, this.searchProfile});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfiguration.screenHeight * 0.04),
                SearchProfileForm(isCreate: isCreate, searchProfile: searchProfile),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
