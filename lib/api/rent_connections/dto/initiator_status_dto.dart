import 'package:fyrm_frontend/api/rent_connections/dto/active_rent_connection_dto.dart';
import 'package:fyrm_frontend/api/rent_connections/dto/initiator_status_enum.dart';
import 'package:fyrm_frontend/api/rent_connections/dto/rent_mate_proposal_dto.dart';

class InitiatorStatusDto {
  late InitiatorStatusEnum? status;
  late num? minutesToWait;
  late ActiveRentConnectionDto? activeRentConnection;
  late RentMateProposalDto? rentMateProposal;

  InitiatorStatusDto(
      {required this.status,
      required this.minutesToWait,
      required this.activeRentConnection,
      required this.rentMateProposal});

  Map<String, Object?> toJSON() => {
        statusJsonField: status?.id,
        minutesToWaitJsonField: minutesToWait,
        activeRentConnectionJsonField: activeRentConnection?.toJSON(),
        rentMateProposalJsonField: rentMateProposal?.toJSON(),
      };

  static InitiatorStatusDto fromJSON(dynamic json) => InitiatorStatusDto(
        status:
            InitiatorStatusEnum.findByValue(json[statusJsonField] as String),
        minutesToWait: json[minutesToWaitJsonField] as num?,
        activeRentConnection: toActiveRentConnectionDtoOrElseNull(
            json[activeRentConnectionJsonField]),
        rentMateProposal:
            toRentMateProposalDtoOrElseNull(json[rentMateProposalJsonField]),
      );

  static ActiveRentConnectionDto? toActiveRentConnectionDtoOrElseNull(
          dynamic valueFromJson) =>
      valueFromJson == null
          ? null
          : ActiveRentConnectionDto.fromJSON(valueFromJson);

  static RentMateProposalDto? toRentMateProposalDtoOrElseNull(
          dynamic valueFromJson) =>
      valueFromJson == null
          ? null
          : RentMateProposalDto.fromJSON(valueFromJson);

  static String get statusJsonField => "initiatorStatus";

  static String get minutesToWaitJsonField => "minutesToWait";

  static String get activeRentConnectionJsonField => "activeRentConnection";

  static String get rentMateProposalJsonField => "associatedRentMateProposal";
}
