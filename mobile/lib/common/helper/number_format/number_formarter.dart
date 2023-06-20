class NumberFormatter {
  static String formatter(int currentBalance) {
    try {
      // suffix = {' ', 'k', 'M', 'B', 'T', 'P', 'E'};
      double value = currentBalance.toDouble();

      if (value < 1000) {
        // less than a thousand
        return value.toStringAsFixed(2);
      } else if (value >= 1000 && value < (1000 * 100 * 10)) {
        // less than a million
        double result = value / 1000;
        return '${result.toStringAsFixed(2)}K';
      } else if (value >= 1000000 && value < (1000000 * 10 * 100)) {
        // less than 100 million
        double result = value / 1000000;
        return '${result.toStringAsFixed(2)}M';
      } else if (value >= (1000000 * 10 * 100) &&
          value < (1000000 * 10 * 100 * 100)) {
        // less than 100 billion
        double result = value / (1000000 * 10 * 100);
        return '${result.toStringAsFixed(2)}B';
      } else if (value >= (1000000 * 10 * 100 * 100) &&
          value < (1000000 * 10 * 100 * 100 * 100)) {
        // less than 100 trillion
        double result = value / (1000000 * 10 * 100 * 100);
        return '${result.toStringAsFixed(2)}T';
      }
    } catch (e) {
      return '';
    }
    return '';
  }
}
