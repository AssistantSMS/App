import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/constants/AppImage.dart';

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
  bool imageInvertColor = false,
  EdgeInsetsGeometry padding = EdgeInsets.zero,
}) {
  var image = Padding(
    child: Image(
      image: AssetImage(imagePath),
      fit: boxfit,
      height: height,
      width: width,
    ),
    padding: padding,
  );
  if (imageGreyScale == false && imageInvertColor == false) return image;

  List<double> matrix = AppImage.predefinedColorFilterMatrixGreyScale;
  if (imageInvertColor) matrix = AppImage.predefinedColorFilterMatrixInverse;
  return ColorFiltered(
    colorFilter: ColorFilter.matrix(matrix),
    child: image,
  );
}
