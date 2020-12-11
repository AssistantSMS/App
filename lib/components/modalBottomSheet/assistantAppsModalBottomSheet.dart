import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

import '../../components/common/image.dart';
import '../../components/loading.dart';
import '../../components/tilePresenters/genericTilePresenter.dart';
import '../../constants/AppImage.dart';
import '../../constants/ExternalUrls.dart';
import '../../contracts/generated/AssistantApps/assistantAppLinks.dart';
import '../../contracts/misc/popupMenuActionItem.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../helpers/deviceHelper.dart';
import '../../helpers/external.dart';
import '../../helpers/genericHelper.dart';
import '../../helpers/popupMenuButtonHelper.dart';
import '../../helpers/stringHelper.dart';
import '../../services/json/assistantAppLinksBackupJsonService.dart';

class AssistantAppsModalBottomSheet extends StatefulWidget {
  AssistantAppsModalBottomSheet();

  @override
  _AssistantAppsModalBottomSheetWidget createState() =>
      _AssistantAppsModalBottomSheetWidget();
}

class _AssistantAppsModalBottomSheetWidget
    extends State<AssistantAppsModalBottomSheet>
    with
        TickerProviderStateMixin,
        AfterLayoutMixin<AssistantAppsModalBottomSheet> {
  List<AssistantAppLinks> assistantAppLinks;
  bool isLoading = true;
  _AssistantAppsModalBottomSheetWidget() {
    assistantAppLinks = List<AssistantAppLinks>();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    getAppLinksFuture(context);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List<Widget>();
    widgets.add(emptySpace1x());
    widgets.add(
      localImage('${AppImage.base}${AppImage.assistantApps}', height: 75),
    );
    widgets.add(genericItemName('AssistantApps'));
    widgets.add(genericItemDescription(
      'This app is part of the AssistantApps range',
    ));
    if (isLoading) {
      widgets.add(Center(child: smallLoadingIndicator()));
    } else {
      widgets.add(Divider());
      for (var appLink in assistantAppLinks) {
        List<PopupMenuActionItem> popups = [
          if (appLink.ios != null) ...[
            PopupMenuActionItem(
              icon: Icons.phone_iphone,
              text: 'iOS',
              onPressed: () => launchExternalURL(appLink.ios),
            )
          ],
          if (appLink.android != null && !isiOS) ...[
            PopupMenuActionItem(
              icon: Icons.phone_android,
              text: 'Android',
              onPressed: () => launchExternalURL(appLink.android),
            )
          ],
          if (appLink.web != null) ...[
            PopupMenuActionItem(
              icon: Icons.language,
              text: 'Web',
              onPressed: () => launchExternalURL(appLink.web),
            )
          ],
        ];
        String platforms = 'Available on: ' +
            joinStringList(
              popups.map((p) => p.text).toList(),
              ', ',
            );

        widgets.add(
          Card(
            child: genericListTileWithNetworkImage(
              context,
              imageUrl: appLink.iconUrl,
              name: appLink.name,
              onTap: (appLink.home != null)
                  ? () => launchExternalURL(appLink.home)
                  : () {},
              trailing: popupMenu(
                context,
                customIcon: Icons.open_in_new,
                additionalItems: popups,
              ),
              subtitle: Text(platforms, maxLines: 1),
            ),
          ),
        );
        widgets.add(emptySpace1x());
      }

      widgets.add(
        Card(
          child: genericListTileWithSubtitle(
            context,
            leadingImage: 'unknown.png',
            name: 'Coming soon',
          ),
        ),
      );
      widgets.add(emptySpace1x());
    }

    return Stack(
      children: [
        AnimatedSize(
          vsync: this,
          duration: const Duration(milliseconds: 150),
          child: Container(
            constraints: BoxConstraints(
              minHeight: (MediaQuery.of(context).size.height) / 2,
            ),
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: widgets.length,
              itemBuilder: (_, int index) => widgets[index],
              shrinkWrap: true,
            ),
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: IconButton(
            icon: Icon(Icons.open_in_new),
            onPressed: () => launchExternalURL(
              ExternalUrls.assistantAppsWebsite,
            ),
          ),
        )
      ],
    );
  }

  Future getAppLinksFuture(BuildContext context) async {
    ResultWithValue<List<AssistantAppLinks>> assistantAppsResult =
        await AssistantAppLinksBackupJsonService().getAll(context);
    if (assistantAppsResult.hasFailed) return;

    this.setState(() {
      isLoading = false;
      assistantAppLinks = assistantAppsResult.value;
    });
  }
}
