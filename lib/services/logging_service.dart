import 'package:logging/logging.dart';

class LoggingService {
  static void logMessage(String e, {Level? level}) {
    final logger = Logger('My Logger');
    logger.log(level ?? Level.INFO, e);
  }
}
