import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../constants/HiveTypeConstant.dart';
import '../cart/cartState.dart';
import '../setting/settingState.dart';

part 'appState.g.dart';

@immutable
@HiveType(typeId: HiveTypeConstant.appState)
class AppState {
  @HiveField(0)
  final SettingState settingState;
  @HiveField(1)
  final CartState cartState;

  AppState({
    this.settingState,
    this.cartState,
  });

  factory AppState.initial() {
    return AppState(
      settingState: SettingState.initial(),
      cartState: CartState.initial(),
    );
  }
}
