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
    int carrot,
    int tomato,
    int beetroot,
    int banana,
    int berry,
    int orange,
    int potato,
    int pineapple,
    int broccoli,
    int cotton,
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

  RaidState.fromJson(Map<String, dynamic> json) {
    try {
      carrot = json['carrot'];
      tomato = json['tomato'];
      beetroot = json['beetroot'];
      banana = json['banana'];
      berry = json['berry'];
      orange = json['orange'];
      potato = json['potato'];
      pineapple = json['pineapple'];
      broccoli = json['broccoli'];
      cotton = json['cotton'];
    } catch (exception) {
      var raid = RaidState.initial();
      carrot = raid.carrot;
      tomato = raid.tomato;
      beetroot = raid.beetroot;
      banana = raid.banana;
      berry = raid.berry;
      orange = raid.orange;
      potato = raid.potato;
      pineapple = raid.pineapple;
      broccoli = raid.broccoli;
      cotton = raid.cotton;
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
