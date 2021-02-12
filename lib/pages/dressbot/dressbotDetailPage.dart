import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../components/common/cachedFutureBuilder.dart';
import '../../components/scaffoldTemplates/genericPageScaffold.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../constants/AppImage.dart';
import '../../constants/AppPadding.dart';
import '../../contracts/enum/customisationSourceType.dart';
import '../../contracts/gameItem/gameItemPageItem.dart';
import '../../helpers/futureHelper.dart';
import '../../helpers/genericHelper.dart';
import '../../state/modules/base/appState.dart';
import '../../state/modules/cosmetic/cosmeticViewModel.dart';

class DressBotDetailPage extends StatelessWidget {
  final String itemId;
  final bool isInDetailPane;
  final void Function(Widget newDetailView) updateDetailView;

  DressBotDetailPage(
    this.itemId, {
    this.isInDetailPane = false,
    this.updateDetailView,
  }) {
    getAnalytics()
        .trackEvent('${AnalyticsEvent.itemDetailPage}: ${this.itemId}');
  }

  @override
  Widget build(BuildContext context) {
    String loading = getTranslations().fromKey(LocaleKey.loading);
    var loadingWidget = getLoading().fullPageLoading(
      context,
      loadingText: loading,
    );
    return CachedFutureBuilder<ResultWithValue<GameItemPageItem>>(
      future: gameItemPageItemFuture(context, this.itemId),
      whileLoading: isInDetailPane
          ? loadingWidget
          : genericPageScaffold(context, loading, null,
              body: (_, __) => loadingWidget, showShortcutLinks: true),
      whenDoneLoading:
          (AsyncSnapshot<ResultWithValue<GameItemPageItem>> snapshot) {
        var bodyWidget = StoreConnector<AppState, CosmeticViewModel>(
          converter: (store) => CosmeticViewModel.fromStore(store),
          builder: (_, viewModel) => getBody(context, viewModel, snapshot),
        );
        if (isInDetailPane) return bodyWidget;
        return genericPageScaffold<ResultWithValue<GameItemPageItem>>(
          context,
          snapshot?.data?.value?.gameItem?.title ?? loading,
          snapshot,
          body: (_, __) => bodyWidget,
          showShortcutLinks: true,
        );
      },
    );
  }

  Widget getBody(
    BuildContext context,
    CosmeticViewModel viewModel,
    AsyncSnapshot<ResultWithValue<GameItemPageItem>> snapshot,
  ) {
    Widget errorWidget = asyncSnapshotHandler(context, snapshot,
        isValidFunction: (ResultWithValue<GameItemPageItem> gameItemResult) {
      if (!gameItemResult.isSuccess) return false;
      if (gameItemResult.value == null) return false;
      return true;
    });
    if (errorWidget != null) return errorWidget;

    var gameItem = snapshot?.data?.value?.gameItem;

    List<Widget> widgets = List.empty(growable: true);

    if (gameItem.icon != null) {
      widgets.add(genericItemImage(
        context,
        '${AppImage.base}${gameItem.icon}',
        name: gameItem.title,
      ));
    }
    widgets.add(emptySpace1x());
    widgets.add(genericItemName(gameItem.title));

    var isOwned = ((viewModel?.owned ?? List.empty(growable: true))
        .any((own) => own == gameItem.id));
    widgets.add(emptySpace1x());
    widgets.add(genericItemDescription(
      getTranslations().fromKey(isOwned ? LocaleKey.owned : LocaleKey.notOwned),
      textStyle: TextStyle(
        color: getTheme().getSecondaryColour(context),
      ),
    ));

    if (gameItem.customisationSource != null &&
        gameItem.customisationSource != CustomisationSourceType.unknown) {
      widgets.add(emptySpace1x());
      widgets.add(customDivider());
      widgets.add(genericItemDescription(
        getTranslations().fromKey(LocaleKey.foundIn),
      ));
      var image = AppImage.outfitCommon;
      switch (gameItem.customisationSource) {
        case CustomisationSourceType.common:
          image = AppImage.outfitCommon;
          break;
        case CustomisationSourceType.rare:
          image = AppImage.outfitRare;
          break;
        case CustomisationSourceType.epic:
          image = AppImage.outfitEpic;
          break;
        default:
          image = AppImage.outfitCommon;
          break;
      }
      widgets.add(genericItemImage(
        context,
        image,
        height: 50,
        disableZoom: true,
      ));
    }

    widgets.add(emptySpace10x());

    var fabColour = getTheme().getSecondaryColour(context);
    var fabWidget = isOwned
        ? FloatingActionButton(
            child: Icon(Icons.cancel),
            backgroundColor: fabColour,
            foregroundColor: getTheme().getForegroundTextColour(fabColour),
            onPressed: () => viewModel.removeFromOwned(gameItem.id),
          )
        : FloatingActionButton(
            child: Icon(Icons.check),
            backgroundColor: fabColour,
            foregroundColor: getTheme().getForegroundTextColour(fabColour),
            onPressed: () => viewModel.addToOwned(gameItem.id),
          );
    return Stack(
      key: Key("${viewModel.owned}-$isOwned"),
      children: [
        listWithScrollbar(
          padding: AppPadding.listSidePadding,
          itemCount: widgets.length,
          itemBuilder: (context, index) => widgets[index],
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: fabWidget,
        )
      ],
    );
  }
}
