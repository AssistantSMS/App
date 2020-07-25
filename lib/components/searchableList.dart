import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../contracts/results/resultWithValue.dart';
import '../helpers/genericHelper.dart';
import '../integration/logging.dart';
import '../localization/localeKey.dart';
import '../localization/translations.dart';
import 'adaptive/gridWithScrollbar.dart';
import 'adaptive/listWithScrollbar.dart';
import 'adaptive/searchBar.dart';
import 'loading.dart';

class SearchableList<T> extends StatefulWidget {
  final Future<ResultWithValue<List<T>>> Function() listGetter;
  final Future<ResultWithValue<List<T>>> Function() backupListGetter;
  final Widget firstListItemWidget;
  final LocaleKey backupListWarningMessage;
  final Widget Function(BuildContext context, T, int index) listItemDisplayer;
  final bool Function(T, String) listItemSearch;
  final void Function() deleteAll;
  final int minListForSearch;
  final Key key;
  final String hintText;
  final String loadingText;
  final bool addFabPadding;
  final bool useGridView;
  final int Function(Breakpoint) gridViewColumnCalculator;

  SearchableList(
    this.listGetter,
    this.listItemDisplayer,
    this.listItemSearch, {
    this.key,
    this.firstListItemWidget,
    this.hintText,
    this.loadingText,
    this.deleteAll,
    this.minListForSearch = 10,
    this.addFabPadding = false,
    this.useGridView = false,
    this.gridViewColumnCalculator,
    this.backupListGetter,
    this.backupListWarningMessage,
  });
  @override
  SearchableListWidget<T> createState() => SearchableListWidget<T>(
        listGetter(),
        listItemDisplayer,
        listItemSearch,
        key,
        hintText,
        loadingText,
        deleteAll,
        minListForSearch,
        addFabPadding,
      );
}

class SearchableListWidget<T> extends State<SearchableList<T>> {
  TextEditingController controller = TextEditingController();
  Future<ResultWithValue<List<T>>> listGetter;
  final Widget Function(BuildContext context, T, int index) listItemDisplayer;
  final bool Function(T, String) listItemSearch;
  final void Function() deleteAll;
  List<T> _searchResult = [];
  List<T> _listResults = [];
  int minListForSearch;
  Key key;
  bool hasLoaded = false;
  bool usingBackupGetter = false;
  String hintText;
  String loadingText;
  final bool addFabPadding;

  SearchableListWidget(
    this.listGetter,
    this.listItemDisplayer,
    this.listItemSearch,
    this.key,
    this.hintText,
    this.loadingText,
    this.deleteAll,
    this.minListForSearch,
    this.addFabPadding,
  ) {
    logger.d("SearchableListWidget ctor");
  }

  @override
  void initState() {
    super.initState();

    getList();
  }

  Future<Null> getList() async {
    final temp = await listGetter;
    if (temp.isSuccess) {
      listSuccessFunc(temp);
      return;
    }

    if (widget.backupListGetter == null) {
      listErrorFunc();
      return;
    }

    final backupTemp = await widget.backupListGetter();
    if (!backupTemp.isSuccess) {
      listErrorFunc();
      return;
    }
    listSuccessFunc(backupTemp, usingBackupGetter: true);
  }

  listSuccessFunc(ResultWithValue<List<T>> temp,
      {bool usingBackupGetter = false}) {
    List<T> tempResults = [];
    for (T item in temp.value) {
      tempResults.add(item);
    }

    setState(() {
      hasLoaded = true;
      this.usingBackupGetter = usingBackupGetter;
      _listResults = tempResults;
    });
  }

  listErrorFunc() {
    setState(() {
      hasLoaded = true;
      _listResults = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!hasLoaded)
      return fullPageLoading(context,
          loadingText:
              loadingText ?? Translations.get(context, LocaleKey.loading));

    List<Widget> columnWidgets = List<Widget>();
    if (_listResults.length > minListForSearch) {
      columnWidgets.add(
        searchBar(context, controller, hintText, onSearchTextChanged),
      );
    }

    if (this.usingBackupGetter && widget.backupListWarningMessage != null) {
      columnWidgets.add(
        Container(
          color: Colors.red,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(top: 4, bottom: 4),
            child: Text(
              Translations.get(context, widget.backupListWarningMessage),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );
    }

    if (_searchResult.length == 0 && controller.text.isNotEmpty ||
        _listResults.length == 0 && controller.text.isEmpty) {
      List<Widget> noItemsList = List<Widget>();
      if (widget.firstListItemWidget != null) {
        noItemsList.add(widget.firstListItemWidget);
      }
      noItemsList.add(
        Container(
          child: Text(
            Translations.get(context, LocaleKey.noItems),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 20),
          ),
          margin: EdgeInsets.only(top: 30),
        ),
      );
      columnWidgets.add(
        Expanded(
          child: listWithScrollbar(
            itemCount: noItemsList.length,
            itemBuilder: (context, index) {
              return noItemsList[index];
            },
          ),
        ),
      );
    } else {
      List<T> list = (_searchResult.length != 0 || controller.text.isNotEmpty)
          ? _searchResult
          : _listResults;

      List<Widget> additionalWidgets = List<Widget>();
      if (deleteAll != null) {
        additionalWidgets.add(deleteAllButton(context));
      }
      if (addFabPadding) {
        additionalWidgets.add(emptySpace10x());
      }

      int listLength = list.length + additionalWidgets.length;
      if (widget.firstListItemWidget != null) listLength++;

      if (widget.useGridView) {
        columnWidgets.add(
          Expanded(
            child: gridWithScrollbar(
              itemCount: listLength,
              itemBuilder: (context, index) {
                if (index >= list.length) {
                  return additionalWidgets[listLength - index - 1];
                }
                return listItemDisplayer(context, list[index], index);
              },
              gridViewColumnCalculator: widget.gridViewColumnCalculator,
            ),
          ),
        );
      } else {
        columnWidgets.add(
          Expanded(
            child: listWithScrollbar(
              itemCount: listLength,
              itemBuilder: (context, index) {
                if (widget.firstListItemWidget != null) {
                  if (index == 0) return widget.firstListItemWidget;
                  index = index - 1;
                }
                if (index >= list.length) {
                  int modifier = (widget.firstListItemWidget != null) ? 2 : 1;
                  return additionalWidgets[listLength - index - modifier];
                }
                return listItemDisplayer(context, list[index], index);
              },
            ),
          ),
        );
      }
    }

    return Column(
      key: Key('usingBackupGetter ' + usingBackupGetter.toString()),
      children: columnWidgets,
    );
  }

  Widget deleteAllButton(context) {
    return Container(
      child: MaterialButton(
        child: Text(Translations.get(context, LocaleKey.deleteAll)),
        color: Colors.red,
        onPressed: () => deleteAll(),
      ),
      margin: EdgeInsets.all(4),
    );
  }

  onSearchTextChanged(String searchText) async {
    _searchResult.clear();
    if (searchText.isEmpty) {
      setState(() {});
      return;
    }

    _listResults.forEach((item) {
      if (listItemSearch(item, searchText.toLowerCase())) {
        _searchResult.add(item);
      }
    });

    setState(() {});
  }
}
