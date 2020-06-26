class RaidFarmDetails {
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

  RaidFarmDetails({
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

  RaidFarmDetails copyWith({
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
    return RaidFarmDetails(
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
}
