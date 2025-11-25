class EasyLog {
  static bool enabled = true;

  static void d(String message) {
    if (!enabled) return;
    // ignore: avoid_print
    print('💬 [EASY_DEV_LOG] $message');
  }

  static void e(String message, [Object? error, StackTrace? stackTrace]) {
    if (!enabled) return;
    // ignore: avoid_print
    print('❌ [EASY_DEV_ERROR] $message');
    if (error != null) {
      // ignore: avoid_print
      print('   error: $error');
    }
    if (stackTrace != null) {
      // ignore: avoid_print
      print('   stackTrace: $stackTrace');
    }
  }
}
