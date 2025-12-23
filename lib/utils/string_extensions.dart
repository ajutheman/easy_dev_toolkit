/// Extensions for [String] to simplify common validation and formatting tasks.
extension StringExtensions on String {
  /// Returns `true` if the string is a valid email address.
  bool get isValidEmail {
    return RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    ).hasMatch(this);
  }

  /// Returns `true` if the string is a valid phone number (basic check).
  bool get isValidPhone {
    return RegExp(r'^\+?[0-9]{10,15}$').hasMatch(this);
  }

  /// Returns `true` if the string is a strong password.
  /// (At least 8 characters, 1 uppercase, 1 lowercase, 1 number, 1 special char)
  bool get isStrongPassword {
    return RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    ).hasMatch(this);
  }

  /// Capitalizes the first letter of the string.
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Converts the string to Title Case.
  String toTitleCase() {
    if (isEmpty) return this;
    return split(' ').map((str) => str.capitalize()).join(' ');
  }

  /// Returns `true` if the string is numeric.
  bool get isNumeric {
    return double.tryParse(this) != null;
  }

  /// Truncates the string if it's longer than [maxChars].
  String truncate(int maxChars) {
    if (length <= maxChars) return this;
    return '${substring(0, maxChars)}...';
  }
}

/// Extensions for nullable [String].
extension NullableStringExtensions on String? {
  /// Returns `true` if the string is null or empty.
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns `true` if the string is not null and not empty.
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
}
