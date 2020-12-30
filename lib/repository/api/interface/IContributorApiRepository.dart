import '../../../contracts/generated/AssistantApps/contributorViewModel.dart';
import '../../../contracts/results/resultWithValue.dart';

class IContributorApiRepository {
  Future<ResultWithValue<List<ContributorViewModel>>> getContributors() async =>
      ResultWithValue<List<ContributorViewModel>>(
          false, null, 'Not Implemented');
}
