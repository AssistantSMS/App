import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

Future<ResultWithValue<List<T>>> Function() getSearchListFutureFromList<T>(
    List<T> list,
    {int Function(T, T) compare}) {
  return () => Future(
        () {
          if (compare != null) list.sort((a, b) => compare(a, b));
          return ResultWithValue<List<T>>(true, list, '');
        },
      );
}
