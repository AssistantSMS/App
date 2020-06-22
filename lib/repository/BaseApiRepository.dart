import 'package:http/http.dart' as http;

import '../contracts/results/resultWithValue.dart';
import '../integration/logging.dart';
import '../integration/dependencyInjection.dart';

class BaseApiRepository {
  Future<ResultWithValue<String>> apiPost(String url, dynamic body) async {
    try {
      var baseApi = getEnv().baseApi;
      logger.d('post request to: $baseApi/$url');
      logger.d('post request body: $body');
      final response = await http.post('$baseApi/$url',
          body: body, headers: {"Content-Type": "application/json"});
      if (response.statusCode != 200) {
        logger.e('Not a 200 OK response ${response.body}');
        return ResultWithValue<String>(false, '', 'Not a 200 OK response');
      }
      logger.d('post response body: ${response.body}');
      return ResultWithValue<String>(true, response.body, '');
    } catch (exception) {
      logger.e("BaseApiService POST Exception: ${exception.toString()}");
      return ResultWithValue<String>(false, '', exception.toString());
    }
  }

  Future<ResultWithValue<String>> apiGet(String url,
      {Map<String, String> headers}) async {
    var baseApi = getEnv().baseApi;
    return await this.webGet('$baseApi/$url', headers: headers);
  }

  Future<ResultWithValue<String>> webGet(String url,
      {Map<String, String> headers}) async {
    try {
      logger.d('web get request to: $url');
      final response = await http.get(url, headers: headers);
      if (response.statusCode != 200) {
        return ResultWithValue<String>(false, '', 'Not a 200 OK response');
      }
      return ResultWithValue<String>(true, response.body, '');
    } catch (exception) {
      logger.e("BaseApiService GET Exception: ${exception.toString()}");
      return ResultWithValue<String>(false, '', exception.toString());
    }
  }
}
