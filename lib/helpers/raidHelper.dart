import 'package:scrapmechanic_kurtlourens_com/state/modules/raid/raidViewModel.dart';

import '../contracts/raid/raidAttack.dart';
import '../contracts/raid/raidSpawn.dart';

class RaidHelper {
  static const String potatoId = "ammo1"; // plant9
  static const String cottonId = "reso4"; // plant10
  static const String bananaId = "plant11";
  static const String berryId = "plant12";
  static const String orangeId = "plant13";
  static const String pineappleId = "plant14";
  static const String carrotId = "plant15";
  static const String beetrootId = "plant16";
  static const String tomatoId = "plant17";
  static const String broccoliId = "plant18";

  static const int highValue = 3;

  static const List<String> plants = [
    carrotId,
    tomatoId,
    beetrootId,
    cottonId,
    potatoId,
    bananaId,
    berryId,
    orangeId,
    pineappleId,
    broccoliId,
  ];

  static const Map<String, double> plantsWeights = {
    carrotId: 1,
    tomatoId: 1,
    beetrootId: 1,
    cottonId: 1,
    potatoId: 1.5,
    bananaId: 2,
    berryId: 2,
    orangeId: 2,
    pineappleId: 3,
    broccoliId: 3,
  };

  static List<RaidAttack> raidAttackDetails = [
    RaidAttack(minValue: 10, minHighCount: 0, spawns: [
      RaidSpawn(3, 0, 0, 0),
      RaidSpawn(4, 0, 0, 0),
      RaidSpawn(3, 1, 0, 0),
    ]),
    RaidAttack(minValue: 20, minHighCount: 0, spawns: [
      RaidSpawn(4, 1, 0, 0),
      RaidSpawn(4, 2, 0, 0),
      RaidSpawn(4, 3, 0, 0),
    ]),
    RaidAttack(minValue: 30, minHighCount: 0, spawns: [
      RaidSpawn(4, 2, 0, 0),
      RaidSpawn(4, 3, 0, 0),
      RaidSpawn(4, 5, 0, 0),
    ]),
    RaidAttack(minValue: 40, minHighCount: 0, spawns: [
      RaidSpawn(4, 3, 0, 0),
      RaidSpawn(4, 5, 0, 0),
      RaidSpawn(4, 7, 0, 0),
    ]),
    RaidAttack(minValue: 50, minHighCount: 0, spawns: [
      RaidSpawn(4, 4, 0, 0),
      RaidSpawn(4, 6, 0, 0),
      RaidSpawn(4, 8, 0, 0),
    ]),
    RaidAttack(minValue: 60, minHighCount: 0, spawns: [
      RaidSpawn(4, 4, 0, 0),
      RaidSpawn(4, 6, 0, 0),
      RaidSpawn(4, 8, 0, 0),
    ]),
    RaidAttack(minValue: 80, minHighCount: 2, spawns: [
      RaidSpawn(3, 6, 1, 0),
      RaidSpawn(3, 8, 1, 0),
      RaidSpawn(3, 10, 2, 0),
    ]),
    RaidAttack(minValue: 110, minHighCount: 10, spawns: [
      RaidSpawn(3, 6, 2, 0),
      RaidSpawn(3, 8, 2, 0),
      RaidSpawn(3, 10, 3, 0),
    ]),
    RaidAttack(minValue: 150, minHighCount: 20, spawns: [
      RaidSpawn(3, 6, 3, 0),
      RaidSpawn(3, 8, 3, 0),
      RaidSpawn(3, 10, 4, 1),
    ]),
    RaidAttack(minValue: 300, minHighCount: 50, spawns: [
      RaidSpawn(3, 6, 4, 1),
      RaidSpawn(3, 6, 4, 1),
      RaidSpawn(3, 6, 5, 3),
    ]),
  ];

  static RaidViewModel setFarmDetailsQuantity(
    RaidViewModel details,
    String itemId,
    int quantity,
  ) {
    if (itemId == RaidHelper.carrotId) details.carrot = quantity;
    if (itemId == RaidHelper.tomatoId) details.tomato = quantity;
    if (itemId == RaidHelper.beetrootId) details.beetroot = quantity;
    if (itemId == RaidHelper.bananaId) details.banana = quantity;
    if (itemId == RaidHelper.berryId) details.berry = quantity;
    if (itemId == RaidHelper.orangeId) details.orange = quantity;
    if (itemId == RaidHelper.potatoId) details.potato = quantity;
    if (itemId == RaidHelper.pineappleId) details.pineapple = quantity;
    if (itemId == RaidHelper.broccoliId) details.broccoli = quantity;
    if (itemId == RaidHelper.cottonId) details.cotton = quantity;

    return details;
  }

  static int getPlantQuantity(RaidViewModel details, String itemId) {
    if (itemId == RaidHelper.carrotId) return details.carrot ?? 0;
    if (itemId == RaidHelper.tomatoId) return details.tomato ?? 0;
    if (itemId == RaidHelper.beetrootId) return details.beetroot ?? 0;
    if (itemId == RaidHelper.bananaId) return details.banana ?? 0;
    if (itemId == RaidHelper.berryId) return details.berry ?? 0;
    if (itemId == RaidHelper.orangeId) return details.orange ?? 0;
    if (itemId == RaidHelper.potatoId) return details.potato ?? 0;
    if (itemId == RaidHelper.pineappleId) return details.pineapple ?? 0;
    if (itemId == RaidHelper.broccoliId) return details.broccoli ?? 0;
    if (itemId == RaidHelper.cottonId) return details.cotton ?? 0;

    return 0;
  }

  static double getCropValue(RaidViewModel details) {
    double cropValue = 0;
    for (var plantId in plants) {
      double plantWeight = plantsWeights[plantId];
      if (plantWeight == null) continue;

      int plantQuantity = getPlantQuantity(details, plantId);
      if (plantQuantity == null || plantQuantity == 0) continue;

      cropValue += plantWeight * plantQuantity;
    }

    return cropValue;
  }

  static int getHighCount(RaidViewModel details) {
    int highCount = 0;
    for (var plantId in plants) {
      double plantWeight = plantsWeights[plantId];
      if (plantWeight == null) continue;

      int plantQuantity = getPlantQuantity(details, plantId);
      if (plantQuantity == null || plantQuantity == 0) continue;

      if (plantWeight >= highValue) {
        highCount += plantQuantity;
      }
    }

    return highCount;
  }

  static List<RaidSpawn> getRaidSpawns(double cropValue, int highCount) {
    List<RaidSpawn> spawns = List<RaidSpawn>();
    for (var raidAttack in raidAttackDetails) {
      if (cropValue >= raidAttack.minValue &&
          highCount >= raidAttack.minHighCount) {
        spawns = raidAttack.spawns;
      }
    }

    return spawns;
  }

  static List<String> getPlantsWithQuantity(RaidViewModel details) {
    List<String> plantIds = List<String>();

    if (details.carrot > 0) plantIds.add(carrotId);
    if (details.tomato > 0) plantIds.add(tomatoId);
    if (details.beetroot > 0) plantIds.add(beetrootId);
    if (details.banana > 0) plantIds.add(bananaId);
    if (details.berry > 0) plantIds.add(berryId);
    if (details.orange > 0) plantIds.add(orangeId);
    if (details.potato > 0) plantIds.add(potatoId);
    if (details.pineapple > 0) plantIds.add(pineappleId);
    if (details.broccoli > 0) plantIds.add(broccoliId);
    if (details.cotton > 0) plantIds.add(cottonId);

    return plantIds;
  }
}
