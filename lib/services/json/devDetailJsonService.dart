import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../../contracts/devDetail.dart';

class DevDetailJsonService extends BaseJsonService {
  Future<ResultWithValue<List<DevDetailFile>>> getAll(context) async {
    try {
      dynamic jsonString = await getJsonFromAssets(context, 'data/devDetail');
      List responseJson = json.decode(jsonString);
      List<DevDetailFile> packingItems =
          responseJson.map((m) => DevDetailFile.fromJson(m)).toList();

      return ResultWithValue<List<DevDetailFile>>(true, packingItems, '');
    } catch (exception) {
      getLog().e(
          "DevDetailJsonService() getAll Exception: ${exception.toString()}");
      return ResultWithValue<List<DevDetailFile>>(
          false, List.empty(growable: true), exception.toString());
    }
  }

  Future<ResultWithValue<DevDetailFile>> getById(context, String appId) async {
    ResultWithValue<List<DevDetailFile>> allItems = await getAll(context);
    if (allItems.hasFailed) {
      return ResultWithValue(false, DevDetailFile(), allItems.errorMessage);
    }
    try {
      DevDetailFile selectedItem =
          allItems.value.firstWhere((r) => r.appId == appId);
      return ResultWithValue<DevDetailFile>(true, selectedItem, '');
    } catch (exception) {
      getLog().e(
          "DevDetailJsonService() getById Exception: ${exception.toString()}");
      return ResultWithValue<DevDetailFile>(
          false, DevDetailFile(), exception.toString());
    }
  }
}
