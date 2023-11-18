import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/AppImage.dart';

class PathService implements IPathService {
  final String imageAssetPath;

  PathService({
    this.imageAssetPath = 'assets/img',
  });

  @override
  String get imageAssetPathPrefix => imageAssetPath;

  @override
  Widget get steamNewsDefaultImage =>
      const LocalImage(imagePath: AppImage.steamNewsDefault);

  @override
  String get defaultProfilePic => throw UnimplementedError();

  @override
  String get unknownImagePath => AppImage.unknown;

  @override
  String get defaultGuideImage => AppImage.unknown;

  @override
  String ofImage(String imagePartialPath) {
    if (imagePartialPath.contains(imageAssetPath)) {
      return imagePartialPath;
    }

    return '$imageAssetPath/$imagePartialPath';
  }
}
