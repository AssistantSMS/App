class CosmeticState {
  List<String> owned;

  CosmeticState({
    this.owned,
  });

  factory CosmeticState.initial() {
    return CosmeticState(
      owned: List.empty(growable: true),
    );
  }

  CosmeticState copyWith({
    List<String> owned,
  }) {
    return CosmeticState(
      owned: owned ?? List.empty(growable: true),
    );
  }

  CosmeticState.fromJson(Map<String, dynamic> json) {
    try {
      owned = List<String>.from(json["owned"]);
    } catch (exception) {
      owned = List.empty(growable: true);
    }
  }

  Map<String, dynamic> toJson() => {
        'owned': owned,
      };
}
