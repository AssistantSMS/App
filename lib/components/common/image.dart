import 'package:flutter/material.dart';

import '../../constants/ExternalUrls.dart';
import '../loading.dart';

Widget networkImage(
  String imageUrl, {
  BoxFit boxfit,
  double height,
  double width,
  Widget placeHolder,
}) {
  return SizedBox(
    height: height,
    width: width,
    child: Image.network(
      (imageUrl != null && imageUrl.contains('http'))
          ? imageUrl
          : ExternalUrls.defaultProfilePic,
      fit: boxfit,
      height: height,
      width: width,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
            child: Padding(
          child: placeHolder ?? smallLoadingIndicator(),
          padding: EdgeInsets.all(12),
        ));
      },
    ),
  );
}

Widget localImage(
  String imagePath, {
  BoxFit boxfit,
  double height,
  double width,
  bool imageGreyScale = false,
  EdgeInsetsGeometry padding = EdgeInsets.zero,
}) {
  var image = Image(
    image: AssetImage(imagePath),
    fit: boxfit,
    height: height,
    width: width,
  );
  return Padding(
    child: imageGreyScale
        ? ColorFiltered(
            colorFilter: ColorFilter.matrix(<double>[
              0.2126,
              0.7152,
              0.0722,
              0,
              0,
              0.2126,
              0.7152,
              0.0722,
              0,
              0,
              0.2126,
              0.7152,
              0.0722,
              0,
              0,
              0,
              0,
              0,
              1,
              0,
            ]),
            child: image,
          )
        : image,
    padding: padding,
  );
}
