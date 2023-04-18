import 'package:fyrm_frontend/api/util/dto_convert_helper.dart';

class UserStatisticsDto {
  late List<int>? chattedWithUsers;
  late List<int>? suggestedToUsers;
  late List<int>? suggestedUsers;

  UserStatisticsDto({
    required this.chattedWithUsers,
    required this.suggestedToUsers,
    required this.suggestedUsers,
  });

  static UserStatisticsDto fromJSON(dynamic json) => UserStatisticsDto(
        chattedWithUsers:
            DtoConvertHelper.toIntList(json[chattedWithUsersJsonField]),
        suggestedToUsers:
            DtoConvertHelper.toIntList(json[suggestedToUsersJsonField]),
        suggestedUsers:
            DtoConvertHelper.toIntList(json[suggestedUsersJsonField]),
      );

  static String get chattedWithUsersJsonField => "chattedWithUsers";

  static String get suggestedToUsersJsonField => "suggestedToUsers";

  static String get suggestedUsersJsonField => "suggestedUsers";
}
