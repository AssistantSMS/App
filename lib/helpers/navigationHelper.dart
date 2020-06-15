import 'package:flutter/material.dart';

Future<bool> navigateBackOrHomeAsync(context) async {
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
    return Future.value(false);
  }

  // await Navigator.pushReplacementNamed(context, Routes.home);

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
    Navigator.pushNamed(
      context,
      navigateToNamed,
    );
  } else {
    // await Navigator.pushReplacementNamed(context, Routes.home);
  }

  return Future.value(false);
}

Future navigateAwayFromHomeAsync(context,
    {Function navigateTo, String navigateToNamed}) async {
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
    Navigator.pushNamed(
      context,
      navigateToNamed,
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
