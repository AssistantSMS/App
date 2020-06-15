import '../constants/BaseJson.dart';
import '../localization/localeKey.dart';
import '../services/interface/IRecipeJsonService.dart';
import '../services/json/recipeJsonService.dart';

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
    case LocaleKey.resourcesJson:
      return BaseJson.resources;
    default:
      return '';
  }
}
