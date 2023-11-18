import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../../../contracts/generated/contributorViewModel.dart';

class IContributorApiRepository {
  Future<ResultWithValue<List<ContributorViewModel>>> getContributors() async =>
      ResultWithValue<List<ContributorViewModel>>(
          false, List.empty(), 'Not Implemented');
}
