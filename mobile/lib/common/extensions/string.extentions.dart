extension StringExtension on String? {
  bool get isNullOrEmpty {
    if (this == null || this!.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  String? get lastCharacter {
    if (this == null || this!.isEmpty) {
      return null;
    } else {
      return this!.substring(this!.length - 1);
    }
  }
}
