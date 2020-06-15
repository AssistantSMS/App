import 'package:scrapmechanic_kurtlourens_com/services/interface/IGameItemJsonService.dart';

import '../constants/IdPrefix.dart';
import '../contracts/results/resultWithValue.dart';
import '../integration/dependencyInjection.dart';
import '../integration/logging.dart';
import '../localization/localeKey.dart';
import '../services/interface/IRecipeJsonService.dart';

ResultWithValue<IRecipeJsonService> getRecipeRepoFromId(context, String id) {
  LocaleKey key = LocaleKey.title;

  if (id.contains(IdPrefix.cookBot)) key = LocaleKey.cookBotJson;
  if (id.contains(IdPrefix.craftBot)) key = LocaleKey.craftBotJson;
  if (id.contains(IdPrefix.dispenser)) key = LocaleKey.dispenserJson;
  if (id.contains(IdPrefix.dressBot)) key = LocaleKey.dressBotJson;
  if (id.contains(IdPrefix.refinery)) key = LocaleKey.refineryJson;
  if (id.contains(IdPrefix.workbench)) key = LocaleKey.workbenchJson;

  if (id.contains(IdPrefix.block)) key = LocaleKey.blocksJson;
  // Similar to 'dress'
  if (id.contains(IdPrefix.resource)) key = LocaleKey.resourcesJson;

  if (key != LocaleKey.title) {
    return ResultWithValue<IRecipeJsonService>(true, getRecipeRepo(key), '');
  }

  logger.e('getRecipeRepoFromId - unknown type of item: $id');
  return ResultWithValue<IRecipeJsonService>(
      false, null, 'getRecipeRepoFromId - unknown type of item: $id');
}

ResultWithValue<IGameItemJsonService> getGameItemRepoFromId(
    context, String id) {
  LocaleKey key = LocaleKey.title;

  if (id.contains(IdPrefix.block)) key = LocaleKey.blocksJson;
  if (id.contains(IdPrefix.resource)) key = LocaleKey.resourcesJson;

  if (key != LocaleKey.title) {
    return ResultWithValue<IGameItemJsonService>(
        true, getGameItemRepo(key), '');
  }

  logger.e('getGameItemRepoFromId - unknown type of item: $id');
  return ResultWithValue<IGameItemJsonService>(
      false, null, 'getGameItemRepoFromId - unknown type of item: $id');
}
