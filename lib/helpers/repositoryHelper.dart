import '../constants/BaseJson.dart';
import '../constants/IdPrefix.dart';
import '../localization/localeKey.dart';

List<LocaleKey> allRecipeJsons() {
  return [
    LocaleKey.cookBotRecipeJson,
    LocaleKey.craftBotRecipeJson,
    LocaleKey.dispenserRecipeJson,
    LocaleKey.dressBotRecipeJson,
    // LocaleKey.hideOutRecipeJson,
    // LocaleKey.itemNamesRecipeJson,
    LocaleKey.refineryRecipeJson,
    // LocaleKey.undecidedRecipeJson,
    LocaleKey.workbenchRecipeJson,
  ];
}

String getBaseFileName(LocaleKey detailsJson) {
  switch (detailsJson) {
    case LocaleKey.cookBotRecipeJson:
      return BaseJson.cookBot;
    case LocaleKey.craftBotRecipeJson:
      return BaseJson.craftBot;
    case LocaleKey.dispenserRecipeJson:
      return BaseJson.dispenser;
    case LocaleKey.dressBotRecipeJson:
      return BaseJson.dressBot;
    // case LocaleKey.hideOutRecipeJson: return BaseJson.hid;
    // case LocaleKey.itemNamesRecipeJson: return BaseJson.blocks;
    case LocaleKey.refineryRecipeJson:
      return BaseJson.refinery;
    // case LocaleKey.undecidedRecipeJson: return BaseJson.un;
    case LocaleKey.workbenchRecipeJson:
      return BaseJson.workbench;

    // Game Items below
    case LocaleKey.blocksJson:
      return BaseJson.blocks;
    case LocaleKey.buildingJson:
      return BaseJson.building;
    case LocaleKey.constructionJson:
      return BaseJson.construction;
    case LocaleKey.consumableJson:
      return BaseJson.consumable;
    case LocaleKey.containersJson:
      return BaseJson.containers;
    case LocaleKey.craftbotJson:
      return BaseJson.craftbot;
    case LocaleKey.decorJson:
      return BaseJson.decor;
    case LocaleKey.gittingJson:
      return BaseJson.gitting;
    case LocaleKey.harvestJson:
      return BaseJson.harvest;
    case LocaleKey.industrialJson:
      return BaseJson.industrial;
    case LocaleKey.interactiveJson:
      return BaseJson.interactive;
    case LocaleKey.interactiveUpgradableJson:
      return BaseJson.interactiveUpgradable;
    case LocaleKey.interactiveContainerJson:
      return BaseJson.interactiveContainer;
    case LocaleKey.lightJson:
      return BaseJson.light;
    case LocaleKey.manMadeJson:
      return BaseJson.manMade;
    case LocaleKey.outfitJson:
      return BaseJson.outfit;
    case LocaleKey.packingCrateJson:
      return BaseJson.packingCrate;
    case LocaleKey.plantJson:
      return BaseJson.plant;
    case LocaleKey.powerJson:
      return BaseJson.power;
    case LocaleKey.resourcesJson:
      return BaseJson.resources;
    case LocaleKey.robotJson:
      return BaseJson.robot;
    case LocaleKey.survivalJson:
      return BaseJson.survival;
    case LocaleKey.toolJson:
      return BaseJson.tool;
    case LocaleKey.vehicleJson:
      return BaseJson.vehicle;
    case LocaleKey.warehouseJson:
      return BaseJson.warehouse;
    default:
      return '';
  }
}

LocaleKey getDisplayNameFromLangFileName(LocaleKey detailsJson) {
  switch (detailsJson) {
    case LocaleKey.cookBotRecipeJson:
      return LocaleKey.cookingBot;
    case LocaleKey.craftBotRecipeJson:
      return LocaleKey.craftBot;
    case LocaleKey.dispenserRecipeJson:
      return LocaleKey.dispenserRecipeJson; //TODO
    case LocaleKey.dressBotRecipeJson:
      return LocaleKey.dressBot;
    // case LocaleKey.hideOutRecipeJson: return LocaleKey.hid;
    // case LocaleKey.itemNamesRecipeJson: return LocaleKey.blocks;
    case LocaleKey.refineryRecipeJson:
      return LocaleKey.refiner;
    // case LocaleKey.undecidedRecipeJson: return LocaleKey.un;
    case LocaleKey.workbenchRecipeJson:
      return LocaleKey.workbenchRecipeJson; // TODO
    default:
      return LocaleKey.unknown;
  }
}
