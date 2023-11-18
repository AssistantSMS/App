import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scrapmechanic_kurtlourens_com/contracts/gameItem/gameItem.dart';

import '../../components/common/positioned.dart';
import '../../components/scaffoldTemplates/genericPageScaffold.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../constants/AppImage.dart';
import '../../constants/AppPadding.dart';
import '../../contracts/enum/customisationSourceType.dart';
import '../../contracts/gameItem/gameItemPageItem.dart';
import '../../helpers/futureHelper.dart';
import '../../helpers/genericHelper.dart';
import '../../mapper/gameItemMapper.dart';
import '../../state/modules/base/appState.dart';
import '../../state/modules/cosmetic/cosmeticViewModel.dart';

class DressBotDetailPage extends StatelessWidget {
  final String itemId;
  final bool isInDetailPane;
  final void Function(Widget newDetailView)? updateDetailView;

  DressBotDetailPage(
    this.itemId, {
    Key? key,
    this.isInDetailPane = false,
    this.updateDetailView,
  }) : super(key: key) {
    getAnalytics().trackEvent('${AnalyticsEvent.itemDetailPage}: $itemId');
  }

  @override
  Widget build(BuildContext context) {
    String loading = getTranslations().fromKey(LocaleKey.loading);
    var loadingWidget = getLoading().fullPageLoading(
      context,
      loadingText: loading,
    );
    return CachedFutureBuilder<ResultWithValue<GameItemPageItem>>(
      future: gameItemPageItemFuture(context, itemId),
      whileLoading: () => isInDetailPane
          ? loadingWidget
          : genericPageScaffold(
              context,
              loading,
              null,
              body: (_, __) => loadingWidget,
              showShortcutLinks: true,
            ),
      whenDoneLoading: (ResultWithValue<GameItemPageItem> result) {
        var bodyWidget = StoreConnector<AppState, CosmeticViewModel>(
          converter: (store) => CosmeticViewModel.fromStore(store),
          builder: (_, viewModel) => getBody(context, viewModel, result),
        );
        if (isInDetailPane) return bodyWidget;
        return getBaseWidget().appScaffold(
          context,
          appBar: getBaseWidget().appBarForSubPage(
            context,
            title: Text(result.value.gameItem.title),
            actions: [
              ActionItem(
                icon: Icons.home,
                onPressed: () async =>
                    await getNavigation().navigateHomeAsync(context),
              )
            ],
          ),
          body: bodyWidget,
        );
      },
    );
  }

  Widget getBody(
    BuildContext context,
    CosmeticViewModel viewModel,
    ResultWithValue<GameItemPageItem> result,
  ) {
    GameItem gameItem = result.value.gameItem;
    List<Widget> widgets = List.empty(growable: true);

    if (gameItem.icon != null) {
      widgets.add(genericItemImage(
        context,
        '${AppImage.base}${gameItem.icon}',
        name: gameItem.title,
      ));
    }
    widgets.add(const EmptySpace1x());
    widgets.add(GenericItemName(gameItem.title));

    var isOwned = ((viewModel.owned).any((own) => own == gameItem.id));
    widgets.add(const EmptySpace1x());
    widgets.add(GenericItemDescription(
      getTranslations().fromKey(isOwned ? LocaleKey.owned : LocaleKey.notOwned),
      textStyle: TextStyle(
        color: getTheme().getSecondaryColour(context),
      ),
    ));

    if (gameItem.customisationSource != CustomisationSourceType.unknown) {
      widgets.add(const EmptySpace1x());
      widgets.add(customDivider());
      widgets.add(GenericItemDescription(
        getTranslations().fromKey(LocaleKey.foundIn),
      ));

      String dressBotPckgImg = getDressBotImage(gameItem.customisationSource);
      if (dressBotPckgImg.isNotEmpty) {
        widgets.add(genericItemImage(
          context,
          dressBotPckgImg,
          height: 50,
          disableZoom: true,
        ));
      }
    }

    widgets.add(const EmptySpace10x());

    Color fabColour = getTheme().getSecondaryColour(context);
    FloatingActionButton fabWidget = isOwned
        ? FloatingActionButton(
            child: const Icon(Icons.cancel),
            backgroundColor: fabColour,
            foregroundColor: getTheme().getForegroundTextColour(fabColour),
            onPressed: () => viewModel.removeFromOwned(gameItem.id),
          )
        : FloatingActionButton(
            child: const Icon(Icons.check),
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
        fabPositioned(fabWidget)
      ],
    );
  }
}
