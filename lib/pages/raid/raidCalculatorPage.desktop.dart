import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../components/tilePresenters/raidTilePresenter.dart';
import '../../components/webSpecific/mousePointer.dart';
import '../../helpers/columnHelper.dart';
import '../../helpers/raidHelper.dart';
import '../../state/modules/raid/raidViewModel.dart';

const greenyDevGithubImage =
    'https://avatars0.githubusercontent.com/u/3734204?s=460&u=7eb6ec6aa9200855109647c7fcdd159069b673fe&v=4';
const greenyDevGithubLink = 'https://github.com/greeny/?ref=AssistantSMS';
const greenyDevTool = 'https://scrapmechanic.greeny.dev/?ref=AssistantSMS';

class RaidCalcDesktopInputScreen extends StatelessWidget {
  final RaidViewModel currentDetails;
  const RaidCalcDesktopInputScreen(this.currentDetails, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return gridWithScrollbar(
      itemCount: (RaidHelper.plants.length + 1),
      gridViewColumnCalculator: raidCustomColumnCount,
      itemBuilder: (context, index) {
        if (index < RaidHelper.plants.length) {
          var plantId = RaidHelper.plants[index];
          return raidGridTilePresenter(
            context,
            plantId,
            RaidHelper.getPlantQuantity(currentDetails, plantId),
            _setFarmQuantity,
          );
        }
        return GestureDetector(
          child: Card(
            child: Column(
              children: [
                networkImage(greenyDevGithubImage, height: 110),
                Padding(
                  child: Text(
                    getTranslations()
                        .fromKey(LocaleKey.originalWorkByGreenyDev),
                    textAlign: TextAlign.center,
                  ),
                  padding: const EdgeInsets.all(8),
                ),
              ],
            ),
          ),
          onTap: () => launchExternalURL(greenyDevTool),
        ).showPointerOnHover;
      },
    );
  }

  void _setFarmQuantity(String itemId, int quantity) {
    RaidViewModel temp = RaidHelper.setFarmDetailsQuantity(
      currentDetails,
      itemId,
      quantity,
    );

    if (temp == null) return;
    currentDetails.editRaidItem(
      carrot: temp.carrot,
      tomato: temp.tomato,
      beetroot: temp.beetroot,
      banana: temp.banana,
      berry: temp.berry,
      orange: temp.orange,
      potato: temp.potato,
      pineapple: temp.pineapple,
      broccoli: temp.broccoli,
      cotton: temp.cotton,
    );
  }
}
