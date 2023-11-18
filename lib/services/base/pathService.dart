import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/AppImage.dart';

class PathService implements IPathService {
  @override
  String get imageAssetPathPrefix => 'assets/img';

  @override
  Widget get steamNewsDefaultImage =>
      const LocalImage(imagePath: AppImage.steamNewsDefault);

  @override
  String get defaultProfilePic => throw UnimplementedError();

  @override
  String get unknownImagePath => AppImage.unknown;

  @override
  String get defaultGuideImage => AppImage.unknown;
}
