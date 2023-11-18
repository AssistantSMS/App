class RaidState {
  int carrot;
  int tomato;
  int beetroot;
  int banana;
  int berry;
  int orange;
  int potato;
  int pineapple;
  int broccoli;
  int cotton;

  RaidState({
    this.carrot = 0,
    this.tomato = 0,
    this.beetroot = 0,
    this.banana = 0,
    this.berry = 0,
    this.orange = 0,
    this.potato = 0,
    this.pineapple = 0,
    this.broccoli = 0,
    this.cotton = 0,
  });

  factory RaidState.initial() {
    return RaidState(
      carrot: 0,
      tomato: 0,
      beetroot: 0,
      banana: 0,
      berry: 0,
      orange: 0,
      potato: 0,
      pineapple: 0,
      broccoli: 0,
      cotton: 0,
    );
  }

  RaidState copyWith({
    int? carrot,
    int? tomato,
    int? beetroot,
    int? banana,
    int? berry,
    int? orange,
    int? potato,
    int? pineapple,
    int? broccoli,
    int? cotton,
  }) {
    return RaidState(
      carrot: carrot ?? this.carrot,
      tomato: tomato ?? this.tomato,
      beetroot: beetroot ?? this.beetroot,
      banana: banana ?? this.banana,
      berry: berry ?? this.berry,
      orange: orange ?? this.orange,
      potato: potato ?? this.potato,
      pineapple: pineapple ?? this.pineapple,
      broccoli: broccoli ?? this.broccoli,
      cotton: cotton ?? this.cotton,
    );
  }

  static RaidState fromJson(Map<String, dynamic> json) {
    try {
      return RaidState(
        carrot: json['carrot'] ?? 0,
        tomato: json['tomato'] ?? 0,
        beetroot: json['beetroot'] ?? 0,
        banana: json['banana'] ?? 0,
        berry: json['berry'] ?? 0,
        orange: json['orange'] ?? 0,
        potato: json['potato'] ?? 0,
        pineapple: json['pineapple'] ?? 0,
        broccoli: json['broccoli'] ?? 0,
        cotton: json['cotton'] ?? 0,
      );
    } catch (exception) {
      return RaidState.initial();
    }
  }

  Map<String, dynamic> toJson() => {
        'carrot': carrot,
        'tomato': tomato,
        'beetroot': beetroot,
        'banana': banana,
        'berry': berry,
        'orange': orange,
        'potato': potato,
        'pineapple': pineapple,
        'broccoli': broccoli,
        'cotton': cotton,
      };
}
