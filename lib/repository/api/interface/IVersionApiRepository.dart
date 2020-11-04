import '../../../contracts/enum/platformType.dart';
import '../../../contracts/generated/AssistantApps/versionViewModel.dart';
import '../../../contracts/results/paginationResultWithValue.dart';
import '../../../contracts/results/resultWithValue.dart';

class IVersionApiRepository {
  Future<ResultWithValue<VersionViewModel>> getLatest(
      List<PlatformType> platforms) async {
    return ResultWithValue<VersionViewModel>(false, null, 'not implemented');
  }

  Future<PaginationResultWithValue<List<VersionViewModel>>> getHistory(
      String langCode, List<PlatformType> platforms,
      {int page = 1}) async {
    return PaginationResultWithValue<List<VersionViewModel>>(
        false, null, 1, 1, 'not implemented');
  }

  // TODO use this instead
  // Future<PaginationResultWithValue<List<VersionViewModel>>> getHistoryWith(
  //     String langCode, List<PlatformType> platforms,
  //     {int page = 1}) async {
  //   VersionSearchViewModel body = VersionSearchViewModel(
  //     appGuid: getEnv().assistantAppsAppGuid,
  //     languageCode: langCode,
  //     platforms: platforms,
  //     page: page,
  //   );
  //   try {
  //     final response = await this.apiPost(ApiUrls.versionSearch, body);
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
}
