import 'package:breakpoint/breakpoint.dart';
import 'package:scrapmechanic_kurtlourens_com/contracts/misc/responsiveFlexData.dart';

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
