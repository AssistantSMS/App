import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/constants/AppImage.dart';

import '../helpers/deviceHelper.dart';
import '../localization/localeKey.dart';
import '../localization/translations.dart';

Widget smallLoadingIndicator() =>
    /*StoreConnector<AppState, SettingViewModel>(
      converter: (store) => SettingViewModel.fromStore(store),
      builder: (_, viewModel) => isApple && viewModel.showMaterialTheme == false
          ? CupertinoActivityIndicator()
          : CircularProgressIndicator(),);*/
    // CircularProgressIndicator();
    CustomSpinner();

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
            CustomSpinner(),
          ], mainAxisAlignment: MainAxisAlignment.center),
          Row(children: <Widget>[
            Container(
              margin: EdgeInsets.all(12),
            )
          ], mainAxisAlignment: MainAxisAlignment.center),
        ],
      ),
    );

class CustomSpinner extends StatefulWidget {
  final double height;
  final double width;
  final Duration spinDuration;
  CustomSpinner({
    this.height = 50.0,
    this.width = 50.0,
    this.spinDuration = const Duration(seconds: 2),
  });

  @override
  _CustomSpinnerWidget createState() => _CustomSpinnerWidget();
}

class _CustomSpinnerWidget extends State<CustomSpinner>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: widget.spinDuration,
      vsync: this,
    );

    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.repeat();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: SizedBox(
        child: Image(
          image: AssetImage(AppImage.customLoading),
        ),
        height: widget.height,
        width: widget.width,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
