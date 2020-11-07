import '../../constants/ApiUrls.dart';
import '../../contracts/generated/AssistantApps/donationViewModel.dart';
import '../../contracts/results/paginationResultWithValue.dart';
import '../../integration/dependencyInjection.dart';
import '../../integration/logging.dart';
import '../BaseApiRepository.dart';
import 'interface/IDonatorApiRepository.dart';

class DonatorApiRepository extends BaseApiRepository
    implements IDonatorApiRepository {
  DonatorApiRepository() : super(baseUrl: getEnv().assistantAppsApiUrl);

  Future<PaginationResultWithValue<List<DonationViewModel>>> getDonators(
      {int page = 1}) async {
    String url = '${ApiUrls.donation}?page=$page';
    try {
      final response = await this.apiGet(url);
      if (response.hasFailed) {
        return PaginationResultWithValue<List<DonationViewModel>>(
            false, List<DonationViewModel>(), 1, 0, response.errorMessage);
      }
      var paginationResult = PaginationResultWithValueMapper()
          .fromRawJson<List<DonationViewModel>>(response.value,
              (List valueDyn) {
        return valueDyn.map((r) => DonationViewModel.fromJson(r)).toList();
      });
      return paginationResult;
    } catch (exception) {
      logger.e("donators Api Exception: ${exception.toString()}");
      return PaginationResultWithValue<List<DonationViewModel>>(
          false, List<DonationViewModel>(), 1, 0, exception.toString());
    }
  }
}
