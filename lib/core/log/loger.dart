import 'package:flutter/foundation.dart';

enum Level {
  wtf,
  error,
  warning,
  info,
  debug,
  verbose,
}

class Log {
  static final Log _singleton = Log._internal();

  /// Override this function if you want to convert a stacktrace for some reason
  /// for example to apply a source map in the browser.
  static StackTrace? Function(StackTrace?) stackTraceConverter = (s) => s;

  factory Log() {
    return _singleton;
  }

  Level level = Level.info;
  bool nativeColors = true;

  final List<LogEvent> outputEvents = [];

  Log._internal();

  void addLogEvent(LogEvent logEvent) {
    if(kReleaseMode){return;}
    outputEvents.add(logEvent);
    if (logEvent.level.index <= level.index) {
      logEvent.printOut();
    }
  }

  void wtf(String title, [Object? exception, StackTrace? stackTrace]) =>
      addLogEvent(
        LogEvent(
          title,
          exception: exception,
          stackTrace: stackTraceConverter(stackTrace),
          level: Level.wtf,
        ),
      );

  void e(String title, [Object? exception, StackTrace? stackTrace]) =>
      addLogEvent(
        LogEvent(
          title,
          exception: exception,
          stackTrace: stackTraceConverter(stackTrace),
          level: Level.error,
        ),
      );

  void w(String title, [Object? exception, StackTrace? stackTrace]) =>
      addLogEvent(
        LogEvent(
          title,
          exception: exception,
          stackTrace: stackTraceConverter(stackTrace),
          level: Level.warning,
        ),
      );

  void i(String title, [Object? exception, StackTrace? stackTrace]) =>
      addLogEvent(
        LogEvent(
          title,
          exception: exception,
          stackTrace: stackTraceConverter(stackTrace),
          level: Level.info,
        ),
      );

  void d(String title, [Object? exception, StackTrace? stackTrace]) {
    if(!kDebugMode) { return; }
    addLogEvent(
      LogEvent(
        title,
        exception: exception,
        stackTrace: stackTraceConverter(stackTrace),
        level: Level.debug,
      ),
    );
  }

  void v(String title, [Object? exception, StackTrace? stackTrace]) =>
      addLogEvent(
        LogEvent(
          title,
          exception: exception,
          stackTrace: stackTraceConverter(stackTrace),
          level: Level.verbose,
        ),
      );
}

// ignore: avoid_Logs().w
class LogEvent {
  final String title;
  final Object? exception;
  final StackTrace? stackTrace;
  final Level level;

  LogEvent(
      this.title, {
        this.exception,
        this.stackTrace,
        this.level = Level.debug,
      });

  void printOut() {
    var logsStr = title;
    if (exception != null) {
      logsStr += ' - ${exception.toString()}';
    }
    if (stackTrace != null) {
      logsStr += '\n${stackTrace.toString()}';
    }
    if (Log().nativeColors) {
      switch (level) {
        case Level.wtf:
          logsStr = '\x1B[31m!!!CRITICAL!!! $logsStr\x1B[0m';
          break;
        case Level.error:
          logsStr = '\x1B[31m$logsStr\x1B[0m';
          break;
        case Level.warning:
          logsStr = '\x1B[33m$logsStr\x1B[0m';
          break;
        case Level.info:
          logsStr = '\x1B[32m$logsStr\x1B[0m';
          break;
        case Level.debug:
          logsStr = '\x1B[34m$logsStr\x1B[0m';
          break;
        case Level.verbose:
          break;
      }
    }
    // ignore: avoid_Logs().w
    debugPrint('[ICM] $logsStr');
  }

}