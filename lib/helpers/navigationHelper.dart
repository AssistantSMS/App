import 'package:flutter/material.dart';

import '../constants/Routes.dart';
import '../integration/logging.dart';
import 'deviceHelper.dart';

Future<bool> navigateBackOrHomeAsync(context) async {
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
    return Future.value(false);
  }
  // else {
  //   return navigateHomeAsync(context);
  // }

  if (isWeb) await Navigator.pushReplacementNamed(context, Routes.home);

  return Future.value(true);
}

Future<bool> navigateHomeAsync(context,
    {Function navigateTo, String navigateToNamed}) async {
  Navigator.popUntil(context, (r) => !Navigator.canPop(context));

  if (navigateTo != null) {
    // await Navigator.pushReplacement(
    await Navigator.push(
      context,
      MaterialPageRoute(builder: navigateTo),
    );
  } else if (navigateToNamed != null) {
    if (navigateToNamed == Routes.home) return Future.value(false);
    Navigator.pushNamed(
      context,
      navigateToNamed,
    );
  } else {
    // await Navigator.pushReplacementNamed(context, Routes.home);
  }

  return Future.value(false);
}

Future navigateAwayFromHomeAsync(
  context, {
  Function navigateTo,
  String navigateToNamed,
  Map<String, String> navigateToNamedParameters,
}) async {
  if (navigateTo != null) {
    if (Navigator.canPop(context)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: navigateTo),
      );
    } else {
      // Navigator.pushReplacement(
      Navigator.push(
        context,
        MaterialPageRoute(builder: navigateTo),
      );
    }
  } else {
    // Navigator.pushReplacementNamed(
    String routeWithQueryParams = navigateToNamed;
    for (var paramKey in navigateToNamedParameters?.keys ?? []) {
      var value = navigateToNamedParameters[paramKey];
      routeWithQueryParams =
          routeWithQueryParams.replaceAll('/:$paramKey', '/$value');
    }
    logger.i(routeWithQueryParams);
    Navigator.pushNamed(
      context,
      routeWithQueryParams,
    );
  }
}

Future<T> navigateAsync<T extends Object>(context,
    {Function navigateTo, String navigateToNamed}) async {
  if (navigateTo != null) {
    return await Navigator.push(
      context,
      MaterialPageRoute(builder: navigateTo),
    );
  } else {
    return await Navigator.pushNamed(
      context,
      navigateToNamed,
    );
  }
}
