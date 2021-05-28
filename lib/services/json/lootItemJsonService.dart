import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../../contracts/generated/Loot.dart';

class LootItemJsonService extends BaseJsonService {
  Future<ResultWithValue<List<Loot>>> getAll(context) async {
    try {
      dynamic jsonString = await this.getJsonFromAssets(context, 'data/loot');
      List responseJson = json.decode(jsonString);
      List<Loot> lootItems = responseJson.map((m) => Loot.fromJson(m)).toList();

      return ResultWithValue<List<Loot>>(true, lootItems, '');
    } catch (exception) {
      getLog().e("LootItemJsonService() Exception: ${exception.toString()}");
      return ResultWithValue<List<Loot>>(
          false, List.empty(growable: true), exception.toString());
    }
  }

  Future<ResultWithValue<Loot>> getById(context, String appId) async {
    ResultWithValue<List<Loot>> allGenericItemsResult =
        await this.getAll(context);
    if (allGenericItemsResult.hasFailed) {
      return ResultWithValue(false, Loot(), allGenericItemsResult.errorMessage);
    }
    try {
      Loot selectedGeneric =
          allGenericItemsResult.value.firstWhere((r) => r.appId == appId);
      return ResultWithValue<Loot>(true, selectedGeneric, '');
    } catch (exception) {
      return ResultWithValue<Loot>(false, Loot(), exception.toString());
    }
  }
}
