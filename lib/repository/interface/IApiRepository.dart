import 'package:scrapmechanic_kurtlourens_com/contracts/generated/SteamNewsItem.dart';
import 'package:scrapmechanic_kurtlourens_com/contracts/results/resultWithValue.dart';

class IApiRepository {
  Future<ResultWithValue<List<SteamNewsItem>>> getSteamNews() async =>
      ResultWithValue<List<SteamNewsItem>>(false, null, 'Not Implemented');
}
