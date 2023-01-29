import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/Routes.dart';

class NavigationService implements INavigationService {
  @override
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

  @override
  Future<bool> navigateHomeAsync(
    context, {
    Widget Function(BuildContext)? navigateTo,
    String? navigateToNamed,
    bool? pushReplacement,
  }) async {
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

  @override
  Future navigateAwayFromHomeAsync(
    context, {
    Widget Function(BuildContext)? navigateTo,
    String? navigateToNamed,
    Map<String, String>? navigateToNamedParameters,
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
      String routeWithQueryParams = navigateToNamed ?? '';
      var paramKeys = navigateToNamedParameters?.keys ?? [];
      for (var paramKey in paramKeys) {
        var value = navigateToNamedParameters![paramKey];
        routeWithQueryParams =
            routeWithQueryParams.replaceAll('/:$paramKey', '/$value');
      }
      getLog().i(routeWithQueryParams);
      Navigator.pushNamed(
        context,
        routeWithQueryParams,
      );
    }
  }

  @override
  Future<T?> navigateAsync<T extends Object>(
    context, {
    Widget Function(BuildContext)? navigateTo,
    String? navigateToNamed,
  }) async {
    if (navigateTo != null) {
      return await Navigator.push(
        context,
        MaterialPageRoute(builder: navigateTo),
      );
    } else if (navigateToNamed != null) {
      return await Navigator.pushNamed<dynamic>(
        context,
        navigateToNamed,
      );
    }
    return null;
  }

  @override
  Future pop<T extends Object>(BuildContext context, [T? result]) async {
    Navigator.of(context).pop(result);
  }

  @override
  Future popUntil(BuildContext context, List<String> routes) async {
    getLog().i('navigationService - pop');
    Navigator.of(context).popUntil((Route<dynamic> route) {
      return !route.willHandlePopInternally &&
          route is ModalRoute &&
          (routes.contains(route.settings.name));
    });
  }
}
