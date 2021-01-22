import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../../contracts/generated/contributorViewModel.dart';
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
      getLog().e("getContributors Api Exception: ${exception.toString()}");
      return ResultWithValue<List<ContributorViewModel>>(
          false, List<ContributorViewModel>(), exception.toString());
    }
  }
}
