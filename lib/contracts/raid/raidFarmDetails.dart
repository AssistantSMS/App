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
    this.carrot,
    this.tomato,
    this.beetroot,
    this.banana,
    this.berry,
    this.orange,
    this.potato,
    this.pineapple,
    this.broccoli,
    this.cotton,
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
