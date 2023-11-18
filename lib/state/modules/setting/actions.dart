import '../base/persistToStorage.dart';

class ChangeLanguageAction extends PersistToStorage {
  final String languageCode;
  ChangeLanguageAction(this.languageCode);
}

class ToggleIsGuidesCompact extends PersistToStorage {}

class ToggleIsGenericTileCompact extends PersistToStorage {}

class ToggleShowMaterialTheme extends PersistToStorage {}

class HideRelease118Intro extends PersistToStorage {}

class HideValentines2020Intro extends PersistToStorage {}

class ToggleNMSFont extends PersistToStorage {}

class ToggleAltGlyphs extends PersistToStorage {}

class SetLastPlatformIndex extends PersistToStorage {
  final int lastPlatformIndex;
  SetLastPlatformIndex(this.lastPlatformIndex);
}

class ToggleIntroComplete extends PersistToStorage {}
