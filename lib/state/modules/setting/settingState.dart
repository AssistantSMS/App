import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:meta/meta.dart';

@immutable
class SettingState {
  final String selectedLanguage;
  final bool isPatron;

  const SettingState({
    required this.selectedLanguage,
    required this.isPatron,
  });

  factory SettingState.initial() {
    return const SettingState(
      selectedLanguage: 'en',
      isPatron: false,
    );
  }

  SettingState copyWith({
    String? selectedLanguage,
    bool? isPatron,
  }) {
    return SettingState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      isPatron: isPatron ?? this.isPatron,
    );
  }

  factory SettingState.fromJson(Map<String, dynamic>? json) {
    if (json == null) return SettingState.initial();
    try {
      return SettingState(
        selectedLanguage: readStringSafe(json, 'selectedLanguage'),
        isPatron: readBoolSafe(json, 'isPatron'),
      );
    } catch (exception) {
      return SettingState.initial();
    }
  }

  Map<String, dynamic> toJson() => {
        'selectedLanguage': selectedLanguage,
        'isPatron': isPatron,
      };
}
