import 'package:breakpoint/breakpoint.dart';

import '../contracts/misc/responsiveFlexData.dart';

int getCustomColumnCount(Breakpoint breakpoint) {
  if (breakpoint.window == WindowSize.xsmall) return 4;
  if (breakpoint.window == WindowSize.small) return 6;
  if (breakpoint.window == WindowSize.medium) return 8;
  if (breakpoint.window == WindowSize.large) return 8;
  if (breakpoint.window == WindowSize.xlarge) return 8;

  return 4;
}

ResponsiveFlexData getCustomListWithDetailsFlexWidth(Breakpoint breakpoint) {
  if (breakpoint.window == WindowSize.xsmall)
    return ResponsiveFlexData(1, 0, true);
  if (breakpoint.window == WindowSize.small)
    return ResponsiveFlexData(1, 0, true);
  if (breakpoint.window == WindowSize.medium)
    return ResponsiveFlexData(1, 1, false);
  if (breakpoint.window == WindowSize.large)
    return ResponsiveFlexData(1, 1, false);
  if (breakpoint.window == WindowSize.xlarge)
    return ResponsiveFlexData(4, 6, false);

  return ResponsiveFlexData(1, 0, true);
}

int steamNewsCustomColumnCount(Breakpoint breakpoint) {
  if (breakpoint.window == WindowSize.xsmall) return 1;
  if (breakpoint.window == WindowSize.small) return 2;
  if (breakpoint.window == WindowSize.medium) return 3;
  if (breakpoint.window == WindowSize.large) return 4;
  if (breakpoint.window == WindowSize.xlarge) return 5;

  return 4;
}
