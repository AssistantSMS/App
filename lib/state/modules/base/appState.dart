import 'package:meta/meta.dart';

import '../cart/cartState.dart';
import '../setting/settingState.dart';

@immutable
class AppState {
  final SettingState settingState;
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

  AppState.fromJson(Map<String, dynamic> json)
      : cartState = CartState.fromJson(json['cartState']),
        settingState = SettingState.fromJson(json['settingState']);

  Map<String, dynamic> toJson() => {
        'cartState': cartState.toJson(),
        'settingState': settingState.toJson(),
      };
}
