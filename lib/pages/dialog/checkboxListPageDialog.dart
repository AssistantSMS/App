import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/search/checkboxOption.dart';

class CheckboxListPageDialog extends StatefulWidget {
  final String title;
  final List<CheckboxOption> options;

  const CheckboxListPageDialog(
    this.title,
    this.options, {
    Key? key,
  }) : super(key: key);

  @override
  createState() => _CheckboxListPageDialogWidget();
}

class _CheckboxListPageDialogWidget extends State<CheckboxListPageDialog> {
  List<CheckboxOption> options = [];

  @override
  initState() {
    super.initState();
    options = widget.options;
  }

  @override
  Widget build(BuildContext context) {
    Color fabColour = getTheme().getSecondaryColour(context);
    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        title: Text(widget.title),
      ),
      body: SearchableList<CheckboxOption>(
        getSearchListFutureFromList(options),
        listItemWithIndexDisplayer: (
          BuildContext context,
          CheckboxOption menuItem,
          int index, {
          void Function()? onTap,
        }) {
          return ListTile(
            title: Text(menuItem.title),
            trailing: AdaptiveCheckbox(
              value: menuItem.value,
              activeColor: getTheme().getSecondaryColour(context),
              onChanged: (bool newValue) {
                setState(() {
                  options[index].value = newValue;
                });
              },
            ),
            onTap: () {
              setState(() {
                options[index].value = !options[index].value;
              });
            },
          );
        },
        listItemSearch: (_, __) => false,
        addFabPadding: true,
        minListForSearch: 10000,
        key: Key('num Items: ${options.length.toString()}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getNavigation().pop(context, options),
        heroTag: 'CheckboxListPageDialog',
        child: const Icon(Icons.check),
        backgroundColor: getTheme().getSecondaryColour(context),
        foregroundColor: getTheme().getForegroundTextColour(fabColour),
      ),
    );
  }
}
