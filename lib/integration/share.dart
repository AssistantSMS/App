import 'package:share/share.dart';

import '../localization/localeKey.dart';
import '../localization/translations.dart';

shareApp(context) {
  Share.share(Translations.get(context, LocaleKey.shareContent));
}
