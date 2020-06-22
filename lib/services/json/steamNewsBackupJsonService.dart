import 'dart:convert';

import '../../contracts/generated/SteamNewsItem.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../integration/logging.dart';
import '../BaseJsonService.dart';

class SteamNewsBackupJsonService extends BaseJsonService {
  Future<ResultWithValue<List<SteamNewsItem>>> getAll(context) async {
    try {
      dynamic jsonString =
          await this.getJsonFromAssets(context, 'data/steamNewsBackup');
      List responseJson = json.decode(jsonString);
      List<SteamNewsItem> backupItems =
          responseJson.map((m) => SteamNewsItem.fromJson(m)).toList();

      return ResultWithValue<List<SteamNewsItem>>(true, backupItems, '');
    } catch (exception) {
      logger
          .e("SteamNewsBackupJsonService() Exception: ${exception.toString()}");
      return ResultWithValue<List<SteamNewsItem>>(
          false, List<SteamNewsItem>(), exception.toString());
    }
  }
}
