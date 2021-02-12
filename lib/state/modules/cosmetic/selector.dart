import '../base/appState.dart';

List<String> getOwned(AppState state) =>
    state?.cosmeticState?.owned ?? List.empty(growable: true);
