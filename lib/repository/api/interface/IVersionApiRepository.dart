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
}
