import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../constants/HiveTypeConstant.dart';
import '../setting/settingState.dart';

part 'appState.g.dart';

@immutable
@HiveType(typeId: HiveTypeConstant.appState)
class AppState {
  @HiveField(0)
  final SettingState settingState;

  AppState({
    this.settingState,
  });

  factory AppState.initial() {
    return AppState(
      settingState: SettingState.initial(),
    );
  }
}
