import 'dart:convert';

import '../../contracts/generated/ContributorViewModel.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../integration/logging.dart';
import '../BaseGithubApiRepository.dart';
import 'interface/IContributorApiRepository.dart';

class ContributorApiRepository extends BaseGithubApiRepository
    implements IContributorApiRepository {
  Future<ResultWithValue<List<ContributorViewModel>>> getContributors() async {
    try {
      final response = await this.getFile('contributors.json');
      if (response.hasFailed) {
        return ResultWithValue<List<ContributorViewModel>>(
            false, List<ContributorViewModel>(), response.errorMessage);
      }
      final List newsList = json.decode(response.value);
      var contributors =
          newsList.map((r) => ContributorViewModel.fromJson(r)).toList();
      return ResultWithValue(true, contributors, '');
    } catch (exception) {
      logger.e("getContributors Api Exception: ${exception.toString()}");
      return ResultWithValue<List<ContributorViewModel>>(
          false, List<ContributorViewModel>(), exception.toString());
    }
  }
}

// class ContributorApiRepository extends BaseApiRepository
//     implements IContributorApiRepository {
//   ContributorApiRepository() : super(baseUrl: getEnv().assistantAppsApiUrl);

//   Future<ResultWithValue<List<ContributorViewModel>>> getContributors() async {
//     try {
//       final response = await this.apiGet(ApiUrls.contributors);
//       if (response.hasFailed) {
//         return ResultWithValue<List<ContributorViewModel>>(
//             false, List<ContributorViewModel>(), response.errorMessage);
//       }
//       final List newsList = json.decode(response.value);
//       var contributors =
//           newsList.map((r) => ContributorViewModel.fromJson(r)).toList();
//       return ResultWithValue(true, contributors, '');
//     } catch (exception) {
//       logger.e("getContributors Api Exception: ${exception.toString()}");
//       return ResultWithValue<List<ContributorViewModel>>(
//           false, List<ContributorViewModel>(), exception.toString());
//     }
//   }
// }
