import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:meta/meta.dart';

@immutable
class SettingState {
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

  SettingState.fromJson(Map<String, dynamic> json)
      : selectedLanguage = readStringSafe(json, 'selectedLanguage');

  Map<String, dynamic> toJson() => {
        'selectedLanguage': selectedLanguage,
      };
}
