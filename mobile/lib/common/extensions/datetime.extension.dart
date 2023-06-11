extension DatetimeExtension on DateTime? {
  String get fullDateTime12h {
    if (this == null) {
      return '';
    } else {
      return '${this!.day}/${this!.month}/${this!.year} ${this!.hour}:${this!.minute} ${this!.hour > 12 ? 'PM' : 'AM'}';
    }
  }

  String get fullDateTime24h {
    if (this == null) {
      return '';
    } else {
      return '${this!.day}/${this!.month}/${this!.year} ${this!.hour}:${this!.minute}';
    }
  }

  String get toPathString {
    if (this == null) {
      return '';
    } else {
      return '${this!.year}.${this!.month}.${this!.day}.${this!.hour}.${this!.minute}.${this!.second}';
    }
  }
}
