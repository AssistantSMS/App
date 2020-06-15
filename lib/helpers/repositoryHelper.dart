import '../constants/BaseJson.dart';
import '../localization/localeKey.dart';

String getBaseFileName(LocaleKey detailsJson) {
  switch (detailsJson) {
    case LocaleKey.cookBotJson:
      return BaseJson.cookBot;
    case LocaleKey.craftBotJson:
      return BaseJson.craftBot;
    case LocaleKey.dispenserJson:
      return BaseJson.dispenser;
    case LocaleKey.dressBotJson:
      return BaseJson.dressBot;
    // case LocaleKey.hideOutJson: return BaseJson.hid;
    // case LocaleKey.itemNamesJson: return BaseJson.blocks;
    case LocaleKey.refineryJson:
      return BaseJson.refinery;
    // case LocaleKey.undecidedJson: return BaseJson.un;
    case LocaleKey.workbenchJson:
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
