import 'package:scrapmechanic_kurtlourens_com/contracts/raid/raidSpawn.dart';

class RaidAttack {
  int minValue;
  int minHighCount;
  List<RaidSpawn> spawns;

  RaidAttack({
    required this.minValue,
    required this.minHighCount,
    required this.spawns,
  });
}
