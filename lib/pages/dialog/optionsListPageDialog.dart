import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../components/adaptive/appBarForSubPage.dart';
import '../../components/adaptive/appScaffold.dart';
import '../../components/dialogs/asyncInputDialog.dart';
import '../../components/tilePresenters/optionTilePresenter.dart';
import '../../contracts/search/dropdownOption.dart';
import '../../helpers/fabHelper.dart';
import '../../helpers/searchListHelper.dart';

class OptionsListPageDialog extends StatefulWidget {
  final String title;
  final int minListForSearch;
  final List<DropdownOption> options;
  final Widget Function(BuildContext, DropdownOption, int) customPresenter;
  final void Function(DropdownOption) addOption;
  final void Function(DropdownOption) onDelete;

  OptionsListPageDialog(
    this.title,
    this.options, {
    this.minListForSearch = 10,
    this.customPresenter,
    this.addOption,
    this.onDelete,
  });

  @override
  _OptionsListPageDialogWidget createState() => _OptionsListPageDialogWidget(
        this.title,
        this.options,
        this.minListForSearch,
        addOption,
        onDelete,
        customPresenter: this.customPresenter,
      );
}

class _OptionsListPageDialogWidget extends State<OptionsListPageDialog> {
  String title;
  String output;
  List<DropdownOption> options;
  int minListForSearch;
  final Widget Function(BuildContext, DropdownOption, int) customPresenter;
  final void Function(DropdownOption) addOption;
  final void Function(DropdownOption) onDelete;

  _OptionsListPageDialogWidget(this.title, this.options, this.minListForSearch,
      this.addOption, this.onDelete,
      {this.customPresenter});

  @override
  Widget build(BuildContext context) {
    Widget floatingActionButtonWidget;

    if (addOption != null) {
      floatingActionButtonWidget = FloatingActionButton(
        onPressed: () async {
          var temp = await asyncInputDialog(
              context, getTranslations().fromKey(LocaleKey.addTag));
          if (temp == '' ||
              temp == ' ' ||
              this.options.any((opt) => opt.value == temp)) {
            return;
          }
          var option = DropdownOption(temp);
          addOption(option);
          setState(() {
            this.options.add(option);
          });
        },
        heroTag: 'OptionsListPageDialog',
        child: Icon(Icons.add),
        foregroundColor: fabForegroundColourSelector(),
        backgroundColor: fabColourSelector(context),
      );
    }

    var presenter = customPresenter ??
        (BuildContext innerC, DropdownOption option, int index) =>
            optionTilePresenter(innerC, option,
                onDelete: (this.onDelete != null)
                    ? () {
                        this.onDelete(option);
                        this.setState(() {
                          this.options.remove(option);
                        });
                      }
                    : null);

    return appScaffold(
      context,
      appBar: appBarForSubPageHelper(
        context,
        title: Text(title),
      ),
      body: SearchableList<DropdownOption>(
        getSearchListFutureFromList(this.options),
        listItemWithIndexDisplayer: presenter,
        listItemSearch: (DropdownOption option, String search) =>
            option.title.toLowerCase().contains(search),
        minListForSearch: minListForSearch,
        key: Key('num Items: ${this.options.length.toString()}'),
      ),
      floatingActionButton: floatingActionButtonWidget,
    );
  }
}
