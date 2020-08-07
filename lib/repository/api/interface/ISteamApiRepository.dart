import '../../../contracts/generated/SteamNewsItem.dart';
import '../../../contracts/results/resultWithValue.dart';

class ISteamApiRepository {
  Future<ResultWithValue<List<SteamNewsItem>>> getSteamNews() async =>
      ResultWithValue<List<SteamNewsItem>>(false, null, 'Not Implemented');
}
