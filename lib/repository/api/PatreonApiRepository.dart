import 'dart:convert';

import '../../constants/ApiUrls.dart';
import '../../contracts/generated/PatreonViewModel.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../integration/dependencyInjection.dart';
import '../../integration/logging.dart';
import '../BaseApiRepository.dart';
import 'interface/IPatreonApiRepository.dart';

class PatreonApiRepository extends BaseApiRepository
    implements IPatreonApiRepository {
  PatreonApiRepository() : super(baseUrl: getEnv().assistantAppsApiUrl);

  Future<ResultWithValue<List<PatreonViewModel>>> getPatrons() async {
    try {
      final response = await this.apiGet(ApiUrls.patreon);
      if (response.hasFailed) {
        return ResultWithValue<List<PatreonViewModel>>(
            false, List<PatreonViewModel>(), response.errorMessage);
      }
      final List newsList = json.decode(response.value);
      var releases = newsList.map((r) => PatreonViewModel.fromJson(r)).toList();
      return ResultWithValue(true, releases, '');
    } catch (exception) {
      logger.e("getPatrons Api Exception: ${exception.toString()}");
      return ResultWithValue<List<PatreonViewModel>>(
          false, List<PatreonViewModel>(), exception.toString());
    }
  }
}
