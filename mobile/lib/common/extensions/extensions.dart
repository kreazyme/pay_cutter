extension XDateTime on DateTime {
  String toFullDayWeek() {
    List<String> dayData = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return '${dayData[weekday - 1]}, ${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year';
  }
}
