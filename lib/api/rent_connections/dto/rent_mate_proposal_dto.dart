import 'package:fyrm_frontend/api/rent_connections/dto/proposed_rent_mate_dto.dart';

class RentMateProposalDto {
  late int? rentConnectionId;
  late num? proposalSize;
  late List<ProposedRentMateDto>? proposedRentMates;

  RentMateProposalDto({
    required this.rentConnectionId,
    required this.proposalSize,
    required this.proposedRentMates,
  });

  Map<String, Object?> toJSON() => {
        rentConnectionIdJsonField: rentConnectionId,
        proposalSizeJsonField: proposalSize,
        proposedRentMatesJsonField: proposedRentMates?.map((rentMate) => rentMate.toJSON()).toList(),
      };

  RentMateProposalDto copy({
    int? rentConnectionId,
    num? proposalSize,
    List<ProposedRentMateDto>? proposedRentMates,
  }) =>
      RentMateProposalDto(
        rentConnectionId: rentConnectionId ?? this.rentConnectionId,
        proposalSize: proposalSize ?? this.proposalSize,
        proposedRentMates: proposedRentMates ?? this.proposedRentMates,
      );

  static RentMateProposalDto fromJSON(dynamic json) => RentMateProposalDto(
        rentConnectionId: json[rentConnectionIdJsonField] as int?,
        proposalSize: json[proposalSizeJsonField] as num?,
        proposedRentMates: jsonToProposedRentMates(json[proposedRentMatesJsonField]),
      );

  static List<ProposedRentMateDto> jsonToProposedRentMates(dynamic valueFromJson) =>
      (valueFromJson as Iterable).map((rentMate) => ProposedRentMateDto.fromJSON(rentMate)).toList();

  static String get rentConnectionIdJsonField => "rentConnectionId";

  static String get proposalSizeJsonField => "proposalSize";

  static String get proposedRentMatesJsonField => "rentMates";
}
