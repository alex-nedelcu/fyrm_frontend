import 'package:flutter/material.dart';
import 'package:fyrm_frontend/helper/constants.dart';

class Body extends StatelessWidget {
  Body({super.key});

  @override
  Widget build(BuildContext context) {
    var universities = {
      "@stud.ubbcluj.ro": "Babes-Bolyai University of Cluj Napoca",
      "@stud.ubbbm.ro": "Babes-Bolyai University of Baia Mare",
      "@stud.ubboradea.ro": "Babes-Bolyai University of Oradea",
      "@s.unibuc.ro": "University of Bucharest",
      "@elearn.umf.ro": "Iuliu Hatieganu University of Medicine and Pharmacy",
      "@stud.umfcd.ro":
          "Carol Davila University of Medicine and Pharmacy Bucharest",
      "@stud.trans.ro": "Politehnica University of Bucharest - Transportations",
      "@stud.fiir.ro":
          "Politehnica University of Bucharest - Industrial Engineering and Robotics",
      "@stud.etti.ro":
          "Politehnica University of Bucharest - Electronics, Telecommunications and IT",
    };

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: universities.entries.map(
                (entry) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          entry.value,
                          style: const TextStyle(
                            color: kSecondaryColor,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          entry.key,
                          style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Divider(
                            color: Colors.black,
                            thickness: 0.5,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
