import 'package:meta/meta.dart';

import '../cart/cartState.dart';
import '../raid/raidState.dart';
import '../setting/settingState.dart';

@immutable
class AppState {
  final SettingState settingState;
  final CartState cartState;
  final RaidState raidState;

  AppState({
    this.settingState,
    this.cartState,
    this.raidState,
  });

  factory AppState.initial() {
    return AppState(
      settingState: SettingState.initial(),
      cartState: CartState.initial(),
      raidState: RaidState.initial(),
    );
  }

  AppState.fromJson(Map<String, dynamic> json)
      : cartState = CartState.fromJson(json['cartState']),
        raidState = RaidState.fromJson(json['raidState']),
        settingState = SettingState.fromJson(json['settingState']);

  Map<String, dynamic> toJson() => {
        'cartState': cartState.toJson(),
        'raidState': raidState.toJson(),
        'settingState': settingState.toJson(),
      };
}
