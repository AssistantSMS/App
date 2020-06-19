import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/components/adaptive/gridWithScrollbar.dart';

import '../contracts/results/resultWithValue.dart';
import '../integration/logging.dart';
import '../helpers/genericHelper.dart';
import '../localization/localeKey.dart';
import '../localization/translations.dart';
import 'adaptive/listWithScrollbar.dart';
import 'adaptive/searchBar.dart';
import 'loading.dart';

class SearchableList<T> extends StatefulWidget {
  final Future<ResultWithValue<List<T>>> Function() listGetter;
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
    this.hintText,
    this.loadingText,
    this.deleteAll,
    this.minListForSearch = 10,
    this.addFabPadding = false,
    this.useGridView = false,
    this.gridViewColumnCalculator,
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
    //await new Future.delayed(const Duration(seconds: 3));
    if (temp.isSuccess) {
      List<T> tempResults = [];
      for (T item in temp.value) {
        tempResults.add(item);
      }
      setState(() {
        hasLoaded = true;
        _listResults = tempResults;
      });
    } else {
      setState(() {
        hasLoaded = true;
        _listResults = [];
      });
    }
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

    if (_searchResult.length == 0 && controller.text.isNotEmpty ||
        _listResults.length == 0 && controller.text.isEmpty) {
      columnWidgets.add(
        Expanded(
          child: listWithScrollbar(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Container(
                child: Text(
                  Translations.get(context, LocaleKey.noItems),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20),
                ),
                margin: EdgeInsets.only(top: 30),
              );
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
                if (index >= list.length) {
                  return additionalWidgets[listLength - index - 1];
                }
                return listItemDisplayer(context, list[index], index);
              },
            ),
          ),
        );
      }
    }

    return Column(key: key, children: columnWidgets);
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
