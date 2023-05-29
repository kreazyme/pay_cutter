extension StringExtension on String? {
  bool get isNullOrEmpty {
    if (this == null || this!.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
