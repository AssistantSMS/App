import 'package:redux/redux.dart';

import '../setting/selector.dart';
import 'appState.dart';

class IntroViewModel {
  final bool isPatron;
  final String currentLanguage;

  IntroViewModel({
    required this.isPatron,
    required this.currentLanguage,
  });

  static IntroViewModel fromStore(Store<AppState> store) {
    try {
      return IntroViewModel(
        isPatron: getIsPatron(store.state),
        currentLanguage: getSelectedLanguage(store.state),
      );
    } catch (exception) {
      return IntroViewModel(
        isPatron: false,
        currentLanguage: 'en',
      );
    }
  }
}
