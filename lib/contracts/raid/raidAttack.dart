import 'package:scrapmechanic_kurtlourens_com/contracts/raid/raidSpawn.dart';

class RaidAttack {
  int minValue;
  int minHighCount;
  List<RaidSpawn> spawns;

  RaidAttack({
    this.minValue,
    this.minHighCount,
    this.spawns,
  });
}
