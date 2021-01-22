import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../components/adaptive/appBarForSubPage.dart';
import '../../components/adaptive/appScaffold.dart';
import '../../components/adaptive/checkbox.dart';
import '../../contracts/search/checkboxOption.dart';
import '../../helpers/fabHelper.dart';
import '../../helpers/searchListHelper.dart';

class CheckboxListPageDialog extends StatefulWidget {
  final String title;
  final List<CheckboxOption> options;

  CheckboxListPageDialog(this.title, this.options);

  @override
  _CheckboxListPageDialogWidget createState() => _CheckboxListPageDialogWidget(
        this.title,
        this.options,
      );
}

class _CheckboxListPageDialogWidget extends State<CheckboxListPageDialog> {
  String title;
  String output;
  List<CheckboxOption> options;

  _CheckboxListPageDialogWidget(this.title, this.options);

  @override
  Widget build(BuildContext context) {
    return appScaffold(context,
        appBar: appBarForSubPageHelper(
          context,
          title: Text(title),
        ),
        body: SearchableList<CheckboxOption>(
          getSearchListFutureFromList(this.options),
          listItemWithIndexDisplayer:
              (BuildContext context, CheckboxOption menuItem, int index) {
            return ListTile(
              title: Text(menuItem.title),
              trailing: adaptiveCheckbox(
                context,
                value: menuItem.value,
                activeColor: getTheme().getSecondaryColour(context),
                onChanged: (bool newValue) {
                  this.setState(() {
                    this.options[index].value = newValue;
                  });
                },
              ),
              onTap: () {
                this.setState(() {
                  this.options[index].value = !this.options[index].value;
                });
              },
            );
          },
          listItemSearch: (_, __) => false,
          addFabPadding: true,
          minListForSearch: 10000,
          key: Key('num Items: ${this.options.length.toString()}'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pop(options),
          heroTag: 'CheckboxListPageDialog',
          child: Icon(Icons.check),
          foregroundColor: fabForegroundColourSelector(),
          backgroundColor: fabColourSelector(context),
        ));
  }
}
