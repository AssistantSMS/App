import 'package:package_info/package_info.dart';
import 'package:scrapmechanic_kurtlourens_com/contracts/recipe/recipe.dart';
import 'package:scrapmechanic_kurtlourens_com/integration/dependencyInjection.dart';
import 'package:scrapmechanic_kurtlourens_com/integration/logging.dart';
import 'package:scrapmechanic_kurtlourens_com/localization/localeKey.dart';
import 'package:scrapmechanic_kurtlourens_com/services/interface/IRecipeJsonService.dart';

import '../contracts/recipe/recipePageItem.dart';
import '../contracts/results/resultWithValue.dart';
import 'deviceHelper.dart';
import 'itemsHelper.dart';

Future<ResultWithValue<PackageInfo>> currentAppVersion() async {
  bool hasPackageInfo = isAndroid || isiOS;
  if (!hasPackageInfo) {
    return ResultWithValue<PackageInfo>(
        false, PackageInfo(), 'platform not supported');
  }
  try {
    var packInfo = await PackageInfo.fromPlatform();
    return ResultWithValue<PackageInfo>(true, packInfo, '');
  } catch (exception) {
    return ResultWithValue<PackageInfo>(
        false, PackageInfo(), exception.toString());
  }
}

Future<ResultWithValue<RecipePageItem>> recipePageItemFuture(
    context, String itemId) async {
  if (itemId == null)
    return ResultWithValue<RecipePageItem>(false, RecipePageItem(),
        'recipePageItemFuture - unknown type of item $itemId');
  ResultWithValue<IRecipeJsonService> genRepo = getRepoFromId(context, itemId);
  if (genRepo.hasFailed)
    return ResultWithValue<RecipePageItem>(false, RecipePageItem(),
        'genericItemFuture - unknown type of item $itemId');

  ResultWithValue<Recipe> itemResult =
      await genRepo.value.getById(context, itemId);
  if (itemResult.isSuccess) {
    return ResultWithValue<RecipePageItem>(
        true,
        RecipePageItem(
          recipe: itemResult.value,
          ingredientDetails: [],
        ),
        '');
  }
  return ResultWithValue<RecipePageItem>(
      false, RecipePageItem(), itemResult.errorMessage);
}

Future<ResultWithValue<List<Recipe>>> getAllFromLocaleKeys(
    dynamic context, List<LocaleKey> repoJsonStrings) async {
  List<Recipe> results = List<Recipe>();
  var onFinishTask = (ResultWithValue<List<Recipe>> result) {
    if (result.hasFailed) return;
    results.addAll(result.value);
  };
  List<Future<ResultWithValue<List<Recipe>>>> tasks =
      List<Future<ResultWithValue<List<Recipe>>>>();
  for (var repJson in repoJsonStrings) {
    var repo = getGenericRepo(repJson);
    if (repo == null) continue;
    var getAllTask = repo.getAll(context).then(onFinishTask);
    tasks.add(getAllTask);
  }
  await Future.wait(tasks);

  logger.i('Number of items: ${results.length}');
  // results.sort((a, b) => a.title.compareTo(b.title));

  return ResultWithValue(results.length > 0, results, '');
}
