import '../contracts/results/resultWithValue.dart';

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
