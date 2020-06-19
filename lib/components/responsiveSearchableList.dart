import 'package:flutter/material.dart';
import 'package:breakpoint/breakpoint.dart';

import '../contracts/misc/responsiveFlexData.dart';
import '../contracts/results/resultWithValue.dart';
import '../helpers/colourHelper.dart';
import '../helpers/columnHelper.dart';
import 'searchableList.dart';

class ResponsiveListDetailView<T> extends StatefulWidget {
  final Future<ResultWithValue<List<T>>> Function() listGetter;
  final Widget Function(BuildContext context, T, int index) listItemDisplayer;
  final void Function(BuildContext context, T) listItemMobileOnTap;
  final Widget Function(BuildContext context, T) listItemDesktopOnTap;
  final bool Function(T, String) listItemSearch;
  final void Function() deleteAll;
  final int minListForSearch;
  final Key key;
  final String hintText;
  final String loadingText;
  final bool addFabPadding;

  const ResponsiveListDetailView(
    this.listGetter,
    this.listItemDisplayer,
    this.listItemSearch, {
    this.key,
    this.listItemMobileOnTap,
    this.listItemDesktopOnTap,
    this.hintText,
    this.loadingText,
    this.deleteAll,
    this.minListForSearch = 10,
    this.addFabPadding = false,
  }) : super(key: key);

  @override
  _ResponsiveListDetailWidget<T> createState() =>
      _ResponsiveListDetailWidget<T>();
}

class _ResponsiveListDetailWidget<T>
    extends State<ResponsiveListDetailView<T>> {
  Key detailViewKey = Key('Initial');
  Widget detailView = Center(child: Text('test'));
  _ResponsiveListDetailWidget();

  @override
  Widget build(BuildContext context) {
    return BreakpointBuilder(
      builder: (BuildContext innerContext, Breakpoint breakpoint) {
        ResponsiveFlexData flexData =
            getCustomListWithDetailsFlexWidth(breakpoint);
        void Function(BuildContext, T) onTapFunc = getItemClickFunc(flexData);
        SearchableList<T> listView = SearchableList<T>(
          widget.listGetter,
          (BuildContext innerC, T item, int index) => GestureDetector(
            child: widget.listItemDisplayer(innerC, item, index),
            onTap: () => onTapFunc(innerC, item),
          ),
          widget.listItemSearch,
          key: widget.key,
          hintText: widget.hintText,
          loadingText: widget.loadingText,
          deleteAll: widget.deleteAll,
          minListForSearch: widget.minListForSearch,
          addFabPadding: widget.addFabPadding,
        );
        if (flexData.isMobile) return listView;

        return Flex(
          direction: Axis.horizontal,
          children: [
            Flexible(
              flex: flexData.flex1,
              child: listView,
            ),
            Flexible(
              key: detailViewKey,
              flex: flexData.flex2,
              child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                          color: getSecondaryColour(context), width: 4),
                    ),
                  ),
                  child: detailView),
            ),
          ],
        );
      },
    );
  }

  void Function(BuildContext, T) getItemClickFunc(ResponsiveFlexData flexData) {
    var desktopClick = (BuildContext innerInnerC, T itemTapped) {
      this.setState(() {
        detailViewKey = Key(DateTime.now().millisecondsSinceEpoch.toString());
        detailView = widget.listItemDesktopOnTap(innerInnerC, itemTapped);
      });
    };
    return flexData.isMobile ? widget.listItemMobileOnTap : desktopClick;
  }
}
