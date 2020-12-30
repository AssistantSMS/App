import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pagination_view/pagination_view.dart';

import '../contracts/results/paginationResultWithValue.dart';
import 'loading.dart';

class LazyLoadSearchableList<T> extends StatefulWidget {
  final Future<PaginationResultWithValue<List<T>>> Function(int page)
      listGetter;
  final Future<PaginationResultWithValue<List<T>>> Function(int page)
      backupListGetter;
  final int pageSize;
  final Widget Function(BuildContext context, T) listItemDisplayer;
  final String customKey;
  final String hintText;
  final String loadingText;
  final bool addFabPadding;
  final Widget loadMoreItemWidget;

  LazyLoadSearchableList(
    this.listGetter,
    this.pageSize,
    this.listItemDisplayer, {
    this.customKey,
    this.backupListGetter,
    this.hintText,
    this.loadingText,
    this.addFabPadding = false,
    this.loadMoreItemWidget,
  });
  @override
  _LazyLoadSearchableListWidget<T> createState() =>
      _LazyLoadSearchableListWidget<T>(
        listGetter,
        backupListGetter,
        pageSize,
        listItemDisplayer,
        customKey,
        hintText,
        loadingText,
        addFabPadding,
      );
}

class _LazyLoadSearchableListWidget<T>
    extends State<LazyLoadSearchableList<T>> {
  var _scrollController = ScrollController();
  final Future<PaginationResultWithValue<List<T>>> Function(int page)
      listGetter;
  final Future<PaginationResultWithValue<List<T>>> Function(int page)
      backupListGetter;
  List<int> fetchedPages = List<int>();
  int totalPages = 1;
  final int pageSize;
  final Widget Function(BuildContext context, T) listItemDisplayer;
  final String key;
  final String hintText;
  final String loadingText;
  final bool addFabPadding;
  // bool usingBackupGetter = false;

  _LazyLoadSearchableListWidget(
    this.listGetter,
    this.backupListGetter,
    this.pageSize,
    this.listItemDisplayer,
    this.key,
    this.hintText,
    this.loadingText,
    this.addFabPadding,
  );

  Future<List<T>> getMoreData(int page) async {
    var pageToGet = (page ~/ this.pageSize) + 1;
    if (pageToGet < 1 || pageToGet > totalPages) return [];
    if (fetchedPages.contains(pageToGet)) return [];

    final temp = await listGetter(pageToGet);
    if (temp.isSuccess) {
      this.setState(() {
        fetchedPages.add(temp.currentPage);
        totalPages = temp.totalPages;
      });
      return temp.value;
    }

    final tempBackup = await backupListGetter(pageToGet);
    if (tempBackup.isSuccess) {
      this.setState(() {
        fetchedPages.add(tempBackup.currentPage);
        totalPages = tempBackup.totalPages;
        // usingBackupGetter = true;
      });
      return tempBackup.value;
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return PaginationView<T>(
      itemBuilder: (BuildContext innerCtxt, T user, int index) =>
          listItemDisplayer(innerCtxt, user),
      paginationViewType: PaginationViewType.listView,
      pageFetch: getMoreData,
      onError: (dynamic error) => Center(
        child: Text('Some error occured'),
      ),
      onEmpty: Center(
        child: Text('Sorry! This is empty'),
      ),
      bottomLoader: Center(
        child: smallLoadingTile(context),
      ),
      initialLoader: fullPageLoading(context),
      scrollController: _scrollController,
      key: Key('lazyLoaded'),
    );
  }
}
