class CosmeticState {
  List<String> owned;

  CosmeticState({
    required this.owned,
  });

  factory CosmeticState.initial() {
    return CosmeticState(
      owned: List.empty(growable: true),
    );
  }

  CosmeticState copyWith({
    List<String>? owned,
  }) {
    return CosmeticState(
      owned: owned ?? List.empty(growable: true),
    );
  }

  static CosmeticState fromJson(Map<String, dynamic> json) {
    try {
      return CosmeticState(
        owned: List<String>.from(json["owned"]),
      );
    } catch (exception) {
      return CosmeticState(
        owned: List.empty(growable: true),
      );
    }
  }

  Map<String, dynamic> toJson() => {
        'owned': owned,
      };
}
