import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../../contracts/recipe/recipeBase.dart';

class PackingJsonService extends BaseJsonService {
  Future<ResultWithValue<List<RecipeBase>>> getAll(context) async {
    try {
      dynamic jsonString = await getJsonFromAssets(
        context,
        'data/packing.json',
      );
      List responseJson = json.decode(jsonString);
      List<RecipeBase> packingItems =
          responseJson.map((m) => RecipeBase.fromJson(m)).toList();

      return ResultWithValue<List<RecipeBase>>(true, packingItems, '');
    } catch (exception) {
      getLog().e("PackingJsonService() Exception: ${exception.toString()}");
      return ResultWithValue<List<RecipeBase>>(
          false, List.empty(growable: true), exception.toString());
    }
  }

  Future<ResultWithValue<List<RecipeBase>>> getByOutput(
      context, String appId) async {
    ResultWithValue<List<RecipeBase>> allPackingItemsResult =
        await getAll(context);
    if (allPackingItemsResult.hasFailed) {
      return ResultWithValue(
          false, List.empty(), allPackingItemsResult.errorMessage);
    }
    try {
      List<RecipeBase> selectedGeneric = allPackingItemsResult.value
          .where((r) => r.output.id == appId)
          .toList();
      return ResultWithValue<List<RecipeBase>>(true, selectedGeneric, '');
    } catch (exception) {
      return ResultWithValue<List<RecipeBase>>(
          false, List.empty(), exception.toString());
    }
  }

  Future<ResultWithValue<List<RecipeBase>>> getByInput(
      context, String appId) async {
    ResultWithValue<List<RecipeBase>> allPackingItemsResult =
        await getAll(context);
    if (allPackingItemsResult.hasFailed) {
      return ResultWithValue(
          false, List.empty(), allPackingItemsResult.errorMessage);
    }
    try {
      List<RecipeBase> selectedGenerics = allPackingItemsResult.value
          .where((r) => r.inputs.any((i) => i.id == appId))
          .toList();
      return ResultWithValue<List<RecipeBase>>(true, selectedGenerics, '');
    } catch (exception) {
      return ResultWithValue<List<RecipeBase>>(
          false, List.empty(), exception.toString());
    }
  }
}
