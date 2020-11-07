import '../../../contracts/generated/AssistantApps/donationViewModel.dart';
import '../../../contracts/results/paginationResultWithValue.dart';

class IDonatorApiRepository {
  Future<PaginationResultWithValue<List<DonationViewModel>>> getDonators(
          {int page = 1}) async =>
      PaginationResultWithValue<List<DonationViewModel>>(
          false, null, 1, 1, 'Not Implemented');
}
