import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/AppAnimation.dart';
import '../../constants/Modal.dart';
import '../../contracts/devDetail.dart';

class DevDetailBottomSheet extends StatefulWidget {
  final List<DevDetail> details;
  const DevDetailBottomSheet(
    this.details, {
    Key? key,
  }) : super(key: key);

  @override
  createState() => _DevDetailBottomSheetWidget();
}

class _DevDetailBottomSheetWidget extends State<DevDetailBottomSheet> {
  //
  @override
  Widget build(BuildContext context) {
    Widget Function(String) titleFunc;
    titleFunc = (String text) => GenericItemDescription(
          text,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        );
    Widget Function(String) bodyFunc;
    bodyFunc = (String text) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GenericItemDescription(
              text,
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
            ),
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: text));
              },
            )
          ],
        );

    List<Widget Function()> widgets = [
      () => const EmptySpace2x(),
    ];

    for (DevDetail prop in widget.details) {
      if (prop.value.isEmpty) continue;
      widgets.add(() => titleFunc(prop.name));
      widgets.add(() => bodyFunc(prop.value));
      // widgets.addAll([
      //   () => titleFunc(prop.name),
      //   () => bodyFunc(prop.value),
      // ]);
      widgets.add(() => customDivider());
    }
    widgets.add(() => const EmptySpace8x());

    return AnimatedSize(
      duration: AppAnimation.modal,
      child: Container(
        constraints: modalDefaultSize(context),
        child: ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: widgets.length,
          itemBuilder: (_, int index) => widgets[index](),
          shrinkWrap: true,
        ),
      ),
    );
  }
}
