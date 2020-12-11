import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// import '../../helpers/deviceHelper.dart';

void adaptiveBottomModalSheet(
  BuildContext context, {
  @required Widget Function(BuildContext) builder,
  bool hasRoundedCorners = false,
}) {
  _androidBottomModalSheet(context, builder, hasRoundedCorners);
  // if (isiOS) {
  //   _appleBottomModalSheet(context, builder);
  // } else {
  //   _androidBottomModalSheet(context, builder);
  // }
}

void _androidBottomModalSheet(BuildContext context,
    Widget Function(BuildContext) builder, bool hasRoundedCorners) {
  showMaterialModalBottomSheet(
    context: context,
    bounce: true,
    expand: false,
    builder: (innerContext) => builder(innerContext),
    shape: hasRoundedCorners
        ? RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          )
        : null,
  );
}

// void _appleBottomModalSheet(
//     BuildContext context, Widget Function(BuildContext) builder) {
//   showCupertinoModalBottomSheet(
//     context: context,
//     bounce: true,
//     expand: false,
//     builder: (innerContext) => builder(innerContext),
//   );
// }
