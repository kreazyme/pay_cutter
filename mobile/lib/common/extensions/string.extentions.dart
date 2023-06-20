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

  String get firstUpperCase {
    if (this == null || this!.isEmpty) {
      return '';
    } else {
      return this!.substring(0, 1).toUpperCase() + this!.substring(1);
    }
  }
}
