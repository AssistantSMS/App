import 'package:breakpoint/breakpoint.dart';

int getCustomColumnCount(Breakpoint breakpoint) {
  if (breakpoint.window == WindowSize.xsmall) return 4;
  if (breakpoint.window == WindowSize.small) return 6;
  if (breakpoint.window == WindowSize.medium) return 8;
  if (breakpoint.window == WindowSize.large) return 8;
  if (breakpoint.window == WindowSize.xlarge) return 8;

  return 4;
}
