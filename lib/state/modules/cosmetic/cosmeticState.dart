class CosmeticState {
  List<String> owned;

  CosmeticState({
    this.owned,
  });

  factory CosmeticState.initial() {
    return CosmeticState(
      owned: List<String>(),
    );
  }

  CosmeticState copyWith({
    List<String> owned,
  }) {
    return CosmeticState(
      owned: owned ?? List<String>(),
    );
  }

  CosmeticState.fromJson(Map<String, dynamic> json) {
    try {
      owned = List<String>.from(json["owned"]);
    } catch (exception) {
      owned = List<String>();
    }
  }

  Map<String, dynamic> toJson() => {
        'owned': owned,
      };
}
