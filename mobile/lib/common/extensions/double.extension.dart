extension XDouble on double {
  double get toPositive => this < 0 ? this * -1 : this;
}
