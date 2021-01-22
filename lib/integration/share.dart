import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:share/share.dart';

shareApp(context) {
  Share.share(getTranslations().fromKey(LocaleKey.shareContent));
}
