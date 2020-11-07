import '../../constants/ApiUrls.dart';
import '../../contracts/enum/platformType.dart';
import '../../contracts/generated/AssistantApps/versionViewModel.dart';
import '../../contracts/results/paginationResultWithValue.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../integration/dependencyInjection.dart';
import '../../integration/logging.dart';
import '../BaseApiRepository.dart';
import 'interface/IVersionApiRepository.dart';

class VersionApiRepository extends BaseApiRepository
    implements IVersionApiRepository {
  VersionApiRepository() : super(baseUrl: getEnv().assistantAppsApiUrl);

  Future<ResultWithValue<VersionViewModel>> getLatest(
      List<PlatformType> platforms) async {
    var url = "${ApiUrls.appVersion}/${getEnv().assistantAppsAppGuid}";
    try {
      final response = await this.apiGet(url);
      if (response.hasFailed) {
        return ResultWithValue<VersionViewModel>(
            false, VersionViewModel(), response.errorMessage);
      }
      return ResultWithValue(
          true, VersionViewModel.fromRawJson(response.value), '');
    } catch (exception) {
      logger.e("getLatest Api Exception: ${exception.toString()}");
      return ResultWithValue<VersionViewModel>(
          false, VersionViewModel(), exception.toString());
    }
  }

  // Future<PaginationResultWithValue<List<VersionViewModel>>> getHistory(
  //     String langCode, List<PlatformType> platforms,
  //     {int page = 1}) async {
  //   var platString = '';
  //   for (PlatformType plat in platforms) {
  //     if (platString.length > 5) platString += '&';
  //     platString += 'platforms=${platformTypeValues.reverse[plat]}';
  //   }
  //   var appGuid = getEnv().assistantAppsAppGuid;
  //   var url = "${ApiUrls.appVersion}/$appGuid/$langCode?$platString&page=$page";
  //   try {
  //     final response = await this.apiGet(url);
  //     if (response.hasFailed) {
  //       return PaginationResultWithValue<List<VersionViewModel>>(
  //           false, List<VersionViewModel>(), 0, 0, response.errorMessage);
  //     }
  //     var paginationResult = PaginationResultWithValueMapper()
  //         .fromRawJson<List<VersionViewModel>>(response.value, (List valueDyn) {
  //       return valueDyn.map((r) => VersionViewModel.fromJson(r)).toList();
  //     });
  //     return paginationResult;
  //   } catch (exception) {
  //     logger.e("getHistory Api Exception: ${exception.toString()}");
  //     return PaginationResultWithValue<List<VersionViewModel>>(
  //         false, List<VersionViewModel>(), 0, 0, exception.toString());
  //   }
  // }

  Future<PaginationResultWithValue<List<VersionViewModel>>> getHistoryWith(
      String langCode, List<PlatformType> platforms,
      {int page = 1}) async {
    VersionSearchViewModel body = VersionSearchViewModel(
      appGuid: getEnv().assistantAppsAppGuid,
      languageCode: langCode,
      platforms: platforms,
      page: page,
    );
    try {
      final response = await this.apiPost(ApiUrls.versionSearch, body);
      if (response.hasFailed) {
        return PaginationResultWithValue<List<VersionViewModel>>(
            false, List<VersionViewModel>(), 0, 0, response.errorMessage);
      }
      var paginationResult = PaginationResultWithValueMapper()
          .fromRawJson<List<VersionViewModel>>(response.value, (List valueDyn) {
        return valueDyn.map((r) => VersionViewModel.fromJson(r)).toList();
      });
      return paginationResult;
    } catch (exception) {
      logger.e("getHistory Api Exception: ${exception.toString()}");
      return PaginationResultWithValue<List<VersionViewModel>>(
          false, List<VersionViewModel>(), 0, 0, exception.toString());
    }
  }
}
