import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

class MousePointer extends MouseRegion {
  MousePointer({@required Widget child})
      : super(
          child: child,
          onHover: _mouseOnHover,
          onExit: _mouseOnExit,
        );

  static String cursorDefaultSrc = "default";
  static String cursorLinkSrc = "pointer";

  static dynamic getClickableArea() {
    var tagList = html.window.document.getElementsByTagName('flt-glass-pane');
    if (tagList.length < 1) return null;
    return tagList[0];
  }

  static void _mouseOnHover(PointerHoverEvent event) {
    var clickableArea = getClickableArea();
    if (clickableArea == null) return;
    clickableArea.style.cursor = MousePointer.cursorLinkSrc;
  }

  static void _mouseOnExit(PointerExitEvent event) {
    var clickableArea = getClickableArea();
    if (clickableArea == null) return;
    clickableArea.style.cursor = MousePointer.cursorDefaultSrc;
  }
}

extension MousePointerExtension on Widget {
  Widget get showPointerOnHover {
    if (!isWeb) return this;

    var clickableArea = MousePointer.getClickableArea();
    if (clickableArea == null) return this;

    return MouseRegion(
      child: this,
      onHover: (event) {
        clickableArea.style.cursor = MousePointer.cursorLinkSrc;
      },
      onExit: (event) {
        clickableArea.style.cursor = MousePointer.cursorDefaultSrc;
      },
    );
  }
}
