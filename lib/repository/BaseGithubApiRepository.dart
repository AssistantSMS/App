import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class BaseGithubApiRepository extends BaseApiService {
  String _repoBaseUrl;
  BaseGithubApiRepository({String repoUrl}) : super(getBaseUrl(repoUrl)) {
    _repoBaseUrl = getBaseUrl(repoUrl);
  }

  static String getBaseUrl(String repoUrl) {
    return repoUrl ??
        'https://raw.githubusercontent.com/AssistantSMS/App/master/';
  }

  Future<ResultWithValue<String>> getFile(String filename,
      {Map<String, String> headers}) async {
    return await this.webGet('$_repoBaseUrl/$filename', headers: headers);
  }
}
