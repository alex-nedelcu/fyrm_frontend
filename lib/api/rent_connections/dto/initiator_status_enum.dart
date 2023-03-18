enum InitiatorStatusEnum {
  canCreate(0, "CAN_CREATE"),
  canFinalise(1, "CAN_FINALISE"),
  mustWait(2, "MUST_WAIT");

  final int id;
  final String value;

  const InitiatorStatusEnum(this.id, this.value);

  static InitiatorStatusEnum findByValue(String value) {
    return InitiatorStatusEnum.values.firstWhere((element) => element.value == value);
  }
}
