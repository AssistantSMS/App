import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../BaseApiRepository.dart';
import 'interface/ISteamApiRepository.dart';
import '../../constants/ApiUrls.dart';
import '../../contracts/generated/SteamNewsItem.dart';

class SteamApiRepository extends BaseApiRepository
    implements ISteamApiRepository {
  Future<ResultWithValue<List<SteamNewsItem>>> getSteamNews() async {
    try {
      final response = await this.apiGet(ApiUrls.steamNews);
      if (response.hasFailed) {
        return ResultWithValue<List<SteamNewsItem>>(
            false, List<SteamNewsItem>(), response.errorMessage);
      }
      final List newsList = json.decode(response.value);
      var releases = newsList.map((r) => SteamNewsItem.fromJson(r)).toList();
      return ResultWithValue(true, releases, '');
    } catch (exception) {
      getLog().e("getSteamNews Api Exception: ${exception.toString()}");
      return ResultWithValue<List<SteamNewsItem>>(
          false, List<SteamNewsItem>(), exception.toString());
    }
  }
}
