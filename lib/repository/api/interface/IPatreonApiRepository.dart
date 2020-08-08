import '../../../contracts/generated/PatreonViewModel.dart';
import '../../../contracts/results/resultWithValue.dart';

class IPatreonApiRepository {
  Future<ResultWithValue<List<PatreonViewModel>>> getPatrons() async =>
      ResultWithValue<List<PatreonViewModel>>(false, null, 'Not Implemented');
}
