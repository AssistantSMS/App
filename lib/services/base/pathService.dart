import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/AppImage.dart';

class PathService implements IPathService {
  String imageAssetPathPrefix() => 'assets/img';
  Widget steamNewsDefaultImage() => localImage(AppImage.steamNewsDefault);
}
