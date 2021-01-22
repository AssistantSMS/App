import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:http/http.dart' as http;

import '../integration/dependencyInjection.dart';

class BaseApiRepository {
  String _baseUrl;
  BaseApiRepository({String baseUrl}) {
    _baseUrl = baseUrl ?? getEnv().scrapAssistantApiUrl;
  }

  Future<ResultWithValue<String>> apiPost(String url, dynamic body) async {
    try {
      getLog().d('post request to: $_baseUrl/$url');
      getLog().d('post request body: $body');
      final response = await http.post('$_baseUrl/$url',
          body: body, headers: {"Content-Type": "application/json"});
      if (response.statusCode != 200) {
        getLog().e('Status Code: ${response.statusCode}.');
        getLog().e('Not a 200 OK response ${response.body}');
        return ResultWithValue<String>(false, '', 'Not a 200 OK response');
      }
      getLog().d('post response body: ${response.body}');
      return ResultWithValue<String>(true, response.body, '');
    } catch (exception) {
      getLog().e("BaseApiService POST Exception: ${exception.toString()}");
      return ResultWithValue<String>(false, '', exception.toString());
    }
  }

  Future<ResultWithValue<String>> apiGet(String url,
      {Map<String, String> headers}) async {
    return await this.webGet('$_baseUrl/$url', headers: headers);
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
