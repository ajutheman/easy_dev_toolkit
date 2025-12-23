import 'dart:async';
import 'package:flutter/foundation.dart';

/// A simple debouncer to limit the frequency of function execution.
class EasyDebounce {
  static final Map<String, Timer> _timers = {};

  /// Runs the [action] after the specified [duration].
  /// 
  /// If the same [tag] is provided before the timer expires, the previous
  /// timer is cancelled and a new one starts.
  static void run(String tag, Duration duration, VoidCallback action) {
    _timers[tag]?.cancel();
    _timers[tag] = Timer(duration, () {
      action();
      _timers.remove(tag);
    });
  }

  /// Cancels a pending debounce action.
  static void cancel(String tag) {
    _timers[tag]?.cancel();
    _timers.remove(tag);
  }
}

/// A simple throttler to ensure a function is not called more than once
/// within a specified duration.
class EasyThrottle {
  static final Map<String, bool> _active = {};

  /// Runs the [action] immediately if it hasn't been run within the last [duration].
  static void run(String tag, Duration duration, VoidCallback action) {
    if (_active[tag] == true) return;

    action();
    _active[tag] = true;
    Timer(duration, () => _active.remove(tag));
  }
}
