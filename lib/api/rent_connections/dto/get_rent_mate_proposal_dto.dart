class GetRentMateProposalDto {
  late int? initiatorId;
  late int? proposalMaximumSize;
  late List<int>? searchProfileIds;

  GetRentMateProposalDto({
    required this.initiatorId,
    required this.proposalMaximumSize,
    required this.searchProfileIds,
  });

  Map<String, Object?> toJSON() => {
        initiatorIdJsonField: initiatorId,
        proposalMaximumSizeJsonField: proposalMaximumSize,
        searchProfileIdsJsonField: searchProfileIds,
      };

  static String get initiatorIdJsonField => "initiatorId";

  static String get proposalMaximumSizeJsonField => "proposalMaximumSize";

  static String get searchProfileIdsJsonField => "searchProfileIds";
}
