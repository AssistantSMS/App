import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/generated/contributorViewModel.dart';

Widget contributorTilePresenter(
  BuildContext context,
  ContributorViewModel contributor,
  int index, {
  void Function()? onTap,
}) {
  Future<void> Function() onTap;
  onTap = () => launchExternalURL(contributor.link);
  return genericListTileWithNetworkImage(
    context,
    name: contributor.name,
    imageUrl: contributor.imageUrl,
    subtitle: Text(contributor.description),
    onTap: onTap,
    trailing: IconButton(icon: const Icon(Icons.exit_to_app), onPressed: onTap),
  );
}
