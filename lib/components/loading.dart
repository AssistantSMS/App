import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/deviceHelper.dart';
import '../localization/localeKey.dart';
import '../localization/translations.dart';

Widget smallLoadingIndicator() =>
    /*StoreConnector<AppState, SettingViewModel>(
      converter: (store) => SettingViewModel.fromStore(store),
      builder: (_, viewModel) => isApple && viewModel.showMaterialTheme == false
          ? CupertinoActivityIndicator()
          : CircularProgressIndicator(),);*/
    CircularProgressIndicator();

Widget loadingIndicator({double height: 50.0}) => Container(
    alignment: Alignment(0, 0), child: smallLoadingIndicator(), height: height);

Widget fullPageLoading(context, {String loadingText}) => Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(children: <Widget>[
            smallLoadingIndicator(),
          ], mainAxisAlignment: MainAxisAlignment.center),
          Row(children: <Widget>[
            Container(
              margin: EdgeInsets.all(12),
            )
          ], mainAxisAlignment: MainAxisAlignment.center),
          Row(children: <Widget>[
            Text(loadingText ?? Translations.get(context, LocaleKey.loading))
          ], mainAxisAlignment: MainAxisAlignment.center),
        ],
      ),
    );

Widget unconnectedFullPageLoading(context) => Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(children: <Widget>[
            isiOS ? CupertinoActivityIndicator() : CircularProgressIndicator(),
          ], mainAxisAlignment: MainAxisAlignment.center),
          Row(children: <Widget>[
            Container(
              margin: EdgeInsets.all(12),
            )
          ], mainAxisAlignment: MainAxisAlignment.center),
        ],
      ),
    );
