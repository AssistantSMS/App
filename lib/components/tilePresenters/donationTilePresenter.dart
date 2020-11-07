import 'package:flutter/material.dart';

import '../../contracts/enum/donationType.dart';
import '../../contracts/generated/AssistantApps/donationViewModel.dart';
import '../../helpers/genericHelper.dart';
import 'genericTilePresenter.dart';

Widget donationTilePresenter(BuildContext context, DonationViewModel donator) =>
    genericListTileWithSubtitle(
      context,
      leadingImage: "donation/${getImage(donator.type)}",
      name: donator.username,
      subtitle: Text(
        simpleDate(donator.date.toLocal()),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
