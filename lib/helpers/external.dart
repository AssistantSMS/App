import 'package:url_launcher/url_launcher.dart';
import '../integration/logging.dart';

launchExternalURL(String externalUrl) async {
  if (await canLaunch(externalUrl)) {
    await launch(externalUrl, enableJavaScript: true, forceSafariVC: false);
  } else {
    logger.e('Could not launch $externalUrl');
  }
}
