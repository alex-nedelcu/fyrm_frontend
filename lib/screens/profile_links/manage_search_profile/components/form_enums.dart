import 'package:flutter/material.dart';

import '../../../../helper/constants.dart';

enum RentMateCountOption {
  one(0, "1"),
  two(1, "2"),
  three(2, "3"),
  moreThanThree(3, "+ 3");

  final int id;
  final String option;

  const RentMateCountOption(this.id, this.option);

  static List<String> get options => RentMateCountOption.values.map((value) => value.option).toList();

  static String findOptionById(int id) {
    return RentMateCountOption.values.firstWhere((element) => element.id == id).option;
  }

  static List<String> findSelectedOptions(List<bool> selection) {
    assert(selection.length == RentMateCountOption.values.length);

    List<String> result = <String>[];

    for (int index = 0; index < selection.length; index += 1) {
      if (selection[index] == true) {
        String option = RentMateCountOption.findOptionById(index);
        result.add(option);
      }
    }

    return result;
  }
}

enum RentMateGenderOption {
  male(0, Icon(Icons.man), "male"),
  female(1, Icon(Icons.woman), "female"),
  any(
    2,
    Text(
      "any",
      style: TextStyle(
        color: kSecondaryColor,
        fontWeight: FontWeight.bold,
      ),
    ),
    "any",
  );

  final int id;
  final Widget icon;
  final String option;

  const RentMateGenderOption(this.id, this.icon, this.option);

  static List<Widget> get icons => RentMateGenderOption.values.map((value) => value.icon).toList();

  static String findOptionById(int id) {
    return RentMateGenderOption.values.firstWhere((element) => element.id == id).option;
  }

  static List<String> findSelectedOptions(List<bool> selection) {
    assert(selection.length == RentMateGenderOption.values.length);

    List<String> result = <String>[];

    for (int index = 0; index < selection.length; index += 1) {
      if (selection[index] == true) {
        String option = RentMateGenderOption.findOptionById(index);
        result.add(option);
      }
    }

    return result;
  }
}

enum BedroomOption {
  own(0, "own"),
  shared(1, "shared"),
  any(2, "any");

  final int id;
  final String option;

  const BedroomOption(this.id, this.option);

  static List<String> get options => BedroomOption.values.map((value) => value.option).toList();

  static String findOptionById(int id) {
    return BedroomOption.values.firstWhere((element) => element.id == id).option;
  }

  static List<String> findSelectedOptions(List<bool> selection) {
    assert(selection.length == BedroomOption.values.length);

    List<String> result = <String>[];

    for (int index = 0; index < selection.length; index += 1) {
      if (selection[index] == true) {
        String option = BedroomOption.findOptionById(index);
        result.add(option);
      }
    }

    return result;
  }
}

enum BathroomCountOption {
  one(0, "1"),
  two(1, "2"),
  moreThanTwo(2, "> 2");

  final int id;
  final String option;

  const BathroomCountOption(this.id, this.option);

  static List<String> get options => BathroomCountOption.values.map((value) => value.option).toList();

  static String findOptionById(int id) {
    return BathroomCountOption.values.firstWhere((element) => element.id == id).option;
  }

  static List<String> findSelectedOptions(List<bool> selection) {
    assert(selection.length == BathroomCountOption.values.length);

    List<String> result = <String>[];

    for (int index = 0; index < selection.length; index += 1) {
      if (selection[index] == true) {
        String option = BathroomCountOption.findOptionById(index);
        result.add(option);
      }
    }

    return result;
  }
}
