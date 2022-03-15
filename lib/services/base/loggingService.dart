import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:talker/talker.dart';

class LoggerService implements ILoggerService {
  LoggerService() {
    Talker.instance.configure();
  }

  @override
  void v(String message) {
    Talker.instance.verbose(message);
  }

  @override
  void i(String message) {
    Talker.instance.info(message);
  }

  @override
  void d(String message) {
    Talker.instance.debug(message);
  }

  @override
  void e(String message) {
    Talker.instance.error(message);
  }
}
