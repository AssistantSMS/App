import 'package:flutter/material.dart';

import '../../components/tilePresenters/genericTilePresenter.dart';
import '../../components/tilePresenters/raidTilePresenter.dart';
import '../../contracts/misc/popupMenuActionItem.dart';
import '../../contracts/raid/raidFarmDetails.dart';
import '../../helpers/external.dart';
import '../../helpers/popupMenuButtonHelper.dart';
import '../../helpers/raidHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';

const greenyDevGithubImage =
    'https://avatars0.githubusercontent.com/u/3734204?s=460&u=7eb6ec6aa9200855109647c7fcdd159069b673fe&v=4';
const greenyDevGithubLink = 'https://github.com/greeny/?ref=AssistantSMS';
const greenyDevTool = 'https://scrapmechanic.greeny.dev/?ref=AssistantSMS';

class RaidCalcMobileInputScreen extends StatelessWidget {
  final RaidFarmDetails currentDetails;
  final Function(RaidFarmDetails) setFarmQuantity;
  RaidCalcMobileInputScreen(this.setFarmQuantity, this.currentDetails);

  @override
  Widget build(BuildContext context) {
    var currentPlants = RaidHelper.getPlantsWithQuantity(currentDetails);
    bool hasAllPlants = currentPlants.length >= RaidHelper.plants.length;

    List<Widget> columnWidgets = List<Widget>();
    var onGreenyPress = () => launchExternalURL(greenyDevTool);
    columnWidgets.add(genericListTileWithNetworkImage(
      context,
      imageUrl: greenyDevGithubImage,
      name: Translations.get(context, LocaleKey.originalWorkByGreenyDev),
      trailing: popupMenu(context, additionalItems: [
        PopupMenuActionItem(
          icon: Icons.open_in_new,
          text: 'Open tool in new Window',
          onPressed: onGreenyPress,
        )
      ]),
      onTap: onGreenyPress,
    ));

    for (var plantId in currentPlants) {
      columnWidgets.add(
        raidTilePresenter(
          context,
          plantId,
          currentDetails,
          onEdit: _setFarmQuantity,
          onDelete: (String itemId) => _setFarmQuantity(itemId, 0),
        ),
      );
    }

    if (!hasAllPlants) {
      columnWidgets.add(raidAddPlantTilePresenter(context, _setFarmQuantity));
    }

    return Column(children: columnWidgets);
  }

  void _setFarmQuantity(String itemId, int quantity) {
    RaidFarmDetails temp = RaidHelper.setFarmDetailsQuantity(
      currentDetails,
      itemId,
      quantity,
    );

    if (temp == null) return;
    if (setFarmQuantity == null) return;

    setFarmQuantity(temp);
  }
}
