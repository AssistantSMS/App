import '../constants/IdPrefix.dart';
import '../contracts/results/resultWithValue.dart';
import '../integration/dependencyInjection.dart';
import '../integration/logging.dart';
import '../localization/localeKey.dart';
import '../services/interface/IRecipeJsonService.dart';

ResultWithValue<IRecipeJsonService> getRepoFromId(context, String id) {
  if (id.contains(IdPrefix.block))
    return ResultWithValue<IRecipeJsonService>(
        true, getGenericRepo(LocaleKey.blocksJson), '');
  if (id.contains(IdPrefix.cookBot))
    return ResultWithValue<IRecipeJsonService>(
        true, getGenericRepo(LocaleKey.cookBotJson), '');
  if (id.contains(IdPrefix.craftBot))
    return ResultWithValue<IRecipeJsonService>(
        true, getGenericRepo(LocaleKey.craftBotJson), '');
  if (id.contains(IdPrefix.dispenser))
    return ResultWithValue<IRecipeJsonService>(
        true, getGenericRepo(LocaleKey.dispenserJson), '');
  if (id.contains(IdPrefix.dressBot))
    return ResultWithValue<IRecipeJsonService>(
        true, getGenericRepo(LocaleKey.dressBotJson), '');
  if (id.contains(IdPrefix.refinery))
    return ResultWithValue<IRecipeJsonService>(
        true, getGenericRepo(LocaleKey.refineryJson), '');
  if (id.contains(IdPrefix.workbench))
    return ResultWithValue<IRecipeJsonService>(
        true, getGenericRepo(LocaleKey.workbenchJson), '');

  logger.e('getRepo - unknown type of item: $id');
  return ResultWithValue<IRecipeJsonService>(
      false, null, 'getRepo - unknown type of item: $id');
}
