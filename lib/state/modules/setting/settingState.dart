import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../constants/HiveTypeConstant.dart';

part 'settingState.g.dart';

@immutable
@HiveType(typeId: HiveTypeConstant.settingState)
class SettingState {
  @HiveField(0)
  final String selectedLanguage;

  SettingState({
    this.selectedLanguage,
  });

  factory SettingState.initial() {
    return SettingState(
      selectedLanguage: null,
    );
  }

  SettingState copyWith({
    String selectedLanguage,
  }) {
    return SettingState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }
}
