import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@singleton
class AppLogger {
  Logger? _logger;

  AppLogger() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        // number of methods calls to be displayed
        errorMethodCount: 8,
        // number of method calls if stacktrace is provided
        lineLength: 120,
        // width of the output
        colors: true,
        // Colorful log messages
        printEmojis: true,
        // Print an emoji for each log message
        printTime: true, // Should each log print contain a timestamp
      ),
    );
  }

  void verbose(dynamic message) {
    _logger!.v(message);
  }

  void debug(dynamic message) {
    _logger!.d(message);
  }

  void info(dynamic message) {
    _logger!.i(message);
  }

  void warning(dynamic message) {
    _logger!.w(message);
  }

  void error(dynamic message) {
    _logger!.e(message);
  }

  void fatalError(dynamic message) {
    _logger!.wtf(message);
  }
}
