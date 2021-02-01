import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:http/http.dart' as http;

class BaseGithubApiRepository {
  String _repoBaseUrl;
  BaseGithubApiRepository({String repoUrl}) {
    _repoBaseUrl =
        repoUrl ?? 'https://raw.githubusercontent.com/AssistantSMS/App/master/';
  }

  Future<ResultWithValue<String>> getFile(String filename,
      {Map<String, String> headers}) async {
    return await this.webGet('$_repoBaseUrl/$filename', headers: headers);
  }

  Future<ResultWithValue<String>> webGet(String url,
      {Map<String, String> headers}) async {
    try {
      getLog().d('web get request to: $url');
      final response = await http.get(url, headers: headers);
      if (response.statusCode != 200) {
        return ResultWithValue<String>(false, '', 'Not a 200 OK response');
      }
      return ResultWithValue<String>(true, response.body, '');
    } catch (exception) {
      getLog().e("BaseApiService GET Exception: ${exception.toString()}");
      return ResultWithValue<String>(false, '', exception.toString());
    }
  }
}
