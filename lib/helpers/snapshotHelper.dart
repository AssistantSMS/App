import 'package:flutter/material.dart';

import '../components/loading.dart';
import '../localization/localeKey.dart';
import '../localization/translations.dart';

Widget asyncSnapshotHandler<T>(BuildContext context, AsyncSnapshot<T> snapshot,
    {bool Function(T) isValidFunction,
    Widget Function() invalidBuilder,
    Widget Function() loader}) {
  Widget errorWidget = const Text('An Error has occurred');
  switch (snapshot.connectionState) {
    case ConnectionState.none:
      return errorWidget;
    case ConnectionState.done:
      if (snapshot.hasError) {
        return Text(
          '${snapshot.error}',
          style: TextStyle(color: Colors.red),
        );
      }
      break;
    default:
      if (loader != null) return loader();
      return fullPageLoading(
        context,
        loadingText: Translations.get(context, LocaleKey.loading),
      );
  }

  if (snapshot.data == null) return errorWidget;
  if (isValidFunction != null && !isValidFunction(snapshot.data)) {
    if (invalidBuilder != null) return invalidBuilder();
    return errorWidget;
  }

  return null;
}
