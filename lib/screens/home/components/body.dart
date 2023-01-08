import 'package:flutter/material.dart';
import 'package:fyrm_frontend/api/dto/login_response_dto.dart';

import '../../../helper/size_configuration.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  final LoginResponseDto loginResponse;

  const Body({Key? key, required this.loginResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("USER ID: ${loginResponse.userId}");
    print("TOKEN: ${loginResponse.token}");

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            const HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            const DiscountBanner(),
            const Categories(),
            const SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30)),
            const PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
