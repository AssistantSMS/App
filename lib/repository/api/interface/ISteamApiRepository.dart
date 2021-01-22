import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../../../contracts/generated/SteamNewsItem.dart';

class ISteamApiRepository {
  Future<ResultWithValue<List<SteamNewsItem>>> getSteamNews() async =>
      ResultWithValue<List<SteamNewsItem>>(false, null, 'Not Implemented');
}
