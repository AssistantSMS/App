import 'dart:convert';

import '../../contracts/generated/AssistantApps/assistantAppLinks.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../integration/logging.dart';
import '../BaseJsonService.dart';

class AssistantAppLinksBackupJsonService extends BaseJsonService {
  Future<ResultWithValue<List<AssistantAppLinks>>> getAll(context) async {
    try {
      dynamic jsonString =
          await this.getJsonFromAssets(context, 'data/assistantAppLinks');
      List responseJson = json.decode(jsonString);
      List<AssistantAppLinks> backupItems =
          responseJson.map((m) => AssistantAppLinks.fromJson(m)).toList();

      return ResultWithValue<List<AssistantAppLinks>>(true, backupItems, '');
    } catch (exception) {
      logger.e(
          "AssistantAppLinksBackupJsonService() Exception: ${exception.toString()}");
      return ResultWithValue<List<AssistantAppLinks>>(
          false, List<AssistantAppLinks>(), exception.toString());
    }
  }
}
