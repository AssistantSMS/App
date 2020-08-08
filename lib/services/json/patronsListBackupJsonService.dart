import 'dart:convert';

import '../../contracts/generated/PatreonViewModel.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../integration/logging.dart';
import '../BaseJsonService.dart';

class PatronsListBackupJsonService extends BaseJsonService {
  Future<ResultWithValue<List<PatreonViewModel>>> getAll(context) async {
    try {
      dynamic jsonString =
          await this.getJsonFromAssets(context, 'data/patronsBackup');
      List responseJson = json.decode(jsonString);
      List<PatreonViewModel> backupItems =
          responseJson.map((m) => PatreonViewModel.fromJson(m)).toList();

      return ResultWithValue<List<PatreonViewModel>>(true, backupItems, '');
    } catch (exception) {
      logger.e(
          "PatronsListBackupJsonService() Exception: ${exception.toString()}");
      return ResultWithValue<List<PatreonViewModel>>(
          false, List<PatreonViewModel>(), exception.toString());
    }
  }
}
