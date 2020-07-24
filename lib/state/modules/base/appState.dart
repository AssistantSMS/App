import 'package:meta/meta.dart';

import '../cart/cartState.dart';
import '../cosmetic/cosmeticState.dart';
import '../raid/raidState.dart';
import '../setting/settingState.dart';

@immutable
class AppState {
  final SettingState settingState;
  final CartState cartState;
  final RaidState raidState;
  final CosmeticState cosmeticState;

  AppState({
    this.settingState,
    this.cartState,
    this.raidState,
    this.cosmeticState,
  });

  factory AppState.initial() {
    return AppState(
      settingState: SettingState.initial(),
      cartState: CartState.initial(),
      raidState: RaidState.initial(),
      cosmeticState: CosmeticState.initial(),
    );
  }

  AppState.fromJson(Map<String, dynamic> json)
      : cartState = CartState.fromJson(json['cartState']),
        raidState = RaidState.fromJson(json['raidState']),
        cosmeticState = CosmeticState.fromJson(json['cosmeticState']),
        settingState = SettingState.fromJson(json['settingState']);

  Map<String, dynamic> toJson() => {
        'cartState': cartState.toJson(),
        'raidState': raidState.toJson(),
        'cosmeticState': cosmeticState.toJson(),
        'settingState': settingState.toJson(),
      };
}
